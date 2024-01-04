#Archivo de inicio cuando no se tenga un DE 

#Iniciar los programas en Autostart
#exec dex -av -e LIGHTDM-XSESSION &
exec dex -av -e XFCE &
#exec xdg-autostart-launcher --both --verbose &

#Definir resolucion
#xrandr -s 1360x768

#Cargar colorschemes de WAL
#wal -R

#Iniciar WM
exec i3

