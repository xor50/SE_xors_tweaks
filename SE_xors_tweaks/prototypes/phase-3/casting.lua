local mod_prefix = "xor-"

local molten = "molten"
local add_cryo = {}
local add_water = {}
local ingot = "ingot"
--local boost = 0.9

if mods["Krastorio2"] then
  data.raw["recipe"]["se-steel-ingot"].ingredients = {
    { type="item", name="coke", amount = 5 }, --6
    { type="fluid", name="se-molten-iron", amount = 450 } --500
  }
end

local denseness_factor = 1 -- default: make not denser
if (settings.startup["xor-enable-increased-molten-density"].value == true) then
  if not mods["SE_faster_caster"] then
    denseness_factor = 2 -- make denser by this factor
  end
end

-- make molten metal denser (as in: recipes put out less and recipes require less)
for name, recipe in pairs(data.raw["recipe"]) do
  if recipe.ingredients ~= nil then
    for key, ingredient in pairs(recipe.ingredients) do
      if ingredient.name ~= nil then
        if string.find(ingredient.name, molten) and not string.find(recipe.name, "cooled") then
          ingredient.amount = ingredient.amount/denseness_factor
          if (settings.startup["xor-enable-cryo-cooled-casting-recipes"].value == true) then
            if not mods["SE_faster_caster"] then
              table.insert(add_cryo, recipe.name) -- add new cryo cooling recipes
            end
          end
          if (settings.startup["xor-enable-water-cooled-casting-recipes"].value == true) then
            table.insert(add_water, recipe.name) -- add new water cooling recipes
          end
        end
      end
    end
  end
  if recipe.result then
    if string.find(recipe.result, molten) and not string.find(recipe.name, "cooled") then
      if not mods["SE_faster_caster"] then
        recipe.result_count = recipe.result_count/denseness_factor
      end
    end
  elseif recipe.results then
    for key, result in pairs(recipe.results) do
      if result.name ~= nil then
        if string.find(result.name, molten) and not string.find(recipe.name, "cooled") then
          if result.amount ~= nil then --amount will be nil when min and max is used
            if not mods["SE_faster_caster"] then
              result.amount = result.amount/denseness_factor
            end
          else
            result.amount_min = result.amount_min/denseness_factor
            result.amount_max = result.amount_max/denseness_factor
          end
        end
      end
    end
  end
  -- make kiln recipes available in higher tier furnaces
  if (settings.startup["xor-enable-kiln-recipes-in-smelting-furnaces"].value == true) then
    if not mods["SE_faster_caster"] then
      if recipe.category == "kiln" then recipe.category = "smelting" end
    end
  end
end


if (settings.startup["xor-enable-cryo-cooled-casting-recipes"].value == true) then
  if not mods["SE_faster_caster"] then
    -- add cryo cooling tech
    data:extend{{
      name = mod_prefix .. "cryo-cooling-ingots",
      type = "technology",
      icons = {
        {
          icon = data.raw["technology"]["se-processing-cryonite"].icon,
          icon_size = data.raw["technology"]["se-processing-cryonite"].icon_size
        },
        {
          icon = data.raw["item"]["se-iron-ingot"].icon,
          icon_size = data.raw["item"]["se-iron-ingot"].icon_size,
          scale = .5,
          shift = {48,48}
        },
        {
          icon = data.raw["item"]["se-copper-ingot"].icon,
          icon_size = data.raw["item"]["se-copper-ingot"].icon_size,
          scale = .5,
          shift = {16,48}
        },
        {
          icon = data.raw["item"]["se-holmium-ingot"].icon,
          icon_size = data.raw["item"]["se-holmium-ingot"].icon_size,
          scale = .5,
          shift = {48,16}
        },
        {
          icon = data.raw["item"]["se-beryllium-ingot"].icon,
          icon_size = data.raw["item"]["se-beryllium-ingot"].icon_size,
          scale = .5,
          shift = {16,16}
        },
        {
          icon = data.raw["item"]["se-steel-ingot"].icon,
          icon_size = data.raw["item"]["se-steel-ingot"].icon_size,
          scale = .5,
          shift = {-16,48}
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
          {"production-science-pack", 1},
          {"se-energy-science-pack-1", 1},
          {"se-material-science-pack-1", 1}
        },
        time = 60,
      },
      prerequisites = {
        "se-processing-cryonite",
        "se-space-hypercooling-2",
        "se-pyroflux-smelting"
      },
      effects = {}
    }}
  end
end

local cryo_tech = data.raw["technology"][mod_prefix .. "cryo-cooling-ingots"]

