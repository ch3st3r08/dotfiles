set -g @plugin 'dracula/tmux'

# available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, tmux-ram-usage, network, network-bandwidth, network-ping, ssh-session, attached-clients, network-vpn, weather, time, mpc, spotify-tui, playerctl, kubernetes-context, synchronize-panes
set -g @dracula-plugins "cpu-usage gpu-usage ram-usage"

# available colors: white, gray, dark_gray, light_purple, dark_purple, cyan, green, orange, red, pink, yellow
# set -g @dracula-[plugin-name]-colors "[background] [foreground]"
set -g @dracula-cpu-usage-colors "pink dark_gray"
set -g @dracula-show-powerline true
set -g @dracula-show-empty-plugins false
