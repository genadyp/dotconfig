from libqtile.config import Key, Group, Drag, Click
from libqtile.command import lazy

mod = "mod4"

keys = [
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),

    Key([mod], "Return", lazy.spawn("termite")),
    Key([mod], "space", lazy.next_layout()),

    Key([mod], "x", lazy.window.kill()),
    Key([mod, "mod1"], "p", lazy.spawn("poweroff")),
    Key([mod, "mod1"], "r", lazy.spawn("/usr/bin/reboot")),
    Key([mod, "mod1"], "Delete", lazy.spawn("i3lock -elu -c '#121515'")),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "d", lazy.spawn("rofi -show run -lines 3 -width 20 -opacity 25")),
    Key([mod], "w", lazy.spawn("rofi -show window -lines 3 -width 20 -opacity 25")),

    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pactl set-sink-volume 0 +10%')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pactl set-sink-volume 0 -10%')),
]

groups = [Group(idx) for idx in "12345"]
for grp in groups:
    keys.extend([
        Key([mod], grp.name, lazy.group[grp.name].toscreen()),
        Key([mod, "shift"], grp.name, lazy.window.togroup(grp.name)),
    ])

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

