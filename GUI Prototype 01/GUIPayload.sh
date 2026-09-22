#!/usr/bin/env bash
if [ "$USER" != "root" ]; then
    PASSWORD=$(kdialog --title "Administrator Access Required" --password "Please enter your sudo password:")
    if [ -z "$PASSWORD" ]; then
    kdialog --error "Password cannot be empty. Exiting."
    exit 1
    fi
    if echo "$PASSWORD" | sudo -S true 2>/dev/null; then
        kdialog --msgbox "Password correct! Continuing..."
    else
        kdialog --error "Incorrect password. Access denied."
    exit 1
    fi
fi
if [ ! -f "static/mute.sh" ]; then
kdialog --sorry "Configuration file N/A, Beginning setup process..."
sudo ./static/setup.sh
exit 0
fi
source static/mute.sh
kdialog --title "Autoupdater GUI" --msgbox "Welcome to the Autoupdater GUI, Created only by Austyn Jaya \n This is the first GUI Version I built for the system \n hope everyone enjoys!" --icon "static/Tux_paint_logo.png"
    while [ "$fk" != "4" ]; do
        fk=$(kdialog --title "Options" --radiolist "Select an Option:" 1 "Autoupdate the system" off 2 "Autoremove Unused Packages" off 3 "Credits" off 4 "Exit" off)
        case "$fk" in
            1)
                if [ "$d" = "deb" ] || [ "$d" = "ubt" ] || [ "$d" = "kub" ] ; then
                    kdialog --title "Autoupdate" --msgbox "You have chosen to Autoupdate the system, this will update your system and install all available updates"
                    sudo apt update && sudo apt-fast upgrade -y
                    kdialog --title "System Update Success" --msgbox "Successfully Updated the <b>apt system packages</b>"
                elif [ "$d" = "fed" ] ; then
                    kdialog --title "Autoupdate" --msgbox "You have chosen to Autoupdate the system, this will update your system and install all available updates"
                    sudo dnf update -y
                    kdialog --title "System Update Success" --msgbox "Successfully Updated the <b>dnf system packages</b>"
                elif [ "$d" = "arh" ] ; then
                    kdialog --title "Autoupdate" --msgbox "You have chosen to Autoupdate the system, this will update your system and install all available updates"
                    sudo pacman -Syu --noconfirm
                    kdialog --title "System Update Success" --msgbox "Successfully Updated the <b>pacman system packages</b>"
                elif [ "$d" = "vod" ] ; then
                    kdialog --title "Autoupdate" --msgbox "You have chosen to Autoupdate the system, this will update your system and install all available updates"
                    sudo xbps-install -Su
                    kdialog --title "System Update Success" --msgbox "Successfully Updated the <b>xbps system packages</b>"
                else
                    kdialog --title "Error" --error "Invalid selection, Please reset the script and try again"
                    exit 1
                fi
                if [ "$f" = "yes" ] ; then
                    kdialog --title "Flatpak Update" --msgbox "You have selected to update flatpak packages, this will update all flatpak packages on your system"
                    flatpak update -y
                    kdialog --title "Flatpak Update Success" --msgbox "Successfully Updated the <b>flatpak packages</b>"
                else
                    kdialog --title "Flatpak Update" --msgbox "Since you have disabled flatpak updates, we will not update flatpak packages for you"
                fi
                ;;
            2)
                if [ "$d" = "deb" ] || [ "$d" = "ubt" ] || [ "$d" = "kub" ] ; then
                    kdialog --title "Autoremove" --msgbox "You have chosen to Autoremove Unused Packages, this will remove all unused packages from your system"
                    sudo apt autoremove -y
                    kdialog --title "Autoremove Success" --msgbox "Successfully removed all <b>unused apt packages</b>"
                elif [ "$d" = "fed" ] ; then
                    kdialog --title "Autoremove" --msgbox "You have chosen to Autoremove Unused Packages, this will remove all unused packages from your system"
                    sudo dnf autoremove -y
                    kdialog --title "Autoremove Success" --msgbox "Successfully removed all <b>unused dnf packages</b>"
                elif [ "$d" = "arh" ] ; then
                    kdialog --title "Autoremove" --msgbox "You have chosen to Autoremove Unused Packages, this will remove all unused packages from your system"
                    sudo pacman -Rns $(pacman -Qtdq)
                    kdialog --title "Autoremove Success" --msgbox "Successfully removed all <b>unused pacman packages</b>"  
                elif [ "$d" = "vod" ] ; then
                    kdialog --title "Autoremove" --msgbox "You have chosen to Autoremove Unused Packages, this will remove all unused packages from your system"
                    sudo xbps-remove -O
                    kdialog --title "Autoremove Success" --msgbox "Successfully removed all <b>unused xbps packages</b>"
                else
                    kdialog --title "Error" --error "Invalid selection, Please reset the script and try again"
                    exit 1
                fi
                ;;
            3)
                kdialog --title "Credits" --textbox static/Credits.txt 600 600
                ;;
            4)
                kdialog --title "Exiting" --msgbox "Goodbye $c, Thank you for using the Autoupdater GUI."
                exit 0
                ;;
        esac
    done
