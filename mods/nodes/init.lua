--mapgen shit

minetest.register_alias("mapgen_stone", "minecraft:stone")
minetest.register_alias("mapgen_water_source", "air")
minetest.register_alias("mapgen_river_water_source", "air")

--sign shit

--removed :troll:

--basic nodes

minetest.register_alias("1", "minecraft:stone")
minetest.register_alias("minecraft:1", "minecraft:stone")
minetest.register_node(":minecraft:stone", {
	order = 1,
	description = "Stone",
	tiles = { "default_cobble.png" },
	groups = { dig_immediate=3, },
	is_ground_content = true,
})

minetest.register_alias("2", "minecraft:grass")
minetest.register_alias("minecraft:2", "minecraft:grass")
minetest.register_node(":minecraft:grass", {
	order = 2,
	description = "Grass",
	tiles = { "default_grass.png" },
	groups = { dig_immediate=3, },
	is_ground_content = true,
})

minetest.register_alias("3", "minecraft:bricks")
minetest.register_alias("minecraft:3", "minecraft:bricks")
minetest.register_node(":minecraft:bricks", {
	order = 3,
	description = "Bricks",
	tiles = { "default_bricks.png" },
	groups = { dig_immediate=3, },
	is_ground_content = true,
})

minetest.register_alias("4", "minecraft:planks")
minetest.register_alias("minecraft:4", "minecraft:planks")
minetest.register_node(":minecraft:planks", {
	order = 4,
	description = "Planks",
	tiles = { "default_planks.png" },
	groups = { dig_immediate=3, },
	is_ground_content = true,
})

minetest.register_alias("4", "minecraft:planks")
minetest.register_alias("minecraft:4", "minecraft:planks")
minetest.register_node(":minecraft:planks", {
	order = 4,
	description = "Planks",
	tiles = { "default_planks.png" },
	groups = { dig_immediate=3, },
	is_ground_content = true,
	paramtype2 = "facedir",
})

minetest.register_alias("5", "minecraft:glass")
minetest.register_alias("minecraft:5", "minecraft:glass")
minetest.register_node(":minecraft:glass", {
	order = 5,
	description = "Glass",
	tiles = { "default_glass.png", "default_glass_detail.png" },
	groups = { dig_immediate=3, },
	is_ground_content = true,
	sunlight_propagates = true,
	use_texture_alpha = "clip",
	drawtype = "glasslike_framed_optional",
	paramtype = "light",
})

minetest.register_alias("6", "minecraft:pointlight")
minetest.register_alias("minecraft:6", "minecraft:pointlight")
minetest.register_node(":minecraft:pointlight", {
	order = 6,
	description = "Pointlight",
	tiles = { "default_light.png", "default_light_detail.png" },
	groups = { dig_immediate=3, },
	is_ground_content = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 16,
	drawtype = "glasslike_framed_optional",
})

--special nodes

--[[minetest.register_alias("7", "minecraft:sign") --i havent figured out why the fuck this doesnt work yet, so im just disabling it to avoid errors
minetest.register_alias("minecraft:7", "minecraft:sign")
minetest.register_node(":minecraft:sign", {
	drawtype = "nodebox",
	tiles = {"default_sign_wall_wood.png"},
	inventory_image = "default_sign_wood.png",
	wield_image = "default_sign_wood.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	use_texture_alpha = "opaque",
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
		wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
		wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
	},
	groups = def.groups,
	legacy_wallmounted = true,
	sounds = def.sounds,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local player_name = sender:get_player_name()
		if minetest.is_protected(pos, player_name) then
			minetest.record_protection_violation(pos, player_name)
			return
		end
		local text = fields.text
		if not text then
			return
		end
		if string.len(text) > 512 then
			minetest.chat_send_player(player_name, S("Text too long"))
			return
		end
		default.log_player_action(sender, "wrote \"" .. text ..
			"\" to the sign at", pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("text", text)

		if #text > 0 then
			meta:set_string("infotext", S('"@1"', text))
		else
			meta:set_string("infotext", '')
		end
	end,
end
})]]
