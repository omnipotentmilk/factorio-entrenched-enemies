local setting_spawn_mult = settings.global["entrenched-enemies-base-spawn-multiplier"].value
local setting_health_mult = settings.global["entrenched-enemies-base-health-multiplier"].value
local setting_regen_mult = settings.global["entrenched-enemies-base-regen-multiplier"].value

-- anything that can spawn units
local spawner_type = "unit-spawner"
for k, v in pairs(data.raw[spawner_type]) do
	local cd = v.spawning_cooldown
	local max_hp = v.max_health
	local hp_regen = v.healing_per_tick
	data.raw[spawner_type][k].spawning_cooldown = { cd[0] / setting_spawn_mult, cd[1] / setting_spawn_mult }
	data.raw[spawner_type][k].max_health = max_hp * setting_health_mult
	data.raw[spawner_type][k].healing_per_tick = hp_regen * setting_regen_mult
end
