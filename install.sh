#!/bin/bash
#########################
#20240502 Script to install and setup Notepad++ on ChromeOS
#########################


# Install needed apt packages
echo "Now going to install needed packages"
sleep 3
sudo apt update
sudo apt install libsquashfuse0 squashfuse fuse snapd -y

#Install needed snap packages
echo "Now going to install needed snap packages"
sleep 3

sudo snap install core notepad-plus-plus

#Set the xhost connection
xhost +

#Verify notepad snap was installed
if [[ -f /var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus.desktop ]]; then 
	#Create a desktop icon
	sudo cp /var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus.desktop /usr/share/applications/
else
	echo "Notepad++ was not correctly installed.  Exiting script now!!"
	exit 1
fi

#Verify the desktop shortcut was created

if [[ -f /usr/share/applications/notepad-plus-plus_notepad-plus-plus.desktop ]]; then
	echo "All complete.  Use app drawer to find and run notepad++"
else
	echo "\n\n\nApp Icon and shortcut was not created!! Exiting now!"
	exit 1
fi

sleep 5

kill -9 $PPID
