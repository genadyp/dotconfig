-- Standard awesome library {{{
local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local beautiful = require("beautiful")
                  require("beautiful.theme_assets")
local wibox = require("wibox")
local naughty = require("naughty")
local revelation = require("revelation")
local lain = require("lain")
-- }}}
-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}
-- {{{ Variable definitions
beautiful.init(awful.util.getdir("config") .. "themes/theme.lua")
revelation.init({tag_name = ""})

-- This is used later as the default terminal and editor to run.
terminal = "termite"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}
-- }}}
-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil
    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        for s = 1, screen.count() do
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end
end)
-- }}}
-- {{{ Wibar
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}
-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey, }, "e", revelation,
              {description = "Window list", group = "tag"}),
    awful.key({ modkey, }, "j", function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ modkey, }, "k", function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"}, ".", function () awful.client.swap.byidx(  1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"}, ",", function () awful.client.swap.byidx( -1) end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, }, ".", function () awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, }, ",", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey, }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({modkey, }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey, "Control"}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({modkey, "Mod1"}, "l", function () awful.spawn("i3lock -elu -c '#041016'") end,
              {description = "lock awesome", group = "awesome"}),
    awful.key({modkey, "Mod1"}, "p", function () awful.spawn("poweroff") end,
              {description = "Power Off system", group = "System"}),
    awful.key({modkey, "Mod1"}, "r", function () awful.spawn("reboot") end,
              {description = "Restart system", group = "System"}),
    awful.key({modkey, }, "l", function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({modkey, }, "h", function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({modkey, "Shift"}, "h", function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({modkey, "Shift"}, "l", function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({modkey, "Control"}, "h", function () awful.tag.incncol( 1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({modkey, "Control"}, "l", function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({modkey, }, "space", function () awful.layout.inc( 1) end,
              {description = "select next", group = "layout"}),
    awful.key({modkey, "Shift"}, "space", function () awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),
    awful.key({modkey, "Control"}, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),
    awful.key({modkey, }, "d",  function () awful.spawn("dmen.sh") end,
              {description = "run prompt", group = "launcher"}),
    awful.key({modkey, }, "b",
              function ()
                  myscreen = awful.screen.focused()
                  myscreen.mywibox.visible = not myscreen.mywibox.visible
              end, {description = "toggle statusbar", group = "misc"}),
    awful.key({modkey, }, "p", function () awful.spawn("monitor-select.sh") end,
              {description = "Monitor selection", group = "misc"}),
    awful.key({}, "XF86AudioRaiseVolume", function () awful.spawn("pactl set-sink-volume 0 +10%") end,
              {description = "Volume Up", group = "misc"}),
    awful.key({}, "XF86AudioLowerVolume", function () awful.spawn("pactl set-sink-volume 0 -10%") end,
              {description = "Volume Down", group = "misc"}),
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end)
)

clientkeys = awful.util.table.join(
    awful.key({modkey, }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({modkey, }, "x", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({modkey, "Control"}, "space",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({modkey, }, "o", function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({modkey, }, "t", function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({modkey, }, "n", 
              function (c) 
                  c.minimized = true 
              end,
        {description = "minimize", group = "client"}),
    awful.key({modkey, }, "m", 
              function (c)
                  c.maximized = not c.maximized
                  c:raise()
              end,
              {description = "(un)maximize", group = "client"}),
    awful.key({modkey, "Control"}, "m", function (c)
                   c.maximized_vertical = not c.maximized_vertical
                   c:raise() end,
              {description = "(un)maximize vertically", group = "client"}),
    awful.key({modkey, "Shift"}, "m", 
              function (c)
                  c.maximized_horizontal = not c.maximized_horizontal
                  c:raise()
              end,
              {description = "(un)maximize horizontally", group = "client"})
)
-- Bind all key numbers to tags.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({modkey}, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({modkey, "Control"}, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({modkey, "Shift"}, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({modkey, "Control", "Shift"}, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end
clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize))
-- Set keys
root.keys(globalkeys)
-- }}}
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },
    -- Floating clients.
    { rule_any = {
        instance = { "DTA", "copyq", },
        class = { "Arandr"},
        name = { "Event Tester", },
        role = { "AlarmWindow", "pop-up",     }
      }, properties = { floating = true }},
    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },
}
-- }}}
-- {{{ Signals
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
