# suckless patches
Patches customizing or adding functionality to suckless tools: dwm and dmenu. See: https://dwm.suckless.org/

There's a helper script for Void Linux users to move patch files into a local
`void-packages` repository so we can enjoy patch and build integration with
standard Void package management tools.

See also https://github.com/solutionroute/dotfiles.

## Important: Default Font is Roboto Mono

**Warning**

The suckless tool patches refer to the Roboto Mono font which is NOT part of
the Void fonts-roboto-ttf package. dwm and st will fail to run if you do not
have the font on your system.

Options:

- change patch to refer generic 'monospace' font,
- change the patch to point to your preference, or,
- install Roboto Mono, folloing these steps:

    sudo mkdir -p /usr/share/fonts/TTF
    sudo wget --content-disposition -P /usr/share/fonts/TTF \
        https://github.com/googlefonts/RobotoMono/blob/main/fonts/ttf/RobotoMono-{Bold,BoldItalic,Italic,Light,LightItalic,Medium,MediumItalic,Regular,Thin,ThinItalic}.ttf?raw=true

    # rebuild the cache
    sudo fc-cache
    # check to see:
    fc-list | grep -i roboto

## Patch Notes

## st

* terminal.sexy colours 
* Roboto Mono font, size 11
* add "scroll" (You'll need to clone, edit in mouse wheel lines in
  <https://git.suckless.org/scroll>, make && sudo make install)
* st.desktop for use with desktop environments; map keyboard shortcut
  alt-shift-enter to st for a pleasant experience in GNOME. :-) Note: I found I
  had to install `libxft-bgra` to stop crashing on GNOME but it very well may
  have been an issue on XOrg as well.

## dwm

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

## dmenu

* Implemented the same `bar_hpadx` configuration knob as in patched dwm. Patch: [dmenu-mw-barpad-20220212.diff](https://github.com/solutionroute/suckless-patches/blob/main/dmenu-mw-barpad-20220212.diff)

## slock

No patch; if using a compositor for transparency, prevent slock from becoming translucent with:

    # exclude dwm, dmenu and the slock screen locker
    focus-exclude = "x = 0 && y = 0 && override_redirect = true";

## Void Linux: void-packages patch and build integration:

`void-setup.sh` copies the latest patches into ~/src/void-packages/srcpkgs/{dwm|st|dmenu}. 

If you've not setup void-packages:

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

These are bland screenshots showing off "pertag"; I'm not 100% convinced I need pertag, 
but for a multi-monitor set of desktops, I definitely need "rnmaster" which gives the 
ability to toggle where the master pane goes, right or left.

![pertag - tag 1](https://raw.githubusercontent.com/solutionroute/suckless-patches/main/screenshots/pertag1.png)
**Tag 1**

![pertag - tag 2](https://raw.githubusercontent.com/solutionroute/suckless-patches/main/screenshots/pertag2.png)
**Tag 2**
 
And a boring big two monitor desktop:
![Boring "desktop"](https://raw.githubusercontent.com/solutionroute/suckless-patches/main/screenshots/20220104-172007.png)
