#!/bin/bash

set +e

# some env can't auto run the portal, so need this
/usr/lib/xdg-desktop-portal-wlr >/dev/null 2>&1 &

QT_WAYLAND_FORCE_DPI=96 dms run >/dev/null 2>&1 &

fcitx5 --replace -d >/dev/null 2>&1 &

# inhibit by audio
sway-audio-idle-inhibit >/dev/null 2>&1 &
