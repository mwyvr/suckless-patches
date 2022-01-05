# suckless
Patched suckless tools: dwm, dmenu and slock. See: https://dwm.suckless.org/

See also my corresponding https://github.com/solutionroute/dotfiles.

## dwm

My `config.h` personalizations [20220104-mw-dwm-config.h.diff](https://github.com/solutionroute/suckless/blob/main/patches/20220104-mw-dwm-config.h.diff)
apply to the patched `dwm` in this repo. Change summary:


* From suckless.org/patches/[rmaster](https://dwm.suckless.org/patches/rmaster/),
  making it possible to swap the master/client with a toggle, ideal for those
  of us with multi-head / dual monitors who like our master areas in the centre
  of our viewing space.

* From suckless.org/patches/[gaps](https://dwm.suckless.org/patches/gaps/),
  simple gaps between windows but not at the edges; I find a little gap helps
  to reduce the feeling of clutter on text heavy displays. Can set gap to 0 of
  course.

* From suckless.org/patches/[colorbar](https://dwm.suckless.org/patches/colorbar/),
  some changes that made my own bar customizations less hacky. My bar is pretty
  bland. 

* Made bar height padding a constant (`barpadpx`) in config.def.h (original
  default is 2, to my eye, somewhat larger font sizes look a bit crowded
  without a bit more space (4 or 6px).

## dmenu

* Implemented the same `barpadpx` configuration knob as in patched dwm. Patch:
  solutionroute/suckless/patches/[dmenu-barpadpx-20220104.diff](https://github.com/solutionroute/suckless/blob/main/patches/dmenu-barpadpx-20220104.diff)


## slock

Here's a three-line patch to add class hint ("slock") to make it easy for users
of compositors like `picom` to enforce opacity. Because... maybe a translucent
lock screen isn't a good idea for some of us. IMO this should be a mainline
change as it would allow `dwm`, `dmenu` and `slock` to behave the same with a
`picom` rule:

    opacity-rule = [ 
       "100:class_g = 'dwm'",   # window manager https://suckless.org/
       "100:class_g = 'dmenu'", # wm's application menu bar
       "100:class_g = 'slock'", # don't want a transparent lock screen! (patched version)

* Patch: solutionroute/suckless/patches/[slock-setclasshint-20220104-35633d4.diff](https://github.com/solutionroute/suckless/blob/main/patches/slock-setclasshint-20220104-35633d4.diff)

## slstatus

* [Minor personalization only](https://github.com/solutionroute/suckless/blob/main/patches/20220104-mw-slstatus-config.h.diff), I don't want a busy status bar. 

## Example .xinitrc & related

`.xinitrc`:

    # Dell 2719DG left on amdgpu, Dell 2720DC right on nvidia
    xrandr --output HDMI-A-1-0 --mode 2560x1440 --primary --output DP-4 --mode 2560x1440 --right-of HDMI-A-1-0

    # Following for VS Code persistent auth
    # see https://unix.stackexchange.com/a/295652/332452
    source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

    # see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
    eval $(/usr/bin/gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK

    # see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
    mkdir -p "$HOME"/.local/share/keyrings

    # Start dwm in a looping sh script makes customization easier
    exec ~/bin/startdwm.sh
    # exec dwm

`startdwm.sh` loop allows for restart of dwm (and supporting apps) without
losing open windows. `picom` in particular will barf on config file mistages.

    #!/bin/sh
    while true; do

        # clean up
        killall nitrogen picom slstatus xss-lock slock

        # wallpaper - https://wiki.archlinux.org/title/nitrogen
        exec nitrogen --restore &

        # compositor (adjust opacity in one app, not many)
        picom --config ~/.config/picom.conf  &

        # screen lock tied to ACPI autolocks my system in several minutes
        # dwm win+l and win|shift|l key bindings for on-demand lock and suspend
        xss-lock slock &

        slstatus &

        # dwm 2> ~/.dwm.log
        dwm >/dev/null 2>&1

    done

## Obligatory Screenshot

This is a bland screenshot, as bland is my objective. In practice, I use `dwm`
multiple desktops and move-to-tag feature (or auto window movement) to keep my
working desktop(s) simple and distraction free(ish).

![Boring "desktop"](https://raw.githubusercontent.com/solutionroute/suckless/main/screenshots/20220104-172007.png)
