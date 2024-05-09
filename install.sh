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

#Add a workspace directory for ease of use for students.
#This also keeps notepad++ from trying to open all the files 
#in the users home directory.

if [[ ! -d ~/workspace ]]; then
	mkdir ~/workspace
	sleep 2
	tee ~/workspace/readme.txt << EOF
	Use the default save directory to save your work in Notepad++.

	In the ChromeOS 'Files' app you can find your work under the 'My Files/Linux Files/workspace' directory.

	Please copy files from that location to your Google Drive to ensure you do not lose your work should this 
	machine need repairs during the school year.  Thank you!
EOF
fi

#Verify notepad snap was installed
if [[ -f /var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus.desktop ]]; then 
	#Create a desktop icon
	sudo cp /var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus.desktop /var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus.desktop.old
	if [[ ! -f /usr/share/applications/notepad-plus-plus_notepad-plus-plus.desktop ]]; then
		sudo ln -s /var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus.desktop /usr/share/applications/
	fi
else
	echo "Notepad++ was not correctly installed.  Exiting script now!!"
	rm -rf ~/workspace
	exit 1
fi

#Write needed script to set xhost access and launch notepad++
#This is needed to set the xhost without chromeOS user needing to 
#Open a terminal session each login.
#We can only use sudo this way as the linux vm in chromeOS has no root password.
if [[ ! -f /opt/launch_notepad-plus-plus.sh ]]; then
	sudo tee /opt/launch_notepad-plus-plus.sh << EOF
	#!/bin/bash

	#set xhost access
	xhost +

	#launch notepad-plus-plus snap
	Exec=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus.desktop /snap/bin/notepad-plus-plus ~/workspace/readme.txt
EOF
	sudo chmod +x /opt/launch_notepad-plus-plus.sh
fi

#Verify the desktop shortcut was created
if [[ -f /usr/share/applications/notepad-plus-plus_notepad-plus-plus.desktop ]]; then
	# replace the Exec line to point to needed script that will set the xhost access everytime the notepad++ snap is ran from the chromeOS launcher
	sudo sed -i '/Exec/ s#=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/notepad-plus-plus_notepad-plus-plus\.desktop /snap/bin/notepad-plus-plus %F#=/opt/launch_notepad-plus-plus.sh#' /usr/share/applications/notepad-plus-plus_notepad-plus-plus.desktop
	_line=$(cat /usr/share/applications/notepad-plus-plus_notepad-plus-plus.desktop | grep Exec)
	if [[ $_line == "Exec=/opt/launch_notepad-plus-plus.sh" ]]; then
		echo "All complete.  Use the ChromeOS app drawer to find and run notepad++"
	else
		echo "Error writing the desktop file.  Contact your Technology Administrator.  Exiting now!"
		rm -rf ~/workspace
		exit 1
	fi
else
	echo "App Icon and shortcut was not created!! Exiting now!"
	exit 1
fi

sleep 5

kill -9 $PPID
