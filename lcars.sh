#! /bin/bash

# LCARS - Library of Completely Arbitrary Random Scripts
version="0.4.5"

# Copyright 2008 Fabian A. Scherschel fabsh@lamerk.org
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Notes:
#  - Tested on Hardy, Intrepid & Mint 5
#  - FIXME: Currently we still have to acknowledge the Java EULA manually
#  - FIXME: We need regex for the trailing slash on the rsync source dir

# fabsh -- Tue, 18 Nov 2008 09:36:23 +0100

echo; echo
echo -e Welcome to '\E[32m'"\033[1mLCARS $version\033[0m"
echo
echo What would you like to do?
echo "1) Expand base installation with additional software packages"
echo "2) Install the latest development version of Wine"
echo "3) Perform a local backup"
echo "4) Unrar everything in a specific folder to your desktop"
echo "5) Exit"
echo; echo -n "Choice: " && read selection

if [ $selection == "1" ]
then
  echo; echo -e '\E[31m'"\033[1mWARNING!!!\033[0m"
  echo -e '\E[31m'"\033[1mThis is installing bad codecs and might be illegal in DMCA-land!\033[0m"
  echo; echo -e '\E[31m'"\033[1mAttention: This action needs root privileges\033[0m"
  sudo aptitude install adobe-flashplugin agave audacity banshee blender build-essential bzr cheese clamav clamav-freshclam community-themes conky create-resources curl deluge-torrent easytag enigmail figlet gnome-do gnome-do-plugins gparted gpodder grip hellanzb inkscape irssi lame memaker midori mozilla-mplayer msttcorefonts nmap postgresql python-django python-psycopg2 thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman thunderbird thunderbird-gnome-support terminator traceroute ubuntu-restricted-extras vlc;
  echo; echo -e Packages installed. Exiting '\E[32m'"\033[1mLCARS\033[0m". Goodbye...
elif [ $selection == "2" ]
then
  echo; echo -e '\E[31m'"\033[1mAttention: This action needs root privileges\033[0m"
  echo; echo Adding WineHQ repository keys...
  wget -q http://wine.budgetdedicated.com/apt/387EE263.gpg -O- | sudo apt-key add -
  echo; echo Adding WineHQ repository to apt sources...
  sudo wget http://wine.budgetdedicated.com/apt/sources.list.d/hardy.list -O /etc/apt/sources.list.d/winehq.list
  echo; echo Updating apt database...
  sudo aptitude update
  echo; echo Installing Wine...
  sudo aptitude install wine
  echo; echo -e Wine install complete. Exiting '\E[32m'"\033[1mLCARS\033[0m". Goodbye...
elif [ $selection == "3" ]
then
  echo; echo "Please specify source folder"
  echo Note: Everything below this folder will be recursively copied. Use a trailing slash here to preserve the original path at the destination.
  echo -n "Source: " && read srcdir
  echo "Please specify destination folder"
  echo -n "Destination: " && read destdir
  echo -en "Do you want to "; echo -en '\E[31m'"\033[1mdelete\033[0m"; echo -e " all files from the destination directory which currently aren't in the source directory?"
  echo -n "Delete extraneous files? [y/n]: " && read deleteorder
  if [ $deleteorder == "y" ]
  then
    rsync -avv --delete $srcdir $destdir
    echo; echo -e Backup complete. Exiting '\E[32m'"\033[1mLCARS\033[0m". Goodbye...
  else
    rsync -avv $srcdir $destdir
    echo; echo -e Backup complete. Exiting '\E[32m'"\033[1mLCARS\033[0m". Goodbye...
  fi
elif [ $selection == "4" ]
then
  echo "Please enter the full path to a directory. All rar files in all subdirectories below this destination will be unrared to your Desktop."
  echo -n "Path: " && read path
  echo "If you want to only unrar certain files, please specify a parameter now (this will be prefixed before the .rar for the individual files). If not, just press Enter."
  echo -n "Parameter: " && read para
  echo "Beginning file operations..."
  cd "$path"
  for x in *
    do
      cd "$x"
      for x in *$para.rar; do mkdir tmp && cd tmp && unrar e "../$x" && mv * ~/Desktop/ && cd .. && rm -rf tmp; done
      cd ..
  done
  echo; echo -e Extraction complete. Files have been moved to your desktop. Exiting '\E[32m'"\033[1mLCARS\033[0m". Goodbye...
elif [ $selection == "5" ]
then
  echo; echo -e Exiting '\E[32m'"\033[1mLCARS\033[0m". Goodbye...
else
  echo; echo -e Invalid selection. Exiting '\E[32m'"\033[1mLCARS\033[0m". Goodbye...
fi
echo; echo
