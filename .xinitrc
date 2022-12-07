#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

. $HOME/.profile

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec dbus-launch --sh-syntax --exit-with-session i3

# launcher=(dbus-launch --sh-syntax --exit-with-session)
# session=${1:-i3}
# case $session in
#     awesome        ) exec $launcher awesome ;;
#     bspwm          ) exec $launcher bspwm-session ;;
#     budgie         ) exec $launcher budgie-desktop ;;
#     cinnamon       ) exec $launcher cinnamon-session ;;
#     deepin         ) exec $launcher startdde ;;
#     enlightenment  ) exec $launcher enlightenment_start ;;
#     fluxbox        ) exec $launcher startfluxbox ;;
#     gnome          ) exec $launcher gnome-session ;;
#     i3|i3wm        ) exec $launcher i3 ;;
#     jwm            ) exec $launcher jwm ;;
#     kde            ) exec $launcher startplasma-x11 ;;
#     lxde           ) exec $launcher startlxde ;;
#     lxqt           ) exec $launcher lxqt-session ;;
#     mate           ) exec $launcher mate-session ;;
#     xfce           ) exec $launcher xfce4-session ;;
#     openbox        ) exec $launcher openbox-session ;;
#     *              ) exec $launcher $1 ;;
# esac

