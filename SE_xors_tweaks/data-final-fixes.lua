
-- fix K2 bots having way too large cargo size
if mods["Krastorio2"]
    then data.raw["logistic-robot"]["logistic-robot"].max_payload_size = 2
end

-- increase speed (by factor of 2) of casting machine so that a less ridicoulous number of machines is needed
local casting_machine_speed_factor = 2
data.raw["assembling-machine"]["se-casting-machine"].crafting_speed = data.raw["assembling-machine"]["se-casting-machine"].crafting_speed * casting_machine_speed_factor

-- increase energy_usage to balance out the fewer needed machines and the steam return of water cooling
data.raw["assembling-machine"]["se-casting-machine"].energy_usage = "100kW" -- "50kW" *2

-- reduce number of module slots of AAI industrial furnace from 5 to 4 so K2 advanced furnace (with 5 slots) is more of an upgrade
--data.raw["assembling-machine"]["industrial-furnace"].module_specification = { module_slots = 4 }
if data.raw["assembling-machine"]["kr-advanced-furnace"]
    then data.raw["assembling-machine"]["industrial-furnace"].module_specification = { module_slots = 4 }
end

local mod_prefix = "xor-"
-- local molten = "se%-molten"
local molten = "molten"
local denseness_factor = 2 -- make denser by this factor
local add_cryo = {}
local add_water = {}
local ingot = "ingot"
--local boost = 0.9

-- make molten metal denser (as in: recipes put out less and recipes require less)
for name, recipe in pairs(data.raw["recipe"]) do
    if recipe.ingredients ~= nil then
        for key, ingredient in pairs(recipe.ingredients) do
            if ingredient.name ~= nil then
                if string.find(ingredient.name, molten) then
                    ingredient.amount = ingredient.amount/denseness_factor
                    table.insert(add_cryo, recipe.name) -- add new cryo recipes
					table.insert(add_water, recipe.name) -- add new cryo recipes
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
    --if recipe.category == "kiln" then recipe.category = "smelting" end
end


-- add cryo tech
data:extend{
    {
    name = mod_prefix .. "cryo-cooling-ingots",
    type = "technology",
    icons = {
        {
            icon = data.raw["technology"]["se-processing-cryonite"].icon,
            icon_size = data.raw["technology"]["se-processing-cryonite"].icon_size,
        },
        {
            icon = data.raw["item"]["se-iron-ingot"].icon,
            icon_size = data.raw["item"]["se-iron-ingot"].icon_size,
            scale = .5,
            shift = {48,48},
        },
        {
            icon = data.raw["item"]["se-copper-ingot"].icon,
            icon_size = data.raw["item"]["se-copper-ingot"].icon_size,
            scale = .5,
            shift = {16,48},
        },
        {
            icon = data.raw["item"]["se-holmium-ingot"].icon,
            icon_size = data.raw["item"]["se-holmium-ingot"].icon_size,
            scale = .5,
            shift = {48,16},
        },
        {
            icon = data.raw["item"]["se-beryllium-ingot"].icon,
            icon_size = data.raw["item"]["se-beryllium-ingot"].icon_size,
            scale = .5,
            shift = {16,16},
        },
        {
            icon = data.raw["item"]["se-steel-ingot"].icon,
            icon_size = data.raw["item"]["se-steel-ingot"].icon_size,
            scale = .5,
            shift = {-16,48},
        },
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
			{"se-material-science-pack-1", 1},
        },
        time = 60,
    },
    prerequisites = {
		"se-processing-cryonite",
		"se-space-hypercooling-2",
		"se-pyroflux-smelting",
    },
    effects = {},
    },
}

local cryo_tech = data.raw["technology"][mod_prefix .. "cryo-cooling-ingots"]

