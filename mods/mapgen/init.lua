
if minetest.get_mapgen_params().mgname == "singlenode" then
	local ground_level = tonumber(minetest.settings:get("water_level") or 1)
	local air = minetest.get_content_id("air")
	local stone = minetest.get_content_id("minecraft:stone")
	local grass = minetest.get_content_id("minecraft:grass")
	
	minetest.register_on_generated(function(minp, maxp, blockseed)
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local va = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
		
		local nodes = vm:get_data()
		
		for i, _ in pairs(nodes) do
			local y = va:position(i).y
			if y < ground_level then
				nodes[i] = stone
			elseif y == ground_level then
				nodes[i] = grass
			else
				nodes[i] = air
			end
		end
		
		vm:set_data(nodes)
		vm:write_to_map()
	end)
	
	-- see https://github.com/minetest/minetest/issues/12782
	if not minetest.settings:get("static_spawnpoint") then
		local spawnpos = vector.new(0, ground_level+1, 0)
		minetest.register_on_joinplayer(function(player, lastlogin)
			if not lastlogin then
				player:set_pos(spawnpos)
			end
		end)
		minetest.register_on_respawnplayer(function(player)
			player:set_pos(spawnpos)
			return true
		end)
	end
else
	-- FIXME: Why dosen't node_top work properly?
	minetest.register_biome({
		name = "cavegame",
		node_dust = "minecraft:grass",
	--	node_top = "minecraft:grass",
	--	depth_top = 1,
		node_stone = "minecraft:stone",
		heat_point = 50,
		humidity_point = 50,
		y_min = -3100, y_max = 3100,
	})
end
