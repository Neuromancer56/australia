-- mods/australia/biome_tasman_sea.lua

local biome_name = "tasman_sea"
local node_top = "default:sand"

minetest.register_biome({
	name = biome_name,
	--node_dust = "",
	node_top = node_top,
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "",
	y_min = -64,
	y_max = 3,
	heat_point = 20,
	humidity_point = 50,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:stone_kelp_brown",
	wherein        = "default:sand",
	clust_scarcity = 9*9*9,
	clust_num_ores = 25,
	clust_size     = 6,
	biomes         = {"tasman_sea"},
	y_min     = -10,
	y_max     = -3,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:stone_kelp_giant_brown",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 8,
	biomes         = {"tasman_sea"},
	y_min     = -64,
	y_max     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:woodship",
	wherein        = "default:sand",
	clust_scarcity = 60*60*60,
	clust_num_ores = 1,
	clust_size     = 12,
	biomes         = {"tasman_sea"},
	y_min     = -64,
	y_max     = -6,
})



--
-- Decorations
--

	-- Grasses
aus.biome_register_grass_decorations(
	{
		{0.015,  0.045, 2},
		{0.03,   0.03,  1},
	},
	biome_name, node_top, "default:grass_", 3, 3
)

	-- Dry grasses
aus.biome_register_grass_decorations(
	{
		{0.01, 0.05, 5},
		{0.03, 0.03, 4},
		{0.05, 0.01, 3},
	},
	biome_name, node_top, "default:dry_grass_", 3, 3
)

--
-- ABM'S
--

-- @@@ Josselin2 - duplicate of ABM found in biome_great_australia_bight.lua
--[[
minetest.register_abm({
nodenames = {"australia:stone_kelp_brown"},
interval = 15,
chance = 5,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "australia:water_source") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "australia:kelp_brown"}) else
		return
	end
end
})
]]--

minetest.register_abm({
nodenames = {"australia:stone_kelp_giant_brown"},
interval = 12,
chance = 10,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "australia:water_source") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "australia:kelp_giant_brown"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"australia:kelp_giant_brown"},
interval = 6,
chance = 3,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
	local yyyp = {x = pos.x, y = pos.y + 3, z = pos.z}
	if minetest.get_node(pos).name == "australia:kelp_giant_brown" and
		(minetest.get_node(yp).name == "default:water_source" or
		minetest.get_node(yp).name == "australia:water_source") then
			if (minetest.get_node(yyp).name == "default:water_source" or
			minetest.get_node(yyp).name == "australia:water_source") then
				if (minetest.get_node(yyyp).name == "default:water_source" or
				minetest.get_node(yyyp).name == "australia:water_source") then
					minetest.add_node(pos, {name = "australia:kelp_giant_brown_middle"}) 
					pos.y = pos.y + 1
					minetest.add_node(pos, {name = "australia:kelp_giant_brown"}) 
				else
				return
			end
		end
	end
end
})

minetest.register_abm({
nodenames = {"australia:woodship"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
local yp = {x = pos.x, y = pos.y + 3, z = pos.z}
	if minetest.get_node(pos).name == "australia:woodship" and
	(minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "australia:water_source") then
		minetest.add_node(pos, {name = "default:sand"})

		pos.y = pos.y + 1
		pos.x = pos.x - 6

		for a = 1, 11 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
		end

		pos.z = pos.z + 1
		pos.x = pos.x - 10

		for a = 1, 9 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
		end

		pos.z = pos.z - 2
		pos.x = pos.x - 9

		for a = 1, 9 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
		end


		pos.y = pos.y + 1
		pos.x = pos.x - 8
		pos.z = pos.z - 1

		for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
		end

		pos.z = pos.z + 4
		pos.x = pos.x - 7

		for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})
		end

		pos.z = pos.z - 1
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})

		pos.z = pos.z - 1
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})

		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:tree"})

		pos.z = pos.z - 1
		pos.x = pos.x - 2
		minetest.add_node(pos, {name = "default:tree"})

		pos.z = pos.z + 2
		pos.x = pos.x - 8
		minetest.add_node(pos, {name = "default:tree"})

		pos.z = pos.z - 1
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:tree"})

		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:tree"})

		pos.z = pos.z - 1
		pos.x = pos.x + 2
		minetest.add_node(pos, {name = "default:tree"})


		pos.y = pos.y + 1
		pos.z = pos.z - 1

		for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})
		end

		pos.z = pos.z + 4
		pos.x = pos.x - 7

		for a = 1, 7 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})
		end

		pos.z = pos.z - 1
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})

		pos.z = pos.z - 1
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:wood"})

		pos.z = pos.z - 1
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:wood"})

		pos.z = pos.z + 2
		pos.x = pos.x - 8
		minetest.add_node(pos, {name = "default:wood"})

		pos.z = pos.z - 1
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:wood"})

		for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:wood"})
		end

		pos.z = pos.z - 1
		pos.x = pos.x + 4
		minetest.add_node(pos, {name = "default:wood"})

		pos.z = pos.z + 1
		pos.x = pos.x + 3
		minetest.add_node(pos, {name = "default:wood"})

		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "default:wood"})

		pos.y = pos.y - 2
		minetest.add_node(pos, {name = "default:wood"})

		pos.y = pos.y + 3
		pos.z = pos.z - 4

		for a = 1, 7 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:wood"})
		end

		pos.z = pos.z - 3

		for a = 1, 2 do
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "default:wood"})
		end

		pos.y = pos.y + 1
		pos.z = pos.z - 3

		for a = 1, 5 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:wood"})
		end

		pos.y = pos.y + 1
		pos.z = pos.z - 2
		minetest.add_node(pos, {name = "default:wood"})

		pos.y = pos.y - 7
		pos.z = pos.z + 1
		pos.x = pos.x - 2
		minetest.add_node(pos, {name = "australia:woodshipchest"})

	else
		return
	end
end
})