-- add water tech
data:extend{
    {
    name = mod_prefix .. "water-cooling-ingots",
    type = "technology",
    icons = {
        {
            --icon = data.raw["fluid"]["water"].icon,
            --icon_size = data.raw["fluid"]["water"].icon_size,
			icon = data.raw["technology"]["se-pyroflux-smelting"].icon,
            icon_size = data.raw["technology"]["se-pyroflux-smelting"].icon_size,
        },
        {
            icon = data.raw["fluid"]["water"].icon,
            icon_size = data.raw["fluid"]["water"].icon_size,
            scale = 3.0,
            shift = {50,50},
        },
    },
    unit = {
        count = 100,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"se-rocket-science-pack", 1},
            {"space-science-pack", 1},
            {"production-science-pack", 1},
        },
        time = 60,
    },
    prerequisites = {
		"se-space-hypercooling-1",
		"se-pyroflux-smelting",
    },
    effects = {},
    },
}

local water_tech = data.raw["technology"][mod_prefix .. "water-cooling-ingots"]

-- add fluid boxes to casting machine
data.raw["assembling-machine"]["se-casting-machine"].fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture = pipe_pics,
    pipe_covers = pipecoverspictures(),
    base_area = 1,
    base_level = -1,
    height = 2,
    pipe_connections = {{ type="input-output", position = {-2, .5} }},
    secondary_draw_orders = { north = -1, east = -1, west = -1 },
    --filter = "se-cryonite-slush",
  },
  {
    production_type = "output",
    pipe_picture = pipe_pics,
    pipe_covers = pipecoverspictures(),
    base_area = 1,
    base_level = -1,
    height = 2,
    pipe_connections = {{ type="input-output", position = {0, -1.5} }},
    secondary_draw_orders = { north = -1, east = -1, west = -1 },
  },
  {
    production_type = "input",
    pipe_picture = pipe_pics,
    pipe_covers = pipecoverspictures(),
    base_area = 1,
    base_level = -1,
    height = 2,
    pipe_connections = {{ type="input-output", position = {2, .5} }},
    secondary_draw_orders = { north = -1, east = -1, west = -1 },
    --filter = "se-cryonite-slush",
  },
  {
    production_type = "input",
    pipe_picture = pipe_pics,
    pipe_covers = pipecoverspictures(),
    base_area = 1,
    base_level = -1,
    height = 2,
    pipe_connections = {{ type="input-output", position = {0, 1.5} }},
    secondary_draw_orders = { north = -1, east = -1, west = -1 },
  },
}

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
            {
                {
                    icon = data.raw["item"][recipe.name].icon,
                    icon_size = data.raw["item"][recipe.name].icon_size,
                },
                {
                    icon = data.raw["fluid"]["se-cryonite-slush"].icon,
                    icon_size = data.raw["fluid"]["se-cryonite-slush"].icon_size,
                    scale = 0.25,
                    shift = {7,7}
                }
            }
        elseif data.raw["recipe"][recipe.name].icon then
            new_recipe.icons =
            {
                {
                    icon = data.raw["recipe"][recipe.name].icon,
                    icon_size = data.raw["recipe"][recipe.name].icon_size,
                },
                {
                    icon = data.raw["fluid"]["se-cryonite-slush"].icon,
                    icon_size = data.raw["fluid"]["se-cryonite-slush"].icon_size,
                    scale = 0.25,
                    shift = {7,7}
                }
            }
        end
    end
end

for key, value in pairs(add_cryo) do
    add_cryoslush_cooled_ingot(value)
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
            {
                {
                    icon = data.raw["item"][recipe.name].icon,
                    icon_size = data.raw["item"][recipe.name].icon_size,
                },
                {
                    icon = data.raw["fluid"]["water"].icon,
                    icon_size = data.raw["fluid"]["water"].icon_size,
                    scale = 0.25,
                    shift = {7,7}
                }
            }
        elseif data.raw["recipe"][recipe.name].icon then
            new_recipe.icons =
            {
                {
                    icon = data.raw["recipe"][recipe.name].icon,
                    icon_size = data.raw["recipe"][recipe.name].icon_size,
                },
                {
                    icon = data.raw["fluid"]["water"].icon,
                    icon_size = data.raw["fluid"]["water"].icon_size,
                    scale = 0.25,
                    shift = {7,7}
                }
            }
        end
    end
end

for key, value in pairs(add_water) do
    add_water_cooled_ingot(value)
end