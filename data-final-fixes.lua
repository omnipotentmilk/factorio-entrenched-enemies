local setting_spawn_mult = settings.startup["entrenched-enemies-base-spawn-multiplier"].value
local setting_health_mult = settings.startup["entrenched-enemies-base-health-multiplier"].value
local setting_regen_mult = settings.startup["entrenched-enemies-base-regen-multiplier"].value

-- anything that can spawn units
local spawner_type = "unit-spawner"
for k, v in pairs(data.raw[spawner_type]) do
	local cd = v.spawning_cooldown
	local max_hp = v.max_health
	local hp_regen = v.healing_per_tick
	if cd then
		for i, j in pairs(cd) do
			data.raw[spawner_type][k].spawning_cooldown[i] = j / setting_spawn_mult
		end
	end
	data.raw[spawner_type][k].max_health = max_hp * setting_health_mult
	data.raw[spawner_type][k].healing_per_tick = hp_regen * setting_regen_mult
end