if (settings.startup["xor-enable-water-cooled-casting-recipes"].value == true) then
  -- add water cooling tech
  data:extend{{
    name = mod_prefix .. "water-cooling-ingots",
    type = "technology",
    icons = {
      {
        icon = data.raw["technology"]["se-pyroflux-smelting"].icon,
        icon_size = data.raw["technology"]["se-pyroflux-smelting"].icon_size
      },
      {
        icon = data.raw["fluid"]["water"].icon,
        icon_size = data.raw["fluid"]["water"].icon_size,
        scale = 3.0,
        shift = {50,50}
      }
    },
    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"se-rocket-science-pack", 1},
        {"space-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 60,
    },
    prerequisites = {
      "se-space-hypercooling-1",
      "se-pyroflux-smelting"
    },
    effects = {}
  }}
end

local water_tech = data.raw["technology"][mod_prefix .. "water-cooling-ingots"]

-- add fluid boxes to casting machine to enable new cooling recipes
if (settings.startup["xor-enable-cryo-cooled-casting-recipes"].value == true
    or settings.startup["xor-enable-water-cooled-casting-recipes"].value == true) then
  data.raw["assembling-machine"]["se-casting-machine"].fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = pipe_pics,
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      base_level = -1,
      height = 2,
      pipe_connections = {{ type="input-output", position = {-2, .5} }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    },
    {
      production_type = "output",
      pipe_picture = pipe_pics,
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      base_level = 1,
      height = 2,
      pipe_connections = {{ type="output", position = {0, -1.5} }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    },
    {
      production_type = "input",
      pipe_picture = pipe_pics,
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      base_level = -1,
      height = 2,
      pipe_connections = {{ type="input-output", position = {2, .5} }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    },
    {
      production_type = "input",
      pipe_picture = pipe_pics,
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      base_level = -1,
      height = 2,
      pipe_connections = {{ type="input-output", position = {0, 1.5} }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    }
  }
end

-- add new cryo recipes
local function add_cryoslush_cooled_ingot(recipe_name)
  local recipe = data.raw["recipe"][recipe_name]
  local is_ingot = false
  if recipe.category ~= "casting" then return end
  if recipe.result then
    if string.find(recipe.result, ingot) then
      is_ingot = true
    end
  elseif recipe.results then
    for key, result in pairs(recipe.results) do
      if result.name ~= nil then
        if string.find(result.name, ingot) then
          is_ingot = true
        end
      end
      if result[1] ~= nil then
        if string.find(result[1], ingot) then
          is_ingot = true
        end
      end
    end
  end
  if is_ingot then
    local new_recipe = table.deepcopy(recipe)
    new_recipe.name = mod_prefix .. "cryoslush-cooled-" .. recipe_name
    if new_recipe.order ~= nil then
      new_recipe.order = new_recipe.order .. "-02"
    end
    table.insert(new_recipe.ingredients, {type="fluid", name="se-cryonite-slush", amount = 4})
    new_recipe.energy_required = new_recipe.energy_required / 2.5
    --[[for key, ingredient in pairs(new_recipe.ingredients) do
        if ingredient.name ~= nil then
            if string.find(ingredient.name, molten) then
                ingredient.amount = ingredient.amount * boost
            end
        end
    end]]
    data:extend({new_recipe})
    table.insert(cryo_tech.effects, {type = "unlock-recipe", recipe = new_recipe.name})
    if new_recipe.icons then
      table.insert(new_recipe.icons,
      {
        icon = data.raw["fluid"]["se-cryonite-slush"].icon,
        icon_size = data.raw["fluid"]["se-cryonite-slush"].icon_size,
        scale = 0.25,
        shift = {7,7}
      })
    elseif data.raw["item"][recipe.name].icons then
      new_recipe.icons = table.deepcopy(data.raw["item"][recipe.name].icons)
      table.insert(new_recipe.icons,
      {
        icon = data.raw["fluid"]["se-cryonite-slush"].icon,
        icon_size = data.raw["fluid"]["se-cryonite-slush"].icon_size,
        scale = 0.25,
        shift = {7,7}
      })
    elseif data.raw["item"][recipe.name].icon then
      new_recipe.icons =
      {{
          icon = data.raw["item"][recipe.name].icon,
          icon_size = data.raw["item"][recipe.name].icon_size,
        },
        {
          icon = data.raw["fluid"]["se-cryonite-slush"].icon,
          icon_size = data.raw["fluid"]["se-cryonite-slush"].icon_size,
          scale = 0.25,
          shift = {7,7}
      }}
    elseif data.raw["recipe"][recipe.name].icon then
      new_recipe.icons =
      {{
          icon = data.raw["recipe"][recipe.name].icon,
          icon_size = data.raw["recipe"][recipe.name].icon_size,
        },
        {
          icon = data.raw["fluid"]["se-cryonite-slush"].icon,
          icon_size = data.raw["fluid"]["se-cryonite-slush"].icon_size,
          scale = 0.25,
          shift = {7,7}
      }}
    end
  end
end

if (settings.startup["xor-enable-cryo-cooled-casting-recipes"].value == true) then
  if not mods["SE_faster_caster"] then
    for key, value in pairs(add_cryo) do
      add_cryoslush_cooled_ingot(value)
    end
  end
end

-- add new water recipes
local function add_water_cooled_ingot(recipe_name)
  local recipe = data.raw["recipe"][recipe_name]
  local is_ingot = false
  if recipe.category ~= "casting" then return end
  if recipe.result then
    if string.find(recipe.result, ingot) then
      is_ingot = true
    end
  elseif recipe.results then
    for key, result in pairs(recipe.results) do
      if result.name ~= nil then
        if string.find(result.name, ingot) then
          is_ingot = true
        end
      end
      if result[1] ~= nil then
        if string.find(result[1], ingot) then
          is_ingot = true
        end
      end
    end
  end
  if is_ingot then
    local new_recipe = table.deepcopy(recipe)
    new_recipe.name = mod_prefix .. "water-cooled-" .. recipe_name
    if new_recipe.order ~= nil then
      new_recipe.order = new_recipe.order .. "-01"
    end
    table.insert(new_recipe.ingredients, {type="fluid", name="water", amount = 50})
    if new_recipe.results ~= nil then
      table.insert(new_recipe.results, {type = "fluid", name="steam", amount = 25, temperature = 165})
    end
    new_recipe.energy_required = new_recipe.energy_required / 1.5625

    -- list all bz mods here (and possibly other mods as well), needs updating for new releases
    if (mods["bztitanium"] or
        mods["bzlead"] or
        mods["bztungsten"] or
        mods["bzzirconium"] or
        mods["bzsilicon"] or
        mods["bzcarbon"] or
        mods["bzaluminum"] or
        mods["bztin"]) then
      -- "else" is the correct way to do it
      -- "if" breaks if recipe has different name than an item name; "break" might mean mod doesn't even load and gives error
      -- so we need to check if recipe name is an item name:
        if data.raw.item[recipe.name] then
          new_recipe.main_product = recipe.name
        end
      -- of course that means if recipe has illegal name no new water-cooled recipe will be created, too bad
      --log (serpent.block ("bz detected -> if block"))
    else
      -- the reason for this if/else chaos is that the result short form can't be accessed like this:
      new_recipe.main_product = recipe.results[1].name
      --log (serpent.block ("no bz detected -> else block"))
    end

    --log (serpent.block (new_recipe))
    data:extend({new_recipe})
    table.insert(water_tech.effects, {type = "unlock-recipe", recipe = new_recipe.name})
    if new_recipe.icons then
      table.insert(new_recipe.icons,
      {
        icon = data.raw["fluid"]["water"].icon,
        icon_size = data.raw["fluid"]["water"].icon_size,
        scale = 0.25,
        shift = {7,7}
      })
    elseif data.raw["item"][recipe.name].icons then
      new_recipe.icons = table.deepcopy(data.raw["item"][recipe.name].icons)
      table.insert(new_recipe.icons,
      {
        icon = data.raw["fluid"]["water"].icon,
        icon_size = data.raw["fluid"]["water"].icon_size,
        scale = 0.25,
        shift = {7,7}
      })
    elseif data.raw["item"][recipe.name].icon then
      new_recipe.icons =
      {{
          icon = data.raw["item"][recipe.name].icon,
          icon_size = data.raw["item"][recipe.name].icon_size,
        },
        {
          icon = data.raw["fluid"]["water"].icon,
          icon_size = data.raw["fluid"]["water"].icon_size,
          scale = 0.25,
          shift = {7,7}
      }}
    elseif data.raw["recipe"][recipe.name].icon then
      new_recipe.icons =
      {{
          icon = data.raw["recipe"][recipe.name].icon,
          icon_size = data.raw["recipe"][recipe.name].icon_size,
        },
        {
          icon = data.raw["fluid"]["water"].icon,
          icon_size = data.raw["fluid"]["water"].icon_size,
          scale = 0.25,
          shift = {7,7}
      }}
    end
  end
end

if (settings.startup["xor-enable-water-cooled-casting-recipes"].value == true) then
  for key, value in pairs(add_water) do
    add_water_cooled_ingot(value)
  end
end
