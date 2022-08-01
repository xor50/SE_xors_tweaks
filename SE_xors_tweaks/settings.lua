local mod_prefix = "xor-"

data:extend({
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-advanced-explosives",
    setting_type = "startup",
    default_value = true,
    order = "01"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-mineral-water-filtering",
    setting_type = "startup",
    default_value = true,
    order = "02"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-chemicals-fuel-value",
    setting_type = "startup",
    default_value = true,
    order = "03"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "swap-electrolysis-outputs",
    setting_type = "startup",
    default_value = true,
    order = "04"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-coal-landfill",
    setting_type = "startup",
    default_value = true,
    order = "05"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-increased-molten-density",
    setting_type = "startup",
    default_value = true,
    order = "06"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-cryo-cooled-casting-recipes",
    setting_type = "startup",
    default_value = true,
    order = "07"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-water-cooled-casting-recipes",
    setting_type = "startup",
    default_value = true,
    order = "08"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-increased-caster-speed",
    setting_type = "startup",
    default_value = true,
    order = "09"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-robot-cargo-fix",
    setting_type = "startup",
    default_value = true,
    order = "10"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-aai-furnace-module-balancing",
    setting_type = "startup",
    default_value = true,
    order = "11"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-k2-advanced-chem-plant-balancing",
    setting_type = "startup",
    default_value = true,
    order = "12"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-kiln-recipes-in-smelting-furnaces",
    setting_type = "startup",
    default_value = false,
    order = "13"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-900-steam",
    setting_type = "startup",
    default_value = false,
    order = "14"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-uranium-balance",
    setting_type = "startup",
    default_value = true,
    order = "15"
  },
})