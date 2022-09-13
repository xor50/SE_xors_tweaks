local mod_prefix = "xor-"
local data_util_SE_PP = require("__space-exploration-postprocess__/data_util")


-- mirror alt (SE)
data.raw.recipe["se-space-mirror-alternate"].ingredients = {
  { name = "glass", amount = 2},
  { name = "se-iridium-plate", amount = 2},
  { name = "low-density-structure", amount = 1},
  { type = "fluid", name = "lubricant", amount = 5},
  { type = "fluid", name = "se-chemical-gel", amount = 2}, --5
}

data.raw.recipe["se-space-mirror-alternate"].results = {
  { name = "se-space-mirror", amount = 1 },
  { name = "se-scrap", amount = 2 }, --5
}

if mods["Krastorio2"] then

  -- RCU alt:
  -- with lithium-sulfur battery -> same ingredients but faster recipe
  local new_RCU_recipe = table.deepcopy(data.raw["recipe"]["rocket-control-unit"])
  new_RCU_recipe.name = mod_prefix .. new_RCU_recipe.name
  new_RCU_recipe.enabled = false
  new_RCU_recipe.ingredients = {
    { name = "lithium-sulfur-battery", amount = 5},
    { name = "advanced-circuit", amount = 5},
    { name = "glass", amount = 5},
    { name = "iron-plate", amount = 5}
  }
  new_RCU_recipe.energy_required = 20 --30
  new_RCU_recipe.allow_productivity = true -- doesn't work, possibly because of SE-PP
  new_RCU_recipe.icons =
      data_util_SE_PP.sub_icons(data.raw["item"]["rocket-control-unit"].icon, data.raw["item"]["lithium-sulfur-battery"].icon)
  data:extend({new_RCU_recipe})

  data_util_SE_PP.allow_productivity("xor-rocket-control-unit")

  data:extend({
    {
      type = "technology",
      name = mod_prefix .. "RCU",
      icons = {
        {
          icon = data.raw["technology"]["rocket-control-unit"].icon,
          icon_size = data.raw["technology"]["rocket-control-unit"].icon_size,
          icon_mipmaps = data.raw["technology"]["rocket-control-unit"].icon_mipmaps
        },
        {
          icon = data.raw["technology"]["kr-lithium-sulfur-battery"].icon,
          icon_size = data.raw["technology"]["kr-lithium-sulfur-battery"].icon_size,
          icon_mipmaps = data.raw["technology"]["kr-lithium-sulfur-battery"].icon_mipmaps,
          scale = 0.6,
          shift = {-60,60}
        }
      },
      effects = {
        {
        type = "unlock-recipe",
        recipe = new_RCU_recipe.name
        }
      },
      unit = {
        count = 200,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"se-rocket-science-pack", 1},
          {"space-science-pack", 1},
          {"kr-optimization-tech-card", 1}
        },
        time = 45,
      },
      prerequisites = {
        "rocket-control-unit",
        "kr-lithium-sulfur-battery",
        "kr-optimization-tech-card"
      }
    }
  })


  -- flying robot frame alt:
  -- with lithium-sulfur battery -> a bit cheaper and a bit faster
  local new_botframe_recipe = table.deepcopy(data.raw["recipe"]["flying-robot-frame"])
  new_botframe_recipe.name = mod_prefix .. new_botframe_recipe.name
  new_botframe_recipe.enabled = false
  new_botframe_recipe.normal.ingredients = {
    { name = "electric-engine-unit", amount = 3}, --4
    { name = "lithium-sulfur-battery", amount = 4},
    { name = "electronic-components", amount = 7}, --10
    { name = "steel-plate", amount = 3} --4
  }
  new_botframe_recipe.energy_required = 15 --20
  new_botframe_recipe.allow_productivity = true
  new_botframe_recipe.icons =
      data_util_SE_PP.sub_icons(data.raw["item"]["flying-robot-frame"].icon, data.raw["item"]["lithium-sulfur-battery"].icon)
  data:extend({new_botframe_recipe})

  data_util_SE_PP.allow_productivity("xor-flying-robot-frame")

  data:extend({
    {
      type = "technology",
      name = mod_prefix .. "adv-botframes",
      icons = {
        {
          icon = data.raw["technology"]["robotics"].icon,
          icon_size = data.raw["technology"]["robotics"].icon_size,
          icon_mipmaps = data.raw["technology"]["robotics"].icon_mipmaps
        },
        {
          icon = data.raw["technology"]["kr-lithium-sulfur-battery"].icon,
          icon_size = data.raw["technology"]["kr-lithium-sulfur-battery"].icon_size,
          icon_mipmaps = data.raw["technology"]["kr-lithium-sulfur-battery"].icon_mipmaps,
          scale = 0.6,
          shift = {75,75}
        }
      },
      effects = {
        {
        type = "unlock-recipe",
        recipe = new_botframe_recipe.name
        }
      },
      unit = {
        count = 200,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"se-rocket-science-pack", 1},
          {"space-science-pack", 1},
          {"kr-optimization-tech-card", 1}
        },
        time = 45,
      },
      prerequisites = {
        "robotics",
        "kr-robot-battery",
        "kr-lithium-sulfur-battery",
        "kr-optimization-tech-card"
      }
    }
  })

end
