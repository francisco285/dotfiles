-- vim: expandtab:shiftwidth=4:tabstop=4:softtabstop=4

-- TODO: Check out https://github.com/murilo-menezes/dotfiles

-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Default values for some options (this is useful when we need to temporarily
-- change some option, in order to, let's say, toggle gaps, borders, or something else)
local O = {
    border_width = 2,
    useless_gap = 5,
    gap_single_client = false,
    titlebars_enabled = false
}

-- Make sure awesome modules are installed
os.execute([[
if [ ! -d "$HOME/.config/awesome/nice" ]; then
    cd ~/.config/awesome && git clone https://github.com/mut-ex/awesome-wm-nice.git nice
    notify-send "AwesomeWM" "awesome-wm-nice module installed"
fi
if [ ! -d "$HOME/.config/awesome/awesome-wm-widgets" ]; then
    cd ~/.config/awesome && git clone https://github.com/streetturtle/awesome-wm-widgets
    notify-send "AwesomeWM" "awesome-wm-widgets module installed"
fi
]])

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "mytheme.lua")

terminal = os.getenv('TERMINAL')

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- }}}

local shell_command = awful.util.spawn_with_shell

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Documentation", function() shell_command([[$BROWSER 'awesomewm.org/doc']]) end },
    { "Edit Config", function() shell_command([[$TERMINAL nvim ~/.config/awesome/rc.lua]]) end },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
    { "Shut Down", function() shell_command("shutdown now") end }
}

mymainmenu = awful.menu({ items = { { "AwesomeWM", myawesomemenu, beautiful.awesome_icon },
                                    { "Terminal", function() shell_command("$TERMINAL") end }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.magnifier,
        awful.layout.suit.corner.nw,
        awful.layout.suit.floating,
    })
end)
-- }}}

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- TODO: Remove this as it is already covered by the `startup` script
-- screen.connect_signal("request::wallpaper", function(s)
--     -- Wallpaper
--     if beautiful.wallpaper then
--         local wallpaper = beautiful.wallpaper
--         -- If wallpaper is a function, call it with the screen
--         if type(wallpaper) == "function" then
--             wallpaper = wallpaper(s)
--         end
--         gears.wallpaper.maximized(wallpaper, s, true)
--     end
-- end)

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
    local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
    local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
    local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
    local cw = calendar_widget({ placement = 'top_right' })
    local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
    local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

    -- Create a textclock widget
    mytextclock = wibox.widget.textclock()

    mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

    -- Add widgets to the wibox
    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- volume_widget({ widget_type = 'icon', color = '#db4b4b' }),
            volume_widget(),
            batteryarc_widget({
                warning_msg_position = 'bottom_right',
                show_notification_mode = 'on_click',
                arc_thickness = 4
            }),
            ram_widget(),
            cpu_widget(),
            -- logout_menu_widget({ onlock = function() awful.spawn.with_shell([[notify-send 'Cool' 'It Works!']]) end }),
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox
        }
    }

end)
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "slash",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    -- TODO: Replace this keybinding because it's used to switch to previous tag
    -- awful.key({ modkey }, "p", function() menubar.show() end,
    --           {description = "show the menubar", group = "launcher"}),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "p",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "n",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({modkey}, "r", function()
        awful.prompt.run {
            prompt = "New tag name: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = function(new_name)
                if not new_name or #new_name == 0 then return end
                local t = awful.screen.focused().selected_tag
                if t then
                    t.name = new_name
                end
            end
        }
    end, { description = "rename tag", group = "tag" })
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    -- TODO: Replace these keys because they're used to focus by direction
    -- awful.key({ modkey,           }, "j",
    --     function ()
    --         awful.client.focus.byidx( 1)
    --     end,
    --     {description = "focus next by index", group = "client"}
    -- ),
    -- awful.key({ modkey,           }, "k",
    --     function ()
    --         awful.client.focus.byidx(-1)
    --     end,
    --     {description = "focus previous by index", group = "client"}
    -- ),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey,           }, "]", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,           }, "[", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    -- TODO: Replace this keybinding because it's used to switch to next tag
    -- awful.key({ modkey,           }, "n",
    --           function ()
    --               local c = awful.client.restore()
    --               -- Focus restored client
    --               if c then
    --                 c:activate { raise = true, context = "key.unminimize" }
    --               end
    --           end,
    --           {description = "restore minimized", group = "client"}),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    -- TODO: Replace these keys because they're used to swap the current window
    -- with the window on the right/left
    -- awful.key({ modkey, "Alt"     }, "l", function () awful.client.swap.byidx(  1)    end,
    --           {description = "swap with next client by index", group = "client"}),
    -- awful.key({ modkey, "Alt"     }, "h", function () awful.client.swap.byidx( -1)    end,
    --           {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    -- TODO: Replace these keys because they're used to focus right/left window
    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),
    -- TODO: Replace these keys because they're used to decrease/increase width
    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})

-- Toggle
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "g",     function()
        if beautiful.useless_gap == 0 then
            beautiful.useless_gap = O.useless_gap
            beautiful.gap_single_client = true
        else
            beautiful.useless_gap = 0
            beautiful.gap_single_client = false
        end
    end, {description = "toggle gap", group = 'client'}),

    awful.key({ modkey, "Control" }, "b",     function()
        if beautiful.border_width == 0 then
            beautiful.border_width = O.border_width
        else
            beautiful.border_width = 0
        end
    end, {description = "toggle border", group = 'client'}),

    awful.key({ modkey, "Control" }, "f",     function()
        local s = awful.screen.focused()
        s.mywibox.visible = not s.mywibox.visible
    end, {description = "toggle bar", group = 'screen'}),
})

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local index = index == 0 and 10 or index
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local index = index == 0 and 10 or index
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local index = index == 0 and 10 or index
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Mod1" },
        keygroup    = "numrow",
        description = "move focused client to tag and focus the tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local index = index == 0 and 10 or index
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local index = index == 0 and 10 or index
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                local index = index == 0 and 10 or index
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

