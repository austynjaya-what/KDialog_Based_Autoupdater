#!/usr/bin/env bash
sudo touch static/mute.sh
sudo chmod 666 static/mute.sh
export XDG_RUNTIME_DIR="/run/user/1000"
export PULSE_SERVER="unix:/run/user/1000/pulse/native"
kdialog --title "Welcome to the Universal Autoupdater GUI" --msgbox  "Welcome to the Universal Autoupdater GUI \n This is a GUI Version of the universal autoupdater script designed by Austyn Jaya, this is a PROTOTYPE and should not be used generally \n Please contact Austyn Jaya for help! \n Click OK to continue!"
    ress=$(kdialog --title "Your Name" --inputbox "What is your name?")
if [[ $ress == "" ]] || [[ ${#ress} -lt 3 ]] ; then
    kdialog --title "Welp" --error "Defaulting to user as the name, please do enter a valid name next time"
    ress="User"
fi
echo "c=\"$ress\"" >> static/mute.sh
kdialog --title "Distro Selection" --msgbox "Please select your distro from the following list, if your distro is not listed, please contact the author for help" 
distro=$(kdialog --title "Distro Selection" --combobox "Select your distro" "Debian" "Ubuntu" "Fedora" "Arch" "Void Linux" "Kubuntu" "Manjaro")
case $distro in
    "Debian")
        control="deb"
        echo "d=$control" >> static/mute.sh
        kdialog --title "Distro Selection" --msgbox "You have selected Debian"
        ;;
    "Ubuntu")
        control="ubt"
        echo "d=$control" >>  static/mute.sh
        kdialog --title "Distro Selection" --msgbox "You have selected Ubuntu"
        ;;
    "Fedora")
        control="fed"
        echo "d=$control" >> static/mute.sh
        kdialog --title "Distro Selection" --msgbox "You have selected Fedora"
        ;;
    "Arch")
        control="arh"
        echo "d=$control" >> static/mute.sh
        kdialog --title "Distro Selection" --msgbox "You have selected Arch"
        ;;
    "Void Linux")
        control="vod"
        echo "d=$control" >> static/mute.sh
        kdialog --title "Distro Selection" --msgbox "You have selected Void Linux"
        ;;
    "Kubuntu")
        control="kub"
        echo "d=$control" >> static/mute.sh
        kdialog --title "Distro Selection" --msgbox "You have selected Kubuntu"
        ;;
    "Manjaro")
        control="man"
        echo "d=$control" >> static/mute.sh
        kdialog --title "Distro Selection" --msgbox "You have selected Manjaro"
        ;;
    *)
        kdialog --title "Error" --error "Invalid selection, Please reset the script and try again"
        exit 1
        ;;
esac
kdialog --title "Flatpak Support" --yesno "Do you want to enable Flatpak support?"
if [ $? = 0 ]; then
    kdialog --title "Flatpak Support" --msgbox "You have selected to enable flatpak support for this system.\nThis will allow flatpak packages to be updated in tandem with the system pacakges"
    echo "f=yes">> static/mute.sh
else
    kdialog --title "Flatpak Support" --msgbox "You have selected to disable flatpak support for this system.\nThis will prevent flatpak packages from being updated in tandem with the system pacakges"
    echo "f=no">> static/mute.sh
fi
kdialog --title "Setup complete" --msgbox "Setup Complete, You may now use the GUI Autoupdater version for your system! \n just run the script again and boom!"
sleep 2
kdialog --title "Bit of Credits" --msgbox "<b>Aspiring Programmers Make Aspiring programs</b>."
exit 0