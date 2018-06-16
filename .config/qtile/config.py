from libqtile import layout, bar, widget
from libqtile.config import Screen
from libqtile.command import lazy
from keys import keys, groups
from theme import *
from hooks import *

layouts = [
    layout.bsp.Bsp(border_focus=theme_color1, margin=3, border_width=1),
    layout.Max(),
]

widget_defaults = dict(font='FontAwesome:style=Regular', fontsize=12, padding=3)
extension_defaults = widget_defaults.copy()

bar_widgets = [
    widget.GroupBox(),
    widget.Prompt(),
    widget.WindowName(),
    widget.KeyboardLayout(configured_keyboards=['us', 'se']),
    widget.Sep(linewidth=2),
    widget.Clock(format='w%V %a %d %H:%M'),
    widget.Sep(linewidth=2),
    widget.CurrentLayoutIcon(scale=0.60),
    widget.Systray(),
    widget.Sep(linewidth=2),
    widget.Battery()
]

screens = [
    Screen(bottom=bar.Bar(widgets=bar_widgets, background=theme_bg, size=24)),
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = False
focus_on_window_activation = "smart"
wmname = "LG3D"
