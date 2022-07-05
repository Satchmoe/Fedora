#!/bin/bash

####################################################################################
#		Program: Install software and Fedora
#
#		Programmer: Chevelle
#		Date created: 3-2-2022
#		Date Updated: 7-5-2022
#
#		Update Notes:
#
#		Tested: With Fedora 36 = Worked
#
#		Note:
#
#		Purpose: Faster way to install/configure new Fedora Linux
#
#		Description: install Software
#
####################################################################################

function title_name {
	# function to add title format
	clear
	echo "------------------------------"
	echo "$1"
	echo "------------------------------"
	echo

}

############## Start ############################

title_name "Fedora Setup:"

############## install list #####################
while :
do

	title_name "Fedora Setup:"
	echo "Dont forget your VPN"
	echo
	echo "1 = Brave Browser..."
	echo "2 = Enable RPM Fusion and Flathub..."
	echo "3 = Needed Software..."
	echo "4 = Sublime Text..."
	echo "5 = Media Plugins..."
	echo "6 = Laptop Battery Optimizer..."
	echo "7 = Microsoft Fonts..."
	echo "8 = Atom Text Editor..."
	echo "9 = BalenaEtcher..."
	echo "10 = Clean up..."
	echo "11 = Firewalld Gui and Cockpit..."
	echo "12 = LibreWolf..."
	echo "13 = EXIT..."
	read b

		case $b in

			1)
				##### Brave-Browser #####

				title name "Brave-Browser"
				sudo dnf install dnf-plugins-core
				echo
				sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
				echo
				sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
				echo
				sudo dnf install brave-browser
				echo
				echo "Hit Enter to continue"
				read c

				;;
			2)
				##### Enableing RPM Fusion #####

				title_name "Enable RPM Fusion and Flathub"
				echo "Free Repository"
				sudo dnf install \
					https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
				echo
				echo "NonFree Repository"
				sudo dnf install \
					https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
				echo
				echo "Flathub Repository"
					flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
				echo "Hit Enter to continue"
				read c

				;;
			3)
				##### Software #####

				title_name "Install needed Software"
				sudo dnf install clamav clamtk terminator git vlc k4dirstat bleachbit clementine python3-pip bpytop gnome-software asunder
				echo
				echo "Hit Enter to continue"
				read c

				;;
			4)
				##### Sublime Text #####

				title_name "Install Sublime Text"
				echo
				echo "Add Repository Key"
				sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
				echo
				echo "Add Stable Repository"
				sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
				echo
				echo " Installing Sublime Text"
				sudo dnf install sublime-text
				echo
				echo "Hit Enter to continue"
				read c

				;;
			5)
				##### Media Plugins #####

				title_name "Install Media Plugins"
				sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
				echo
				sudo dnf install lame\* --exclude=lame-devel
				echo
				sudo dnf group upgrade --with-optional Multimedia
				echo
				echo "Hit Enter to continue"
				read c

				;;
			6)
				##### Battery Optimizer #####

				title_name "Install Laptop Battery Optimizer "
				#sudo add-apt-repository -y ppa:linuxuprising/apps
				#sudo apt update
				#-- install TLPUI
				#sudo apt install tlp tlpui python3-gi git python3-setuptools python3-stdeb dh-python stress
				#-- install auto-cpufreq
				git clone https://github.com/AdnanHodzic/auto-cpufreq.git
				cd auto-cpufreq && sudo ./auto-cpufreq-installer
				sudo auto-cpufreq --install
				echo
				echo "Dont forget to add TLPUI to the menu and check auto-cpufreq --stats"
				echo "Dont forget to do a stress test. exp(stress --cpu 8)"
				echo
				echo "Hit Enter to continue"
				read c

				;;
			7)
				##### Microsoft Fonts #####

				title_name "Microsoft Fonts"
				sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
				sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
				echo
				echo "Hit Enter to continue"
				read c

				;;
			8)
				##### Atom Text Editor #####

				title_name "Atom Text Editor"
				# Add Repository
				echo
				sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey
				echo
				sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'
				echo
				sudo dnf install atom
				echo
				echo "Hit Enter to continue"
				read c

				;;
			9)
				##### BalenaEtcher #####

				title_name "BalenaEtcher"
				# Add Repository
				curl -1sLf \
					'https://dl.cloudsmith.io/public/balena/etcher/setup.rpm.sh' \
					| sudo -E bash
				echo
				sudo dnf install balena-etcher-electron
				echo
				echo "Hit Enter to continue"
				read c

				;;
			10)
				##### Clean Up #####

				title_name "Clean Up"
				# removes packages that failed to install
				#sudo apt autoclean
				# removes apt-cache
				#sudo apt clean
				# removes unwanted software dependencies
				#sudo apt autoremove
				sudo dnf clean all
				echo
				echo "Hit Enter to continue"
				read c

				;;
			11)
				##### Firewaall Gui and Cockpit #####

				title_name "Firewalld Gui and Cockpit"
				echo 
				sudo dnf install firewall-config cockpit
				echo 
				sudo systemctl start --now cockpit.socket
				sudo systemctl enable --now cockpit.socket
				echo
				echo "Access Cockpit on https://localhost:9090."
				echo
				echo "Hit Enter to continue"
				read c	
				;;
			12)
				##### LibreWolf #####

				title_name "LibreWolf"
				# Add Repository
				sudo rpm --import https://keys.openpgp.org/vks/v1/by-fingerprint/034F7776EF5E0C613D2F7934D29FBD5F93C0CFC3
				sudo dnf config-manager --add-repo https://rpm.librewolf.net
				echo 
				sudo dnf install librewolf
				echo
				echo "Hit Enter to continue"
				read c	
				;;	
			13)
				#### Exit ####

				title_name "Good Bye!!!"
				exit

				;;

		esac

done
