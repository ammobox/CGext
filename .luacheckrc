std = "lua51+minetest"
unused_args = false
allow_defined_top = true
max_line_length = 512

ignore = { "611", }

stds.minetest = {
	globals = {
		"minetest",
	},
	read_globals = {
		"DIR_DELIM",
		"core",
		"dump",
		"vector",
		"VoxelManip",
		"VoxelArea",
		"PseudoRandom",
		"ItemStack",
		table = {
			fields = {
				"copy",
			},
		},
	},
}

read_globals = {
}
