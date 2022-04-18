#!/bin/sh
# This script copies patch files for dwm/dmenu/st to ~/src/void-packages/srcpkgs/*/patches
SUCKLESS_PATCHES="$HOME/src/suckless-patches"
VOID_PACKAGES="$HOME/src/void-packages"

if [ -d $VOID_PACKAGES ]; then
	echo "Installing patch files"
	for ipkg in dwm dmenu st slstatus; do
		mkdir -p $VOID_PACKAGES/srcpkgs/$ipkg/patches
		echo "copying $SUCKLESS_PATCHES/$ipkg/* to $VOID_PACKAGES/srcpkgs/$ipkg/patches"
		cp $SUCKLESS_PATCHES/$ipkg/* $VOID_PACKAGES/srcpkgs/$ipkg/patches
	done

echo "
Patch files copied. To build the packages:

	cd $VOID_PACKAGES
	# pkgname = dwm or st or dmenu
	./xbps-src pkg pkgname
	# -f to force reinstallation 
	xi -f pkgname
"
else

	echo "
**Warning**
$HOME/src/void-packages does not exist! To setup void-packages:

	mkdir -p ~/src && cd ~/src
	git clone https://github.com/void-linux/void-packages
    cd void-packages

Configure your preferred mirror first, if the default server in Germany or
Finland is far from you. For example, to set the mirror xbps-src will use for
bootstrap and building packages, edit etc/defaults.conf (etc within the
void-packages directory):

    # one of the Tier-1 US mirrors:
    XBPS_MIRROR=https://repo-us.voidlinux.org/current

A list of mirrors can be found at <https://docs.voidlinux.org/xbps/repositories/mirrors/index.html>.

Finish preparing the void-packages local repository and enable restricted
packages in order to add applications like Zoom or Discord. 

Note: If running Void Linux musl variant (rather than glibc), proprietary
packages like Zoom or Google Chrome will need to be installed and run using
other methods such as a glibc chroot or perhaps more conviently for most
packages, flatpak.

    ./xbps-src binary-bootstrap
    echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
"
fi

