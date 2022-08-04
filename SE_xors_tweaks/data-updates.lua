
if (settings.startup["xor-enable-nicer-thermofluid-numbers"].value == true) then
  data.raw["recipe"]["se-radiating-space-coolant-slow"].ingredients[1].amount = data.raw["recipe"]["se-radiating-space-coolant-slow"].ingredients[1].amount + 1
  data.raw["recipe"]["se-radiating-space-coolant-slow"].results[1].amount = data.raw["recipe"]["se-radiating-space-coolant-slow"].results[1].amount + 1

  data.raw["recipe"]["se-radiating-space-coolant-normal"].ingredients[1].amount = data.raw["recipe"]["se-radiating-space-coolant-normal"].ingredients[1].amount + 1
  data.raw["recipe"]["se-radiating-space-coolant-normal"].results[1].amount = data.raw["recipe"]["se-radiating-space-coolant-normal"].results[1].amount + 1

  data.raw["recipe"]["se-radiating-space-coolant-fast"].ingredients[1].amount = data.raw["recipe"]["se-radiating-space-coolant-fast"].ingredients[1].amount + 1
  data.raw["recipe"]["se-radiating-space-coolant-fast"].results[1].amount = data.raw["recipe"]["se-radiating-space-coolant-fast"].results[1].amount + 1
end