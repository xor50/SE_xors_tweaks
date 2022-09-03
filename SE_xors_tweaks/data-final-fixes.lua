local mod_prefix = "xor-"

if mods["Krastorio2"] then

  if (settings.startup["xor-enable-robot-cargo-fix"].value == true) then
    -- fix bots having way too large cargo size with K2 (oversight by SE integration?)
    data.raw["logistic-robot"]["logistic-robot"].max_payload_size = 2
  end

  if (settings.startup["xor-enable-aai-furnace-module-balancing"].value == true) then
    -- reduce number of module slots of AAI industrial furnace from 5 to 4 so K2 advanced furnace (with 5 slots) is more of an upgrade
    data.raw["assembling-machine"]["industrial-furnace"].module_specification = { module_slots = 4 }
  end

  if (settings.startup["xor-enable-k2-advanced-chem-plant-balancing"].value == true) then
    -- nerf: was too strong compared to normal chem plant
    data.raw["assembling-machine"]["kr-advanced-chemical-plant"].crafting_speed = 6
    -- reduce power usage accordingly
    local advanced_chemical_plant_energy_usage_old = string.match(data.raw["assembling-machine"]["kr-advanced-chemical-plant"].energy_usage, "%A+")
    data.raw["assembling-machine"]["kr-advanced-chemical-plant"].energy_usage = advanced_chemical_plant_energy_usage_old * 6/8 .. "MW"
  end
end

if (settings.startup["xor-enable-increased-caster-speed"].value == true) then
  -- SE: increase speed (by factor of 2) of casting machine so that a less ridicoulous number of machines is needed
  local casting_machine_speed_factor = 2
  data.raw["assembling-machine"]["se-casting-machine"].crafting_speed = data.raw["assembling-machine"]["se-casting-machine"].crafting_speed * casting_machine_speed_factor

  -- SE: increase energy_usage to balance out the fewer needed machines and the steam return of water cooling
  local casting_machine_energy_usage_old = string.match(data.raw["assembling-machine"]["se-casting-machine"].energy_usage, "%A+")
  data.raw["assembling-machine"]["se-casting-machine"].energy_usage = casting_machine_energy_usage_old * casting_machine_speed_factor .. "kW"
end

if (settings.startup["xor-enable-no-burning-in-space"].value == true) then
  -- Gas Power Station for only not-space to make the Isothermic Generator more useful
  -- setting up the collision mask stuff yourself seems complicated so I just copy from something that SE changed to now be placeable in space
  if mods["Krastorio2"] then
    data.raw["generator"]["kr-gas-power-station"].collision_mask = data.raw["assembling-machine"]["assembling-machine-1"].collision_mask
  end
  data.raw["burner-generator"]["burner-turbine"].collision_mask = data.raw["assembling-machine"]["assembling-machine-1"].collision_mask
  data.raw["boiler"]["boiler"].collision_mask = data.raw["assembling-machine"]["assembling-machine-1"].collision_mask
end

-- BEGIN RECIPE ORDERING

-- stone
data.raw["recipe"]["se-core-fragment-stone"].order = "01"
if mods["Krastorio2"] then -- while SE and AAI have sand (and glass) the recipe name is different to the K2 name; the order of those without K2 seems correct per default
  data.raw["recipe"]["sand"].order = "02"
  data.raw["recipe"]["glass"].order = "03"
end
data.raw["recipe"]["se-glass-vulcanite"].order = "04"
if mods["Krastorio2"] then
  data.raw["recipe"]["quartz"].order = "05"
  data.raw["recipe"]["silicon"].order = "06"
  data.raw["recipe"]["silicon-vulcanite"].order = "07"
end

-- iron
data.raw["recipe"]["se-core-fragment-iron-ore"].order = "01"
if mods["Krastorio2"] then
  data.raw["recipe"]["dirty-water-filtration-1"].order = "02"
end
data.raw["recipe"]["iron-plate"].order = "03"
if mods["Krastorio2"] then
  data.raw["recipe"]["enriched-iron"].order = "04"
  data.raw["recipe"]["enriched-iron-plate"].order = "05"
end
data.raw["recipe"]["se-molten-iron"].order = "06"
data.raw["recipe"]["se-iron-ingot"].order = "07"
data.raw["recipe"]["se-iron-ingot-to-plate"].order = "08"

-- steel
data.raw["recipe"]["steel-plate"].order = "09"
data.raw["recipe"]["se-steel-ingot"].order = "10"
data.raw["recipe"]["se-steel-ingot-to-plate"].order = "11"

-- copper
data.raw["recipe"]["se-core-fragment-copper-ore"].order = "01"
if mods["Krastorio2"] then
  data.raw["recipe"]["dirty-water-filtration-2"].order = "02"
