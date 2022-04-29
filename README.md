# suckless patches
This repo includes relatively minor tweaks, customizations and additions to
suckless tools: dwm, dmenu, st, slstatus (desktop & laptop variant) as well as
a patched libXft / libXft-devel to allow for BRGA colour emojies which would
crash st if not patched.

None of these patches are specific to Void Linux.

## Void Linux Script
`void-setup` moves patch files into the appropriate spot within the
`void-packages` repository (if you've set one up); check out void-packages, it
makes it easy to enjoy patch and build integration with standard Void package
management tools and keep up to date as new package updates roll in.

    ./void-setup.sh

The setup script first copies all the relevant patch files over and then
optionally will build all of them, starting with libXft-devel. You can break
out at any time.

See also https://github.com/solutionroute/dotfiles - the bin directory has a
git diff helper script to produce patch files from both tracked and untracked
files. From within a build directory:

    # one approach
    mkgitpatch.sh > "../dwm-mw-`git describe --tags`.diff"

Patch files manipulated are named <pkg>-sroute-<etc>.diff|$; see the script for why.

## Important: Default Font is simply "monospace"

You'll want/need to install a monospace font on your system that also modifies
the appropriate font config entries to establish itself as an available
monospace font for the system. Not all packages do. Deja Vu Sans Mono will do
the trick; add more from there.

## Patch Notes

### libXft-devel & libXft

Courtesy of the work done by https://github.com/uditkarode/libxft-bgra, a patch
file for libXft (current as of 2.3.4) to enable BGRA colour emojis; without
such a patch, colour symbols will crash `st` and other suckless apps.

There's no need to include the "font2" patch in st; but you should install a
colour emoji font such as:

    xbps-install noto-fonts-emoji

This patch should be built and installed first; depending on your distro you
may need to apply the same patch to libXft-devel.

## st

* terminal.sexy colours 
* alpha patch
* scroll shift-page up/down and mouse wheel / touchpad two fingers if configured as such
    * https://st.suckless.org/patches/desktopentry/ st-desktopentry-0.8.4.diff 
    * https://st.suckless.org/patches/scrollback/ st-scrollback-ringbuffer-0.8.5.diff and st-scrollback-mouse-20220127-2c5edf2.diff

### dwm

Combined patches rolled up into one diff: [dwm-mw-20220212.diff](https://github.com/solutionroute/suckless-patches/blob/main/dwm-mw-20220212.diff). 
The changes include adding some colours in support of colorbar, and:

* Made bar height padding a constant (`barpadpx`) in config.def.h (original
  default is 2, to my eye, somewhat larger font sizes look a bit crowded
  without a bit more space (4 or 6px).

* From suckless.org/patches/[pertag](https://dwm.suckless.org/patches/pertag/), 
  the ability to have different layouts for each tag.

* From suckless.org/patches/[rmaster](https://dwm.suckless.org/patches/rmaster/),
  making it possible to swap the master/client with a toggle, ideal for those
  of us with multi-head / dual monitors who like our master areas in the centre
  of our viewing space.

* From suckless.org/patches/[colorbar](https://dwm.suckless.org/patches/colorbar/),
  some changes that made my own bar customizations less hacky. My bar is pretty
  bland.  Blander, but only one colour, than the sock dwm!

### dmenu

* Implemented the same `bar_hpadx` configuration knob as in patched dwm. Patch: [dmenu-mw-barpad-20220212.diff](https://github.com/solutionroute/suckless-patches/blob/main/dmenu-mw-barpad-20220212.diff)

### slstatus

To have a different status bar on various machines, make or copy one of the
checked-in templates in ./slstatus and ensure there is only that file ending in
.diff.

Check in any changes by overwriting the appropriate .diff-less file or checking
in a new file.

### slock

No patch; if using a compositor such as picom for transparency, prevent slock
from becoming translucent with:

    # exclude dwm, dmenu and the slock screen locker
    focus-exclude = "x = 0 && y = 0 && override_redirect = true";

## Void Linux: void-packages patch and build integration:

`void-setup.sh` copies the latest patches into ~/src/void-packages/srcpkgs/{dwm|st|dmenu}. 

To setup void-packages:

	mkdir -p ~/src && cd ~/src
	git clone https://github.com/void-linux/void-packages
    cd void-packages

Configure your preferred mirror first, if the default server in Germany or
Finland is far from you. For example, to set the mirror `xbps-src` will use for
bootstrap and building packages, edit `etc/defaults.conf` (etc within the
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

## Obligatory Screenshot

These are bland screenshots showing off "pertag"; I'm not 100% convinced I need
pertag, but for a multi-monitor set of desktops, I definitely need "rnmaster"
which gives the ability to toggle where the master pane goes, right or left.

![pertag - tag 1](https://raw.githubusercontent.com/solutionroute/suckless-patches/main/screenshots/pertag1.png)
**Tag 1**

![pertag - tag 2](https://raw.githubusercontent.com/solutionroute/suckless-patches/main/screenshots/pertag2.png)
**Tag 2**
 
And a boring big two monitor desktop:
![Boring "desktop"](https://raw.githubusercontent.com/solutionroute/suckless-patches/main/screenshots/20220104-172007.png)
libXft-bgra-patch.diff
