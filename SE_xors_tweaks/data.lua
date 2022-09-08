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


  if (settings.startup["xor-enable-mineral-water-recipes"].value == true) then
    require("prototypes/phase-1/mineral-water")
  end

end
