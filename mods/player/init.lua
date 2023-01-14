
local hud_flags = {
	hotbar = true,
	crosshair = false,
	wielditem = false,
	healthbar = false,
	breathbar = false,
	minimap = false,
	minimap_radar = false,
	basic_debug = true,
}

local inv_list = {}
local inv_size = 0

minetest.register_on_mods_loaded(function()
	local unordered = {}
	for name,def in pairs(minetest.registered_nodes) do
		if def.order then
			inv_size = math.max(inv_size, def.order)
			inv_list[def.order] = name
			
			minetest.override_item(name, {
			--	drop = "",
			--	stack_max = 1,
				range = 16,
			})
		else
			unordered[name] = def
		end
	end
	for name,def in pairs(unordered) do
		if not def.groups.not_in_creative_inventory then
			inv_size = inv_size + 1
			inv_list[inv_size] = name
		end
	end
end)

minetest.register_on_joinplayer(function(player, last_login)
--	player:set_sky({}) --TODO
	player:set_sun({ visible=false, sunrise_visible=false })
	player:set_moon({ visible=false })
	player:set_stars({ visible=false })
	player:set_clouds({ density=0.4 })
	player:override_day_night_ratio(1)
	player:set_lighting({ shadows=1 })

	player:set_inventory_formspec("")
--	player:set_formspec_prepend("") --TODO?
	
	player:hud_set_flags(hud_flags)
	player:hud_set_hotbar_itemcount(inv_size)
	
	local name = player:get_player_name()
	local inv = minetest.get_inventory({ type="player", name=name })
	inv:set_size("main", inv_size)
	inv:set_list("main", inv_list)
	
	player:set_properties({
		collisionbox = {-0.3, 0, -0.3, 0.3, 1.8, 0.3},
		-- TODO
	})
end)

local old_item_drop = minetest.item_drop
minetest.item_drop = function(itemstack, ...)
	return itemstack
end

local old_item_place = minetest.item_place
minetest.item_place = function(...)
	old_item_place(...)
	return nil
end

local old_handle_node_drops = core.handle_node_drops
core.handle_node_drops = function(...)
	-- Ignore all drops
end