-- VI-like keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "h", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "j", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "k", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "l", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end
    end),

    awful.key({ modkey, "Mod1"     }, "h", function (c)
        awful.client.swap.global_bydirection("left")
        c:raise()
    end),
    awful.key({ modkey, "Mod1"     }, "j", function (c)
        awful.client.swap.global_bydirection("down")
        c:raise()
    end),
    awful.key({ modkey, "Mod1"     }, "k", function (c)
        awful.client.swap.global_bydirection("up")
        c:raise()
    end),
    awful.key({ modkey, "Mod1"     }, "l", function (c)
        awful.client.swap.global_bydirection("right")
        c:raise()
    end)
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey,           }, "BackSpace",      function (c) c:kill() end,
                {description = "close", group = "client"}),
        awful.key({ modkey,           }, "s",  awful.client.floating.toggle,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey,           }, "g", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),

        -- awful.key({ modkey,           }, "o",      function (c) c:move_to_screen() end,
        --         {description = "move to screen", group = "client"}),
        awful.key({ modkey, "Mod1" }, "bracketleft",      function (c) c:move_to_screen(c.screen.index-1) end,
                {description = "move to previous screen", group = "client"}),
        awful.key({ modkey, "Mod1" }, "bracketright",      function (c) c:move_to_screen(c.screen.index+1) end,
                {description = "move to next screen", group = "client"}),

        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end,
                {description = "toggle keep on top", group = "client"}),
        -- TODO: Replace this keybinding because it's used to switch to next tag
        -- awful.key({ modkey,           }, "n",
        --     function (c)
        --         -- The client currently has the input focus, so it cannot be
        --         -- minimized, since minimized clients can't have the focus.
        --         c.minimized = true
        --     end ,
        --     {description = "minimize", group = "client"}),
        -- TODO: Replace this keybinding because it is already used in sxhkd
        -- awful.key({ modkey,           }, "m",
        --     function (c)
        --         c.maximized = not c.maximized
        --         c:raise()
        --     end ,
        --     {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        -- TODO: Replace this keybinding because it is already used in sxhkd
        -- awful.key({ modkey, "Shift"   }, "m",
        --     function (c)
        --         c.maximized_horizontal = not c.maximized_horizontal
        --         c:raise()
        --     end ,
        --     {description = "(un)maximize horizontally", group = "client"}),
    })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
-- Use xprop and click on a window to see its WM_CLASS value
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            -- border_width = 2,
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer", "feh"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Enable/Disable titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = O.titlebars_enabled      }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)

-- }}}

-- Make it so floating windows are by default placed on the center of the screen
-- instead of a random position
-- "request::manage" --> When a floating window is created
-- "property::floating" --> When a window is set to floating
-- https://www.reddit.com/r/awesomewm/comments/ic7vqt/center_floating_windows_on_screen/
for _, value in ipairs({ "request::manage", "property::floating" }) do
    client.connect_signal(value, function(c)
        if c.floating then
            awful.placement.centered(c, nil)
        end
    end)
end

-- -- Show titlebar when the window is floating
-- -- Hide titlebar when the window is not floating
-- -- https://www.reddit.com/r/awesomewm/comments/bki1md/show_titlebar_only_when_window_is_floating/
-- for _, value in ipairs({ "request::manage", "property::floating" }) do
--     client.connect_signal(value, function(c)
--         if c.floating then
--             awful.titlebar.show(c)
--         else
--             awful.titlebar.hide(c)
--         end
--     end)
-- end

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(c).widget = {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

-- Extra things

-- Use correct status icon size
awesome.set_preferred_icon_size(32)

-- Initial value for gaps
beautiful.useless_gap = 0
beautiful.gap_single_client = false

-- Initial value for borders
beautiful.border_width = 0

-- Enable/Disable borders
client.connect_signal("focus", function(c) c.border_color = "#7199FF" end)
client.connect_signal("unfocus", function(c) c.border_color = "#30302f" end)

-- local nice = require("nice")
-- nice({
--     titlebar_items = {
--         left = { "sticky", "ontop", "floating" },
--         middle = "title",
--         right = { "maximize", "minimize", "close" },
--     }
-- })

-- require('mouse_follow_focus')

-- https://www.reddit.com/r/awesomewm/comments/gehk1g/cursor_follows_focus_possible/fpnpmaq/
local function move_mouse_onto_focused_client()
    local c = client.focus
    gears.timer( {  timeout = 0.1,
    autostart = true,
    single_shot = true,
    callback =  function()
        if mouse.object_under_pointer() ~= c then
            local geometry = c:geometry()
            local x = geometry.x + geometry.width/2
            local y = geometry.y + geometry.height/2
            mouse.coords({x = x, y = y}, true)
        end
    end } )
end

client.connect_signal("focus", move_mouse_onto_focused_client)
client.connect_signal("swapped", move_mouse_onto_focused_client)

-- Startup applications
awful.util.spawn_with_shell("startup")
