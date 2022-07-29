local mod_prefix = "xor-"

data:extend({
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-advanced-explosives",
    setting_type = "startup",
    default_value = true,
    order = "1"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-mineral-water-filtering",
    setting_type = "startup",
    default_value = true,
    order = "2"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-chemicals-fuel-value",
    setting_type = "startup",
    default_value = true,
    order = "3"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "swap-electrolysis-outputs",
    setting_type = "startup",
    default_value = true,
    order = "4"
  },
  {
    type = "bool-setting",
    name = mod_prefix .. "enable-coal-landfill",
    setting_type = "startup",
    default_value = true,
    order = "5"
  },
})