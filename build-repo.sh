#!/bin/sh
# https://github.com/solutionroute/suckless-patches
# 
# This script creates a build directory with dwm, dmenu, st, slstatus, applies
# existing patches, builds and installs all (on Arch) and only slstatus on Void.

OS_RELEASE=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"' | tr '[:upper:]' '[:lower:]')
HOSTNAME=`uname -n`
SCRIPT=`realpath -s $0`
SRCPATH=`dirname $SCRIPT`

if [ $(id -u) = 0 ]; then
    echo "Do NOT run this as sudo/root. Please read the script first."
    exit
fi
# try to ensure base-devel has been installed
for util in sudo git patch make gcc; do 
    if ! hash $util 2>/dev/null; then
        echo "$util is required but not installed. Please address."
        exit
    fi
done

echo "Linux distribution: $OS_RELEASE | Source path: $SRCPATH"

cd $SRCPATH
mkdir -p build
# clean up if used before
echo "Deleting build directory contents (if any): $(ls -x build)"
rm -rf build/*
cd build

# clone repos 
for pkg in slstatus dwm dmenu st; do 
    git clone https://git.suckless.org/$pkg
done 

# apply patches
for pkg in slstatus dwm dmenu st; do 
    cd $pkg 
    if [ $pkg == "slstatus" ]; then
        patch -Np1 < ../../slstatus/slstatus-$HOSTNAME.diff
    else
        patch -Np1 < ../../$pkg/$pkg-solutionroute.diff 
    fi
    cd ..  
done 

# make and install
for pkg in slstatus dwm dmenu st; do 
    cd $pkg
    make clean && make && sudo make install
    cd ..
    # only do the first (slstatus) via build-repo on Void Linux, use build-void for all others
    if [ $OS_RELEASE == "void" ]; then
        # For Void we're using the void-packages build system
        cd ..
        ./build-void.sh
        exit
    fi
done 

echo "Suckless tools build completed."