end
data.raw["recipe"]["copper-plate"].order = "03"
if mods["Krastorio2"] then
  data.raw["recipe"]["enriched-copper"].order = "04"
  data.raw["recipe"]["enriched-copper-plate"].order = "05"
end
data.raw["recipe"]["se-molten-copper"].order = "06"
data.raw["recipe"]["se-copper-ingot"].order = "07"
data.raw["recipe"]["se-copper-ingot-to-plate"].order = "08"

-- rare metals
if mods["Krastorio2"] then
  data.raw["recipe"]["se-core-fragment-rare-metals"].order = "01"
  data.raw["recipe"]["dirty-water-filtration-3"].order = "02"
  data.raw["recipe"]["rare-metals"].order = "03"
  data.raw["recipe"]["enriched-rare-metals"].order = "04"
  data.raw["recipe"]["rare-metals-2"].order = "05"
  data.raw["recipe"]["rare-metals-vulcanite"].order = "06"
end

-- imersite
if mods["Krastorio2"] then
  data.raw["recipe"]["se-core-fragment-imersite"].order = "01"
  data.raw["recipe"]["imersite-powder"].order = "02"
end

-- END RECIPE ORDERING

-- BEGIN ITEM ORDERING

-- stone
data.raw["item"]["se-core-fragment-stone"].order = "01"
data.raw["item"]["stone"].order = "02"
data.raw["item"]["sand"].order = "03"
data.raw["item"]["glass"].order = "04"
if mods["Krastorio2"] then
  data.raw["item"]["quartz"].order = "05"
  data.raw["item"]["silicon"].order = "06"
end

-- iron
data.raw["item"]["se-core-fragment-iron-ore"].order = "01"
data.raw["item"]["iron-ore"].order = "02"
if mods["Krastorio2"] then
  data.raw["item"]["enriched-iron"].order = "03"
end
data.raw["item"]["se-iron-ingot"].order = "04"
data.raw["item"]["iron-plate"].order = "05"

-- copper
data.raw["item"]["se-core-fragment-copper-ore"].order = "01"
data.raw["item"]["copper-ore"].order = "02"
if mods["Krastorio2"] then
  data.raw["item"]["enriched-copper"].order = "03"
end
data.raw["item"]["se-copper-ingot"].order = "04"
data.raw["item"]["copper-plate"].order = "05"

-- rare metals
if mods["Krastorio2"] then
  data.raw["item"]["se-core-fragment-rare-metals"].order = "01"
  data.raw["item"]["raw-rare-metals"].order = "02"
  data.raw["item"]["enriched-rare-metals"].order = "03"
  data.raw["item"]["rare-metals"].order = "04"
end

-- END ITEM ORDERING

local molten = "molten"
local add_cryo = {}
local add_water = {}
local ingot = "ingot"
--local boost = 0.9

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

if (settings.startup["xor-enable-coal-landfill"].value == true) then
  -- add landfill from coal
  local function landfil_recipe(item_name, count)
    data:extend({
      {
        type = "recipe",
        name = "landfill-"..item_name,
        energy_required = 1,
        enabled = false,
        category = "hard-recycling",
        icons = {
          {icon = data.raw.item.landfill.icon, icon_size = data.raw.item.landfill.icon_size},
          {icon = data.raw.item[item_name].icon, icon_size = data.raw.item[item_name].icon_size, scale = 0.33*64/data.raw.item[item_name].icon_size},
        },
        ingredients =
        {
          {item_name, count}
        },
        result= "landfill",
        result_count = 1,
        order = "z-b-"..item_name,
        allow_decomposition = false,
      }
    })
    table.insert(data.raw["technology"]["se-recycling-facility"].effects, {type = "unlock-recipe",recipe = "landfill-"..item_name})
  end

  landfil_recipe("coal", 50)
end

