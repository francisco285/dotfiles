-- https://bitbucket.org/grumph/home_config/src/afdeb425c2cdfee045d3d91f250129d8036a1f53/.config/awesome/mouse_follow_focus.lua

--
-- I want mouse follow focus when:
--  * changing focus
--  * changing tag
--  * swapping clients
--  * add/remove a client (new, minimizing, raising, ...)
-- And I don't want to move the mouse when:
--  * moving/resizing with mouse
--  * raising a client with the mouse (clicking the tasklist)
--  * a client is raising on another tag

-- Some explanations of the code:
-- When moving the mouse, I check that it is not on the wibar (I'm probably using it), and not already
-- on the focused client (it's too anoying), and some other obvious checks.
--
-- I move the mouse on raised signal, because doing so with the focus signal is not compatible with the
-- "focus follow mouse" behaviour.
--
-- When switching tags, there is no raised signal, only focus so I added a step, on tag::history::update
-- screen signal ask for the next client with focus gets the mouse.
--
-- When you swap clients, there are 2 swapped signals sent, one for each client, with the is_source
-- parameter changing.
-- BUT (yes, big "but" !), when the swapped signal is sent, the clients did not actually swap yet,
-- and the focused client position is still the old one. Easy, you just have to send the mouse to the other
-- client then ... and then the "focus follows mouse" comes into action and the other client is now the focused one.
-- To fix that, I added a timer of a few miliseconds when moving the cursor so
-- that when it does, the client was actually moved and there is no "focus follow mouse" problem.
--
-- For add or remove a client, there are a lot of swapped signals sent, you don't actually need to check for the
-- is_source parameter like I initially did.
--


local gears = require "gears"
local awful = require "awful"

function is_client_on_current_tag(c)
   for _, mouse_tag in ipairs(mouse.screen.selected_tags) do
      for _, client_tag in ipairs(c:tags()) do
         if client_tag == mouse_tag then
            return true
         end
      end
   end
   return false
end

function move_mouse_to_client(c, skip_mouse_check)
   c = c or client.focus
   local mcc = mouse.current_client

   -- io.stderr:write(debug.traceback())

   if mcc ~= nil                                     -- disable for toolbars clicks
      and (skip_mouse_check
              or (not mouse.is_left_mouse_button_pressed
                     and c ~= mcc                    -- disable when mouse is already inside client
      ))
      and is_client_on_current_tag(c)
      and c.type == "normal"
   then
      -- io.stderr:write(" ** Move mouse to " .. tostring(c) .. "\n")
      -- io.stderr:write("mcc = " .. tostring(mcc) .. " - focused = "..tostring(client.focus).."\n")
      gears.timer({
            timeout = 0.1,
            autostart = true,
            callback = function() awful.placement.centered(mouse, {parent=c})  end,
            single_shot = true,
      })
   -- else
   --    io.stderr:write(" ** mouse not moved "
   --                       .. tostring(mcc) .. " - "
   --                       .. tostring(c))
   --    if c ~= nil then io.stderr:write(" - " .. tostring(c.type)) end
   --    io.stderr:write("\n")
   end
   -- io.stderr:write("Mouse current client: ".. tostring(mouse.current_client) .. "\n")
end

local next_focused_client_gets_mouse = false

client.connect_signal("swapped",
                      function(c1, c2) -- , is_source)
                         -- io.stderr:write(" ------------------ Swapped\n"
                         --                    .. tostring(c1) .. "\n" .. tostring(c2)
                         --                    .. "\n(" .. tostring(is_source) .. ")\n"
                         --                    .. tostring(client.focus) .. "\n"
                         -- )
                         if client.focus ~= c1 then
                            move_mouse_to_client(c2, true)
                         end
                         -- io.stderr:write("---------------------\n")
                      end
)

screen.connect_signal("tag::history::update",
                      function()
                         -- io.stderr:write("History update\n")
                         next_focused_client_gets_mouse = true
                      end
)

client.connect_signal("raised",
                      function(c)
                         -- io.stderr:write("Client raised: " .. tostring(c) .. "\n")
                         move_mouse_to_client(c)
                      end
)

-- client.connect_signal("request::activate",
--                       function(c)
--                          io.stderr:write("Client activated: " .. tostring(c) .. "\n")
--                       end
-- )

-- client.connect_signal("property::position",
--                       function(c)
--                          io.stderr:write("Client position changed: " .. tostring(c) .. "\n")
--                       end
-- )

client.connect_signal("focus",
                      function(c)
                         -- io.stderr:write("Client focused: " .. tostring(c) .. "\n")
                         if next_focused_client_gets_mouse then
                            move_mouse_to_client(c, true)
                            next_focused_client_gets_mouse = false
                         -- else
                         --    io.stderr:write(" ** mouse not moved because of next_focused_client_gets_mouse\n")
                         end
                      end
)
