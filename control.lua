--[[
This forcibly enables logistics and sets the mine and crafting rates.
]]

local function player_setup(player)
  if player ~= nil and player.character ~= nil then
    -- apply the mining modifiers (make configurable?)
    player.character_mining_speed_modifier = 16
    player.character_crafting_speed_modifier = 10000

    -- forcibly enabled logistics
    local entity = player.character
    if not entity.force.character_logistic_requests then
      entity.force.character_logistic_requests = true
      if entity.force.character_trash_slot_count < 10 then
        entity.force.character_trash_slot_count = 10
      end
    end
  end
end

--[[ This seems to catch all players as they join.
Adding the mod to an exising game won't change the stats.
]]
local function on_player_events(event)
  player_setup(game.get_player(event.player_index))
end

script.on_event(
  {
    defines.events.on_player_created,
    defines.events.on_cutscene_cancelled,
    defines.events.on_cutscene_finished,
  },
  on_player_events
)

-- this will periodically apply the alt speeds
script.on_nth_tick(600, function()
  for _, player in pairs(game.players) do
    player_setup(player)
  end
end)
