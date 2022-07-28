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
})