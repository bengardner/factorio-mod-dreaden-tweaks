--[[
Make all basic logistics stuff free.
]]

local function make_logistics_free()

  local cats_to_free = {
    "construction-robot",
    "logistic-robot",
    "logistic-container",
    "roboport",
  }

  for _, cat in ipairs(cats_to_free) do
    for cname, _ in pairs(data.raw[cat]) do
      local recipe = data.raw['recipe'][cname]
      if recipe then
        recipe.ingredients = {}
        recipe.energy_required = 1
        recipe.enabled = true
      end
    end
  end
end

make_logistics_free()
