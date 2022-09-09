local mod_prefix = "xor-"


-- filtering recipe
data:extend{{
  type = "recipe",
  name = mod_prefix .. "mineral-water-filtering",
  energy_required = 3,
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
    {type="fluid", name="mineral-water", amount = 100},
    {type="item", name="sand", amount = 8},
  },
  results = {
    {type="fluid", name="dirty-water", amount = 80},
    --{type="item", name="sand", amount_min = 1, amount_max = 5},
    {type="item", name="sand", probability = 0.80, amount = 1},
    {type="item", name="quartz", probability = 0.08, amount = 1},
    {type="item", name="raw-rare-metals", probability = 0.08, amount = 1},
    {type="item", name="lithium-chloride", probability = 0.08, amount = 1},
    {type="item", name="sulfur", probability = 0.08, amount = 1}
  },
  --main_product = "dirty-water", -- overwrites manual naming in locale if set
  order = item_name,
  allow_decomposition = false,
  crafting_machine_tint = {
    primary = { r = 0.96, g = 0.64, b = 0.38, a = 0.6 }, --dirty
    secondary = { r = 0.55, g = 0.55, b = 0.51, a = 0.5 }, --clear
  }
}}

-- filtering tech
data:extend{{
  name = mod_prefix .. "mineral-water-filtering",
  type = "technology",
  icons = {
    {
      icon = data.raw["item"]["kr-filtration-plant"].icon,
      icon_size = data.raw["item"]["kr-filtration-plant"].icon_size,
      scale = 0.80,
    },
    {
      icon = data.raw["fluid"]["mineral-water"].icon,
      icon_size = data.raw["fluid"]["mineral-water"].icon_size,
      scale = 0.4,
      shift = {-19,19},
    },
    {
      icon = data.raw["fluid"]["dirty-water"].icon,
      icon_size = data.raw["fluid"]["dirty-water"].icon_size,
      scale = 0.4,
      shift = {19,19},
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
    "kr-mineral-water-gathering",
    "kr-lithium-processing"
  },
  effects = {
    {type = "unlock-recipe", recipe = mod_prefix .. "mineral-water-filtering"}
  }
}}


-- boiling recipe
data:extend{{
  type = "recipe",
  name = mod_prefix .. "mineral-water-boiling",
  energy_required = 12,
  enabled = false,
  category = "smelting",
  subgroup = "raw-material",
  icons = {
    {icon = data.raw["fluid"]["mineral-water"].icon, icon_size = data.raw["fluid"]["mineral-water"].icon_size},
    {
      icon = data.raw.fluid["se-pyroflux"].icon,
      icon_size = data.raw.fluid["se-pyroflux"].icon_size,
      scale = 0.33*64/data.raw.fluid["se-pyroflux"].icon_size,
      shift = {5, 5}
    },
  },
  ingredients =
  {
    {type="fluid", name="mineral-water", amount = 200},
    {type="fluid", name="se-pyroflux", amount = 10}
  },
  results = {
    {type = "fluid", name="steam", amount = 100, temperature = 165},
    {type="item", name="lithium-chloride", amount = 4},
    {type="item", name="raw-rare-metals", amount = 3},
    {type="item", name="sulfur", amount = 3}
  },
  order = item_name,
  allow_decomposition = false
}}

-- boiling tech
data:extend{{
  name = mod_prefix .. "mineral-water-boiling",
  type = "technology",
  icons = {
    {
      icon = data.raw["technology"]["industrial-furnace"].icon,
      icon_size = data.raw["technology"]["industrial-furnace"].icon_size,
    },
    {
      icon = data.raw["fluid"]["se-pyroflux"].icon,
      icon_size = data.raw["fluid"]["se-pyroflux"].icon_size,
      scale = 2.0,
      shift = {-60,60},
    },
    {
      icon = data.raw["fluid"]["mineral-water"].icon,
      icon_size = data.raw["fluid"]["mineral-water"].icon_size,
      scale = 2.0,
      shift = {60,60},
    },
  },
  unit = {
    count = 150,
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
    "kr-mineral-water-gathering",
    "se-processing-vulcanite",
    "kr-lithium-processing"
  },
  effects = {
    {type = "unlock-recipe", recipe = mod_prefix .. "mineral-water-boiling"}
  }
}}
