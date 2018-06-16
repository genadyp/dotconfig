import os, subprocess
from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autorun.sh'])

@hook.subscribe.client_new
def dialogs(window):
    if window.window.get_wm_type() == 'dialog' or window.window.get_wm_transient_for():
        window.floating = True

@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    qtile.cmd_restart()

