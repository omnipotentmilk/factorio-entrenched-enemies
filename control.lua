script.on_init(function() end)

script.on_event(defines.events.on_biter_base_built, function(event)
	qualitySpawnEntity(event.entity)
end)

script.on_event(defines.events.on_chunk_generated, function(event)
	local surface = event.surface
	local area = event.area

	-- Check if there are any enemy bases in this newly generated chunk
	for _, entity in pairs(surface.find_entities_filtered({ area = area, force = "enemy" })) do
		if entity.type == "unit-spawner" or entity.type == "turret" then -- This checks for biter nests and worms
			qualitySpawnEntity(entity)
		end
	end
end)

function qualitySpawnEntity(entity)
	if entity.quality.next == nil then
		return
	end
	local Quality = entity.quality

	local surface = entity.surface.name
	local roll = 0
	local upgradeMultiplier = settings.startup["entrenched-enemies-base-upgrade-multiplier"].value
	local targetRoll = Quality.next_probability * upgradeMultiplier

	while Quality.next ~= nil do
		roll = math.random()
		if roll <= math.min(targetRoll, 1) then
			Quality = Quality.next
		else
			break
		end
	end

	if Quality.level == 0 then
		return
	end

	local newEntity = { name = entity.name, position = entity.position, force = entity.force }
	entity.destroy()
	game.surfaces[surface].create_entity({
		name = newEntity.name,
		position = newEntity.position,
		force = newEntity.force,
		quality = Quality,
	})
end
