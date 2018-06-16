#!/bin/env python

import json
import os

home = os.path.expanduser('~')
with open(home+'/.cache/wal/colors.json') as f:
    data = json.load(f)

theme_bg = data['special']['background']
theme_fg = data['special']['foreground']
theme_color0 = data['colors']['color0']
theme_color1 = data['colors']['color1']
theme_color2 = data['colors']['color2']
theme_color3 = data['colors']['color3']
theme_color4 = data['colors']['color4']
theme_color5 = data['colors']['color5']
theme_color6 = data['colors']['color6']
theme_color7 = data['colors']['color7']
theme_color8 = data['colors']['color8']
theme_color9 = data['colors']['color9']
theme_color10 = data['colors']['color10']
theme_color11 = data['colors']['color11']
theme_color12 = data['colors']['color12']
theme_color13 = data['colors']['color13']
theme_color14 = data['colors']['color14']
theme_color15 = data['colors']['color15']
