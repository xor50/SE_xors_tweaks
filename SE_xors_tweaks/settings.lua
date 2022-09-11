local mod_prefix = "xor-"

data:extend({
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-coal-landfill",
    setting_type = "startup",
    default_value = true,
    order = "011"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-cryo-cooled-casting-recipes",
    setting_type = "startup",
    default_value = true,
    order = "012"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-water-cooled-casting-recipes",
    setting_type = "startup",
    default_value = true,
    order = "013"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-increased-molten-density",
    setting_type = "startup",
    default_value = true,
    order = "021"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-increased-caster-speed",
    setting_type = "startup",
    default_value = true,
    order = "022"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-kiln-recipes-in-smelting-furnaces",
    setting_type = "startup",
    default_value = false,
    order = "023"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-nicer-thermofluid-numbers",
    setting_type = "startup",
    default_value = false,
    order = "024"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-no-burning-in-space",
    setting_type = "startup",
    default_value = true,
    order = "025"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "swap-electrolysis-outputs",
    setting_type = "startup",
    default_value = true,
    order = "101"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-robot-cargo-fix",
    setting_type = "startup",
    default_value = true,
    order = "102"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "fuel-cell-stack-size",
    setting_type = "startup",
    default_value = true,
    order = "103"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-advanced-explosives",
    setting_type = "startup",
    default_value = true,
    order = "111"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-mineral-water-recipes",
    setting_type = "startup",
    default_value = true,
    order = "112"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-chemicals-fuel-value",
    setting_type = "startup",
    default_value = true,
    order = "113"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-415-steam",
    setting_type = "startup",
    default_value = false,
    order = "114"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-900-steam",
    setting_type = "startup",
    default_value = false,
    order = "115"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "disable-k2-graphics",
    setting_type = "startup",
    default_value = false,
    order = "116"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-aai-furnace-module-balancing",
    setting_type = "startup",
    default_value = true,
    order = "121"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-k2-advanced-chem-plant-balancing",
    setting_type = "startup",
    default_value = true,
    order = "122"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-uranium-balance",
    setting_type = "startup",
    default_value = false,
    order = "123"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-dirty-water-balance",
    setting_type = "startup",
    default_value = true,
    order = "124"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-steel-casting-balance",
    setting_type = "startup",
    default_value = true,
    order = "125"
  },
})