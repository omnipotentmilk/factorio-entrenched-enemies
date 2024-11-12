script.on_init(function() end)

script.on_event(defines.events.on_biter_base_built, function(event)
	if event.entity.quality.next == nil then
		return
	end
	local Quality = event.entity.quality

	local surface = event.entity.surface.name
	local roll = 0
	local upgradeMultiplier = settings.global["entrenched-enemies-base-upgrade-multiplier"].value
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

	local base = { name = event.entity.name, position = event.entity.position, force = event.entity.force }
	event.entity.destroy()
	game.surfaces[surface].create_entity({
		name = base.name,
		position = base.position,
		force = base.force,
		quality = Quality,
	})

	if settings.global["entrenched-enemies-debug"].value == true then
		game.players[1].print(
			string.format(
				"Placed %s with %s quality at %f %f",
				base.name,
				Quality.name,
				base.position.x,
				base.position.y
			)
		)
	end
end

if mods["space-age"] then
  -- demolishers can spawn as quality variants
  -- NOTE: no way to do this yet. Waiting on API changes to allow spawning an entity with quality

end
