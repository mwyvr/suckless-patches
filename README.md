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

Here's a two-line patch to add class hint ("slock") to make it easy for users
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

## Obligatory Screenshot

Here's a pretty bland screenshot, but do remember, bland was my objective. In practice, I use the multiple desktops and tag feature to move windows to keep my working desktop simple to remove distraction. 

![Boring "desktop"](https://raw.githubusercontent.com/solutionroute/suckless/main/screenshots/20220104-172007.png)
