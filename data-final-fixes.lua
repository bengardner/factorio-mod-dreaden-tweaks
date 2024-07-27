require "prototypes/logistic-chests"

-- make spidertron grid huge
-- want grid width to be 10, but another mod set it to 20 and I don't want to break the save game
data.raw["equipment-grid"]['spidertron-equipment-grid'].width = 10
data.raw["equipment-grid"]['spidertron-equipment-grid'].height = 60

data.raw["spider-vehicle"]['spidertron'].inventory_size = 160
data.raw["spider-vehicle"]['spidertron'].max_health = 300000

--[[
data.raw["spider-vehicle"]['spidertron'].guns = {
        "spidertron-rocket-launcher-1",
        "spidertron-rocket-launcher-2",
        "spidertron-rocket-launcher-3",
        "spidertron-rocket-launcher-4",
        "tank-cannon",
        "tank-machine-gun",
      }
]]

-- original data
-- max_shield_value = 150
-- energy_per_shield = "30kJ"
data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"].max_shield_value = 1500
data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"].energy_per_shield = "3kJ"

-- insane ranges
--data.raw["gun"]["tank-cannon"].attack_parameters.range = 180

data.raw["ammo"]["cannon-shell"].ammo_type.action.action_delivery.max_range = 60

data.raw["gun"]["spidertron-rocket-launcher-1"].attack_parameters.range = 90
data.raw["gun"]["spidertron-rocket-launcher-2"].attack_parameters.range = 90
data.raw["gun"]["spidertron-rocket-launcher-3"].attack_parameters.range = 90
data.raw["gun"]["spidertron-rocket-launcher-4"].attack_parameters.range = 90

-- artillery (insane range hurts performance when firing)
do
  data.raw["gun"]["artillery-wagon-cannon"].attack_parameters.range = 1500

  -- larger blast area
  local ap = data.raw["artillery-projectile"]["artillery-projectile"]
  ap.action.action_delivery.target_effects[1].action.radius = 15

  -- and make the shells free (big cheat)
  local ar = data.raw["recipe"]["artillery-shell"]
  ar.ingredients = {}
  --  { "iron-plate", 4 }
  -- }
end

-- lasers need a really long range
data.raw["electric-turret"]["laser-turret"].attack_parameters.range = 60

-- should match big worm range
data.raw["ammo-turret"]["gun-turret"].attack_parameters.range = 36

-- buff the railgun turret -- should be ultimate weapon; go through anything
do
  local at = data.raw["ammo-turret"]["kr-railgun-turret"]
  if at ~= nil then
    at.attack_parameters.range = 120
    at.attack_parameters.damage_modifier = 5
  end
end

data.raw["ammo-turret"]["gun-turret"].attack_parameters.range = 36

-- make robots have insane range
do
  local lr = data.raw["logistic-robot"]["logistic-robot"]
  lr.energy_per_move = "0.01kJ"
  lr.max_payload_size = 100
  lr.speed = 0.6

  local cr = data.raw["construction-robot"]["construction-robot"]
  cr.energy_per_move = "0.01kJ"
  cr.max_payload_size = 100
  cr.speed = 0.8
end

-- roboports need to be crazy big as well
do
  local rp = data.raw["roboport"]["roboport"]

  local reach = 62
  rp.construction_radius = reach * 2
  rp.logistics_radius = reach
  rp.logistics_connection_distance = reach
end

-- make all equipment grids at least 30 tall
do
  for _, v in pairs(data.raw["equipment-grid"]) do
    -- print(string.format("%s : %s", k, serpent.line(v)))
    -- Ex: {equipment_categories = {"armor", "armor-jetpack"}, height = 5, name = "small-equipment-grid", type = "equipment-grid", width = 5}
    v.height = math.max(30, v.height)
  end
end
