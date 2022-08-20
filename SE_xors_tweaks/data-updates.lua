
if (settings.startup["xor-enable-nicer-thermofluid-numbers"].value == true) then
  data.raw["recipe"]["se-radiating-space-coolant-slow"].ingredients[1].amount = data.raw["recipe"]["se-radiating-space-coolant-slow"].ingredients[1].amount + 1
  data.raw["recipe"]["se-radiating-space-coolant-slow"].results[1].amount = data.raw["recipe"]["se-radiating-space-coolant-slow"].results[1].amount + 1

  data.raw["recipe"]["se-radiating-space-coolant-normal"].ingredients[1].amount = data.raw["recipe"]["se-radiating-space-coolant-normal"].ingredients[1].amount + 1
  data.raw["recipe"]["se-radiating-space-coolant-normal"].results[1].amount = data.raw["recipe"]["se-radiating-space-coolant-normal"].results[1].amount + 1

  data.raw["recipe"]["se-radiating-space-coolant-fast"].ingredients[1].amount = data.raw["recipe"]["se-radiating-space-coolant-fast"].ingredients[1].amount + 1
  data.raw["recipe"]["se-radiating-space-coolant-fast"].results[1].amount = data.raw["recipe"]["se-radiating-space-coolant-fast"].results[1].amount + 1
end

if mods["Krastorio2"] and settings.startup["xor-fuel-cell-stack-size"].value then
  data.raw["item"]["uranium-fuel-cell"].stack_size = 10
  data.raw["item"]["used-up-uranium-fuel-cell"].stack_size = 10
end
