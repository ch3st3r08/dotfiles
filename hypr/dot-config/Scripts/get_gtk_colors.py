#!/usr/bin/env python3

import re
import os
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk, Gio   # noqa: E402

TARGET_VARS = [
    "theme_fg_color",
    "theme_text_color",
    "theme_bg_color",
    "theme_base_color",
    "theme_selected_bg_color",
    "theme_selected_fg_color",
    "fg_color",
    "text_color",
    "bg_color",
    "base_color",
    "selected_bg_color",
    "selected_fg_color",
    "borders",
    "unfocused_borders",
]

DEFAULT_HEX = "ffffffff"  # white opaque


def to_rrggbbaa(color_str):
    color_str = color_str.strip().lower()

    if color_str == "currentcolor":
        color_str = "white"

    rgba = Gdk.RGBA()
    if rgba.parse(color_str):
        r = int(round(rgba.red * 255))
        g = int(round(rgba.green * 255))
        b = int(round(rgba.blue * 255))
        a = int(round(rgba.alpha * 255))
        return f"{r:02x}{g:02x}{b:02x}{a:02x}"

    return DEFAULT_HEX


def read_css_file(path, visited=None):
    if visited is None:
        visited = set()

    colors = {}

    if not os.path.isfile(path):
        return colors

    abs_path = os.path.abspath(path)
    if abs_path in visited:
        return colors
    visited.add(abs_path)

    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        css = f.read()

    for match in re.findall(r'@import\s+url\(["\']?(.*?)["\']?\)\s*;', css):
        if match.startswith("resource:///"):
            resource_path = match[len("resource:///") :]
            provider = Gtk.CssProvider()
            try:
                provider.load_from_resource("/" + resource_path)
                data = provider.to_string()
                tmp_path = f"/tmp/{os.path.basename(resource_path)}"
                with open(tmp_path, "w", encoding="utf-8") as tmpf:
                    tmpf.write(data)
                colors.update(read_css_file(tmp_path, visited))
            except Exception as e:
                print(f"Failed to load resource {resource_path}: {e}")
        else:
            import_path = os.path.join(os.path.dirname(path), match)
            colors.update(read_css_file(import_path, visited))

    for var, value in re.findall(r'@define-color\s+([\w-]+)\s+([^;]+);', css):
        if var in TARGET_VARS:
            rgba_hex = to_rrggbbaa(value)
            colors[var] = rgba_hex

    return colors


def extract_gresource_css(gres_path):
    css_contents = []
    resource = Gio.Resource.load(gres_path)
    Gio.resources_register(resource)
    for path in resource.enumerate_children("/", Gio.ResourceLookupFlags.NONE):
        if path.endswith(".css"):
            data = resource.lookup_data("/" + path, Gio.ResourceLookupFlags.NONE)
            css_contents.append(data.get_data().decode("utf-8"))
    return "\n".join(css_contents)


def load_theme_css(theme_path):
    css_data = []
    for root, dirs, files in os.walk(theme_path):
        for f in files:
            if f.endswith(".css"):
                with open(os.path.join(root, f), "r", encoding="utf-8") as fh:
                    css_data.append(fh.read())
            elif f.endswith(".gresource") or f.endswith(".gtk.gresource"):
                css_data.append(extract_gresource_css(os.path.join(root, f)))
    return "\n".join(css_data)


