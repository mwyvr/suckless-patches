#!/bin/sh
# This script copies patch files for dwm/dmenu/st to ~/src/void-packages/srcpkgs/*/patches
# To setup void-packages:
# 	mkdir -p ~/src && cd ~/src
# 	git clone https://github.com/void-linux/void-packages
#   cd void-packages
# 	# Edit etc/defaults.conf appropriately:
#   # one of the Tier-1 US mirrors:
#   XBPS_MIRROR=https://repo-us.voidlinux.org/current
#   echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
#   ./xbps-src binary-bootstrap

OS_RELEASE=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"' | tr '[:upper:]' '[:lower:]')
SUCKLESS_PATCHES="$HOME/src/suckless-patches"
VOID_PACKAGES="$HOME/src/void-packages"

if [ $OS_RELEASE != "void" ]; then
    echo "This script only runs on Void Linux; use build-repo.sh for others."
    exit
fi

if ! command -v xi &>/dev/null; then
	echo "Installing Void's xbps helper, xtools..."
	sudo xbps-install -y xtools
fi

if [ -d $VOID_PACKAGES ]; then
	echo "Installing patch files for libXft-devel, st, dwm, demnu."
	echo "Build and install slstatus from the repo, not from void-packages"
	for ipkg in libXft-devel st dwm dmenu; do
		mkdir -p $VOID_PACKAGES/srcpkgs/$ipkg/patches
		echo "copying $SUCKLESS_PATCHES/$ipkg/$ipkg-solutionroute.diff to $VOID_PACKAGES/srcpkgs/$ipkg/patches"
		cp $SUCKLESS_PATCHES/$ipkg/$ipkg-solutionroute.diff $VOID_PACKAGES/srcpkgs/$ipkg/patches
	done
else
	echo "
**Can't proceed**
$HOME/src/void-packages does not exist! See the Quick Start at https://github.com/void-linux/void-packages."

fi

while true; do
	read -p "(re)Install patched applications [Yy]es,[Nn]o " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "

Patch files copied. To build the packages:

	cd $VOID_PACKAGES
	./xbps-src pkg <pkgname>
	# install xtools, very handy
	xi -f pkgname
	# or, if xtools not installed
	# ./xbps-install -f --repository hostdir/binpkgs <pkgname>
"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Building applications..."
cd $VOID_PACKAGES
for ipkg in libXft-devel st dwm dmenu; do
	echo "Building $ipkg"
	./xbps-src pkg $ipkg
	xi -f $ipkg
done

echo "
-------------------------------------------------
Build and install complete.
"
