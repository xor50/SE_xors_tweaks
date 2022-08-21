local mod_prefix = "xor-"

if mods["Krastorio2"] then

  if (settings.startup["xor-enable-advanced-explosives"].value == true) then
    -- advanced explosives recipe
    data:extend({
      {
        type = "recipe",
        name = mod_prefix .. "advanced-explosives",
        energy_required = 3,
        enabled = false,
        category = "chemistry",
        icons = {
          {icon = data.raw.item.explosives.icon, icon_size = data.raw.item.explosives.icon_size},
          {
            icon = data.raw.fluid.ammonia.icon,
            icon_size = data.raw.fluid.ammonia.icon_size,
            scale = 0.25*64/data.raw.fluid.ammonia.icon_size,
            shift = {-9, 9}
          },
          {
            icon = data.raw.fluid["nitric-acid"].icon,
            icon_size = data.raw.fluid["nitric-acid"].icon_size,
            scale = 0.25*64/data.raw.fluid["nitric-acid"].icon_size,
            shift = {9, 9}
          },
        },
        ingredients =
        {
          {type="fluid", name="ammonia", amount = 10},
          {type="fluid", name="nitric-acid", amount = 10}
        },
        result = "explosives",
        result_count = 3,
        order = item_name,
        allow_decomposition = true,
        --from vanilla explosives recipe:
        crafting_machine_tint = {
          primary = {r = 0.968, g = 0.381, b = 0.259, a = 1.000}, -- #f66142ff
          secondary = {r = 0.892, g = 0.664, b = 0.534, a = 1.000}, -- #e3a988ff
          tertiary = {r = 1.000, g = 0.978, b = 0.513, a = 1.000}, -- #fff982ff
          quaternary = {r = 0.210, g = 0.170, b = 0.013, a = 1.000}, -- #352b03ff
        }
      }
    })

    -- advanced explosives tech
    data:extend{{
      name = mod_prefix .. "advanced-explosives",
      type = "technology",
      icons = {
        {
          icon = data.raw["technology"]["explosives"].icon,
          icon_size = data.raw["technology"]["explosives"].icon_size,
        },
        {
          icon = data.raw["fluid"]["ammonia"].icon,
          icon_size = data.raw["fluid"]["ammonia"].icon_size,
          scale = 1.6,
          shift = {-70,70},
        },
        {
          icon = data.raw["fluid"]["nitric-acid"].icon,
          icon_size = data.raw["fluid"]["nitric-acid"].icon_size,
          scale = 1.6,
          shift = {70,70},
        },
      },
      unit = {
        count = 300,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"se-rocket-science-pack", 1},
        },
        time = 60,
      },
      prerequisites = {
        "kr-advanced-chemistry",
        "explosives"
      },
      effects = {
        {type = "unlock-recipe", recipe = mod_prefix .. "advanced-explosives"}
      }
    }}
  end


  if (settings.startup["xor-enable-mineral-water-filtering"].value == true) then
    -- mineral water filtering recipe
    data:extend({
      {
        type = "recipe",
        name = mod_prefix .. "mineral-water-filtering",
        energy_required = 4,
        enabled = false,
        category = "fluid-filtration",
        subgroup = "raw-material",
        icons = {
          {icon = data.raw["fluid"]["dirty-water"].icon, icon_size = data.raw["fluid"]["dirty-water"].icon_size},
          {
            icon = data.raw.fluid["mineral-water"].icon,
            icon_size = data.raw.fluid["mineral-water"].icon_size,
            scale = 0.33*64/data.raw.fluid["mineral-water"].icon_size,
            shift = {5, 5}
          },
        },
        ingredients =
        {
          {type="fluid", name="mineral-water", amount = 100}
        },
        results = {
          {type="fluid", name="dirty-water", amount = 50},
          {type="item", name="sand", amount_min = 1, amount_max = 5},
          {type="item", name="quartz", probability = 0.15, amount = 1},
          {type="item", name="rare-metals", probability = 0.05, amount = 1},
          {type="item", name="lithium", probability = 0.05, amount = 1}
        },
        --main_product = "dirty-water", -- overwrites manual naming in locale if set
        order = item_name,
        allow_decomposition = true,
        crafting_machine_tint = {
          primary = { r = 0.96, g = 0.64, b = 0.38, a = 0.6 }, --dirty
          secondary = { r = 0.55, g = 0.55, b = 0.51, a = 0.5 }, --clear
        }
      }
    })

    -- mineral water filtering tech
    data:extend{{
      name = mod_prefix .. "mineral-water-filtering",
      type = "technology",
      icons = {
        {
          icon = data.raw["item"]["kr-filtration-plant"].icon,
          icon_size = data.raw["item"]["kr-filtration-plant"].icon_size,
          --scale = 1.0,
        },
        {
          icon = data.raw["fluid"]["mineral-water"].icon,
          icon_size = data.raw["fluid"]["mineral-water"].icon_size,
          scale = 0.5,
          shift = {-20,20},
        },
        {
          icon = data.raw["fluid"]["dirty-water"].icon,
          icon_size = data.raw["fluid"]["dirty-water"].icon_size,
          scale = 0.5,
          shift = {20,20},
        },
      },
      unit = {
        count = 150,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
        },
        time = 45,
      },
      prerequisites = {
        "kr-mineral-water-gathering"
      },
      effects = {
        {type = "unlock-recipe", recipe = mod_prefix .. "mineral-water-filtering"}
      }
    }}
  end

end
