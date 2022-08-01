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

local molten = "molten"
local add_cryo = {}
local add_water = {}
local ingot = "ingot"
--local boost = 0.9

local denseness_factor = 1 -- default: make not denser
if (settings.startup["xor-enable-increased-molten-density"].value == true) then
  denseness_factor = 2 -- make denser by this factor
end

-- make molten metal denser (as in: recipes put out less and recipes require less)
for name, recipe in pairs(data.raw["recipe"]) do
  if recipe.ingredients ~= nil then
    for key, ingredient in pairs(recipe.ingredients) do
      if ingredient.name ~= nil then
        if string.find(ingredient.name, molten) then
          ingredient.amount = ingredient.amount/denseness_factor
          if (settings.startup["xor-enable-cryo-cooled-casting-recipes"].value == true) then
            table.insert(add_cryo, recipe.name) -- add new cryo cooling recipes
          end
          if (settings.startup["xor-enable-water-cooled-casting-recipes"].value == true) then
            table.insert(add_water, recipe.name) -- add new water cooling recipes
          end
        end
      end
    end
  end
  if recipe.result then
    if string.find(recipe.result, molten) then
        recipe.result_count = recipe.result_count/denseness_factor
    end
  elseif recipe.results then
    for key, result in pairs(recipe.results) do
      if result.name ~= nil then
        if string.find(result.name, molten) then
          result.amount = result.amount/denseness_factor
        end
      end
    end
  end
  -- make kiln recipes available in higher tier furnaces
  if (settings.startup["xor-enable-kiln-recipes-in-smelting-furnaces"].value == true) then
    if recipe.category == "kiln" then recipe.category = "smelting" end
  end
end


if (settings.startup["xor-enable-cryo-cooled-casting-recipes"].value == true) then
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
      base_level = -1,
      height = 2,
      pipe_connections = {{ type="input-output", position = {0, -1.5} }},
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
    new_recipe.name = mod_prefix .. "z-cryoslush-cooled-" .. recipe_name
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
  for key, value in pairs(add_cryo) do
    add_cryoslush_cooled_ingot(value)
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
    new_recipe.name = mod_prefix .. "a-water-cooled-" .. recipe_name
    table.insert(new_recipe.ingredients, {type="fluid", name="water", amount = 50})
    table.insert(new_recipe.results, {type = "fluid", name="steam", amount = 25, temperature = 165})
    new_recipe.main_product = recipe.results[1].name
    --log (serpent.block (new_recipe))
    new_recipe.energy_required = new_recipe.energy_required / 1.5625
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