if mods["Krastorio2"] then

  if (settings.startup["xor-enable-chemicals-fuel-value"].value == true) then
    -- fuel value for hydrogen
    data.raw["fluid"]["hydrogen"].fuel_value = "450kJ"
    data.raw["fluid"]["hydrogen"].emissions_multiplier = 0.5

    -- fuel value for light oil
    data.raw["fluid"]["light-oil"].fuel_value = "600kJ"
    data.raw["fluid"]["light-oil"].emissions_multiplier = 1.5
  end

  if (settings.startup["xor-swap-electrolysis-outputs"].value == true) then
    -- QoL: swap fluid outputs to match inputs of another recipe
    -- just copied from original and swapped outputs
    data.raw["assembling-machine"]["kr-electrolysis-plant"].fluid_boxes = {
      -- Input
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 10,
        base_level = -1,
        pipe_connections = { { type = "input", position = { -3, -1 } } },
      },
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 10,
        base_level = -1,
        pipe_connections = { { type = "input", position = { -3, 1 } } },
      },
      -- Output
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 10,
        base_level = 1,
        pipe_connections = { { type = "output", position = { 3, 1 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 10,
        base_level = 1,
        pipe_connections = { { type = "output", position = { 3, -1 } } },
      },
      off_when_no_fluid_recipe = false,
    }
  end
end

--local electric_boiling = require("__space-exploration__/prototypes/phase-3/electric-boiling.lua")
local data_util = require("__space-exploration__/data_util")

local heat_capacity = data_util.string_to_number(data.raw.fluid.steam.heat_capacity)
local boiler_power = 5000000
local efficiency = 0.9

-- push high degree steam to the end
local order_5000 = "b-a-b-z"
if (settings.startup["xor-enable-900-steam"].value == true or settings.startup["xor-enable-415-steam"].value == true) then
  data.raw["recipe"]["se-electric-boiling-steam-5000"].order = order_5000
end

if (settings.startup["xor-enable-900-steam"].value == true) then

  local order_900 = "b-a-b-x"

  data:extend({
    {
      type = "recipe",
      name = data_util.mod_prefix .. "electric-boiling-steam-900",
      results = {
        { type = "fluid", name = "steam", amount = 100, temperature = 900 },
      },
      enabled = false,
      energy_required = (900-15) * 100 * heat_capacity / boiler_power / efficiency,
      ingredients = {
        { type = "fluid", name = "water", amount = 100 },
      },
      subgroup = "water",
      requester_paste_multiplier = 1,
      always_show_made_in = false,
      category = data_util.mod_prefix .. "electric-boiling",
      order = order_900
    }
  })
  table.insert(data.raw["technology"]["se-electric-boiler"].effects, {type = "unlock-recipe",recipe = data_util.mod_prefix .. "electric-boiling-steam-900"})
end

if (settings.startup["xor-enable-415-steam"].value == true) then

  local order_415 = "b-a-b-c"
  local order_500 = "b-a-b-d"

  data:extend({
    {
      type = "recipe",
      name = data_util.mod_prefix .. "electric-boiling-steam-415",
      results = {
        { type = "fluid", name = "steam", amount = 100, temperature = 415 },
      },
      enabled = false,
      energy_required = (415-15) * 100 * heat_capacity / boiler_power / efficiency,
      ingredients = {
        { type = "fluid", name = "water", amount = 100 },
      },
      subgroup = "water",
      requester_paste_multiplier = 1,
      always_show_made_in = false,
      category = data_util.mod_prefix .. "electric-boiling",
      order = order_415
    }
  })
  data.raw["recipe"]["se-electric-boiling-steam-500"].order = order_500
  table.insert(data.raw["technology"]["se-electric-boiler"].effects, {type = "unlock-recipe",recipe = data_util.mod_prefix .. "electric-boiling-steam-415"})
end

if mods["Krastorio2"] then
  if (settings.startup["xor-enable-uranium-balance"].value == true) then

    data.raw["recipe"]["uranium-fuel-cell"].ingredients = {
      {"steel-plate", 1},
      {"uranium-238", 8}, -- down from 10
      {"uranium-235", 1} -- down from 2
    }

    -- SE post process overwrites those:
    --krastorio.recipes.replaceProduct("nuclear-fuel-reprocessing", "uranium-238", {"uranium-238", 3})
    --krastorio.recipes.replaceProduct("nuclear-fuel-reprocessing", "stone", {"stone", 2})

    -- SE post process overwrites those:
    --[[data.raw["recipe"]["nuclear-fuel-reprocessing"].results = {
      {type="item", name="uranium-238", amount = 4}, -- down from 5
      {type="item", name="stone", amount = 2}, -- down from 3
      {type="item", name="tritium", probability = 0.12, amount = 1} --  down from 15%
    }]]

    -- so solution is to make own copy of recipe and...
    local copy_of_reprocessing_recipe = table.deepcopy(data.raw["recipe"]["nuclear-fuel-reprocessing"])
    copy_of_reprocessing_recipe.name = mod_prefix .. copy_of_reprocessing_recipe.name
    copy_of_reprocessing_recipe.results = {
      {type="item", name="uranium-238", amount = 4}, -- down from 5
      {type="item", name="stone", amount_min = 2, amount_max = 3}, -- down from 3
      {type="item", name="tritium", probability = 0.12, amount = 1} --  down from 15%
    }
    data:extend({copy_of_reprocessing_recipe})
    -- ...overwrite original in tech
    data.raw["technology"]["nuclear-fuel-reprocessing"].effects = {
      {type = "unlock-recipe", recipe = copy_of_reprocessing_recipe.name}
    }
    -- removing it breaks mods that modify this recipe after this mod
    --data.raw["recipe"]["nuclear-fuel-reprocessing"] = nil

  end
end

if mods["Krastorio2"] then
  if (settings.startup["xor-enable-dirty-water-balance"].value == true) then

    data.raw["recipe"]["se-dirty-water-filtration-iridium"].normal.results = {
      {type = "fluid", name = "water", amount = 90},
      {name = "stone", probability = 0.30, amount = 1},
      --{name = "se-iridium-ore-crushed", probability = 0.10, amount = 1},
      {name = "se-iridium-ore-crushed", probability = 0.50, amount = 1},
      --{name = "se-vulcanite-ion-exchange-beads", probability = 0.6, amount =1}
      {name = "se-vulcanite-ion-exchange-beads", probability = 0.7, amount =1}
    }

    data.raw["recipe"]["se-dirty-water-filtration-holmium"].normal.results = {
      {type = "fluid", name = "water", amount = 90},
      {name = "stone", probability = 0.30, amount = 1},
      --{name = "se-holmium-ore-crushed", probability = 0.10, amount = 1},
      {name = "se-holmium-ore-crushed", probability = 0.50, amount = 1},
      --{name = "se-cryonite-ion-exchange-beads", probability = 0.6, amount =1}
      {name = "se-cryonite-ion-exchange-beads", probability = 0.7, amount =1}
    }

  end
end

-- seems like this (annoying) workaround is actually not needed:
--[[
local copy_of_dirty_iridium_water_cleaning = table.deepcopy(data.raw["recipe"]["se-dirty-water-filtration-iridium"])
local copy_of_dirty_holmium_water_cleaning = table.deepcopy(data.raw["recipe"]["se-dirty-water-filtration-holmium"])
copy_of_dirty_iridium_water_cleaning.name = mod_prefix .. "iridium-water-cleaning"
copy_of_dirty_holmium_water_cleaning.name = mod_prefix .. "holmium-water-cleaning"
--log (serpent.block ("before:"))
--log (serpent.block (copy_of_dirty_iridium_water_cleaning))
copy_of_dirty_iridium_water_cleaning.normal.results = {
  {type = "fluid", name = "water", amount = 90},
  {name = "stone", probability = 0.30, amount = 1},
  {name = "se-iridium-ore-crushed", probability = 0.50, amount = 1},
  {name = "se-vulcanite-ion-exchange-beads", probability = 0.7, amount =1}
}
--log (serpent.block ("after:"))
--log (serpent.block (copy_of_dirty_iridium_water_cleaning))
copy_of_dirty_holmium_water_cleaning.normal.results = {
  {type = "fluid", name = "water", amount = 90},
  {name = "stone", probability = 0.30, amount = 1},
  {name = "se-holmium-ore-crushed", probability = 0.50, amount = 1},
  {name = "se-cryonite-ion-exchange-beads", probability = 0.7, amount =1}
}
data:extend({copy_of_dirty_iridium_water_cleaning})
data:extend({copy_of_dirty_holmium_water_cleaning})
data.raw["technology"]["se-processing-iridium"].effects = {
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "iridium-ore-crushed"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "iridium-powder"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "iridium-blastcake"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "iridium-ingot"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "iridium-ingot-to-plate"},
  {type = "unlock-recipe", recipe = copy_of_dirty_iridium_water_cleaning.name}
}
data.raw["technology"]["se-processing-holmium"].effects = {
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "holmium-ore-crushed"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "holmium-powder"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "holmium-chloride"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "holmium-ingot-no-vulcanite"},
  {type = "unlock-recipe", recipe = data_util.mod_prefix .. "holmium-ingot-to-plate"},
  {type = "unlock-recipe", recipe = copy_of_dirty_holmium_water_cleaning.name}
}
data.raw["recipe"]["se-dirty-water-filtration-iridium"] = nil
data.raw["recipe"]["se-dirty-water-filtration-holmium"] = nil
]]

--[[
data.raw["recipe"]["enriched-iron"].order = "a-a-a-04"
data.raw["recipe"]["dirty-water-filtration-1"].order = "a-a-a-03"
data.raw["recipe"]["enriched-copper"].order = "a-a-a-05"
data.raw["recipe"]["dirty-water-filtration-2"].order = "a-a-a-04"
data.raw["recipe"]["rare-metals"].order = "a-a-a-17"
data.raw["recipe"]["enriched-rare-metals"].order = "a-a-a-16"
data.raw["recipe"]["dirty-water-filtration-3"].order = "a-a-a-15"
data.raw["recipe"]["imersite-powder"].order = "a-a-a-17"
]]