def main():
    settings = Gtk.Settings.get_default()
    theme_name = settings.get_property("gtk-theme-name")

    theme_dirs = [
        os.path.expanduser("~/.themes"),
        os.path.expanduser("~/.local/share/themes"),
        "/usr/share/themes",
    ]

    found_path = None
    for base in theme_dirs:
        candidate = os.path.join(base, theme_name, "gtk-3.0", "gtk.css")
        if os.path.isfile(candidate):
            found_path = candidate
            break

    if not found_path:
        print(f"Theme '{theme_name}' gtk.css not found.")
        return

    colors = read_css_file(found_path)

    for var in TARGET_VARS:
        if var not in colors:
            colors[var] = DEFAULT_HEX

    """Main function to orchestrate the color replacement."""
    # File paths
    css_file = os.path.expandvars("$HOME/.config/rofi/themes/gtk/gtk-base.rasi")
    hypr_file = os.path.expandvars("$HOME/.config/hypr/includes.conf")

    print(f"Updating CSS file: {css_file}")
    print(f"Updating Hypr config file: {hypr_file}")

    # # Parse the config file
    # colors = parse_config_file(config_file)

    # Print found colors
    print("\nFound colors:")
    for key, value in colors.items():
        print(f"  {key}: {value}")

    # Define the mapping from config file properties to CSS properties
    color_mappings = {}
    bg3_color = None

    # Map theme_selected_bg_color to bg3
    if 'theme_selected_bg_color' in colors:
        bg3_color = colors['theme_selected_bg_color']
        color_mappings['bg3'] = bg3_color
        print(f"\nMapping theme_selected_bg_color ({bg3_color}) -> bg3")
    else:
        print("Warning: theme_selected_bg_color not found in config file")

    # Map theme_bg_color to bg0
    if 'theme_bg_color' in colors:
        color_mappings['bg0'] = colors['theme_bg_color']
        print(f"Mapping theme_bg_color ({colors['theme_bg_color']}) -> bg0")
    else:
        print("Warning: theme_bg_color not found in config file")

    # Apply CSS replacements if we have any mappings
    css_success = False
    if color_mappings:
        print("\n=== CSS FILE PROCESSING ===")
        css_success = replace_rofi_values(css_file, color_mappings)
    else:
        print("No CSS color mappings to apply.")

    # Apply Hypr config replacement if we have bg3 color
    hypr_success = False
    if bg3_color:
        print("\n=== HYPR CONFIG FILE PROCESSING ===")
        hypr_success = replace_hypr_config(hypr_file, bg3_color)
    else:
        print("No bg3 color available for Hypr config replacement.")

    # Final summary
    print("\n=== SUMMARY ===")
    if css_success:
        print("✅ CSS file updated successfully")
    else:
        print("❌ CSS file update failed or skipped")

    if hypr_success:
        print("✅ Hypr config file updated successfully")
    else:
        print("❌ Hypr config file update failed or skipped")
    # Use colors as a source for the next step
    # with open("gtk3_theme_colors.txt", "w") as f:
    #     for var in TARGET_VARS:
    #         f.write(f"{var}: {colors[var]}\n")
    #
    # print("GTK 3 theme colors saved to gtk3_theme_colors.txt")


def replace_hypr_config(hypr_path, bg3_color, output_path=None):
    """Replace the first rgba value in the hypr config file with bg3 color."""
    if output_path is None:
        output_path = hypr_path

    try:
        with open(hypr_path, 'r') as file:
            content = file.read()
    except FileNotFoundError:
        print(f"Error: Hypr config file '{hypr_path}' not found.")
        return False
    except Exception as e:
        print(f"Error reading hypr config file: {e}")
        return False

    # Convert hex color to rgba format (assuming full opacity)
    # Remove any existing 'ff' alpha if present, then add 'ff'
    clean_color = bg3_color.replace('ff', '') if bg3_color.endswith('ff') else bg3_color
    rgba_color = f"rgba({clean_color}ff)"

    # Pattern to match the first rgba value in the $hypr-color line
    pattern = r'(\$hypr-color=\s*)rgba\([^)]+\)'
    replacement = rf'\g<1>{rgba_color}'

    # Check if the pattern exists before replacement
    if re.search(pattern, content):
        content = re.sub(pattern, replacement, content)

        # Write the modified content back
        try:
            with open(output_path, 'w') as file:
                file.write(content)
            print(f"Successfully replaced first rgba in hypr config: {rgba_color}")
            print(f"Updated hypr config saved to: {output_path}")
            return True
        except Exception as e:
            print(f"Error writing hypr config file: {e}")
            return False
    else:
        print("Warning: $hypr-color line not found in hypr config file")
        return False


def replace_rofi_values(css_path, color_mappings, output_path=None):
    """Replace multiple CSS color values based on the provided mappings."""
    if output_path is None:
        output_path = css_path
    try:
        with open(css_path, 'r') as file:
            content = file.read()
    except FileNotFoundError:
        print(f"Error: CSS file '{css_path}' not found.")
        return False
    except Exception as e:
        print(f"Error reading CSS file: {e}")
        return False
    replacements_made = []

    # Replace each CSS property with its corresponding color value
    for css_property, new_value in color_mappings.items():
        # Pattern to match CSS property line - more specific pattern
        pattern = rf'(\s*{re.escape(css_property)}\s*:\s*#)[a-fA-F0-9]+(\s*;)'
        replacement = rf'\g<1>{new_value}\g<2>'

        # Check if the pattern exists before replacement
        if re.search(pattern, content):
            content = re.sub(pattern, replacement, content)
            replacements_made.append(f"{css_property} -> #{new_value}")
        else:
            print(f"Warning: CSS property '{css_property}' not found in file")

    # Report results
    if not replacements_made:
        print("Warning: No CSS properties were found or replaced.")
    else:
        print("Successfully replaced in CSS:")
        for replacement in replacements_made:
            print(f"  {replacement}")

    # Write the modified content back
    try:
        with open(output_path, 'w') as file:
            file.write(content)
        print(f"Updated CSS saved to: {output_path}")
        return True
    except Exception as e:
        print(f"Error writing CSS file: {e}")
        return False


if __name__ == "__main__":
    main()
