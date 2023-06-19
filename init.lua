local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
				or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

local function place_arch(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return minetest.item_place(itemstack)--return itemstack
	end
	return rotate_and_place(itemstack, placer, pointed_thing)
end

local arch_node_list = {
	{name = "_1", desc = "Lancet Arch", tex = "arch_lancet"},
	{name = "_2", desc = "Lancet Ridge", tex = "arch_lancet_top"},
	{name = "_3", desc = "Ogee Arch", tex = "ogee_arch"},
	{name = "_4", desc = "Ogee Ridge", tex = "ogee_arch_top"},
	{name = "_5", desc = "Inflexed Arch", tex = "inflexed_arch"},
	{name = "_6", desc = "Inflexed Ridge", tex = "inflexed_arch_top"},
	{name = "_7", desc = "Tudor Arch Center", tex = "pointed_segmented_arch"},
	{name = "_8", desc = "Tudor Ridge Center", tex = "pointed_segmented_arch_top"},
	{name = "_9", desc = "Large Curved Cornice", tex = "18"},
	{name = "_10", desc = "Large Rounded Cornice", tex = "15"},
	{name = "_11", desc = "Medium Curved Cornice", tex = "8"},
	{name = "_12", desc = "Medium Rounded Cornice", tex = "3"},
	{name = "_13", desc = "High Thin Cornice", tex = "7"},
	{name = "_14", desc = "Very Large Rounded Cornice", tex = "10"},
	{name = "_15", desc = "Medium Wavy Cornice", tex = "ogee_arch_side_2"},
	{name = "_16", desc = "Large Wavy Cornice", tex = "ogee_arch_side"},
	{name = "_17", desc = "with Groove", tex = "11"},
	{name = "_18", desc = "Small Cornice", tex = "5"},
}

--local material_list = {}

local function register_arch(material_list,mat_modname)
	for _, material in pairs(material_list) do
		local material_node = minetest.registered_nodes[mat_modname..":"..material]
		if material_node then
			for _, shape in pairs(arch_node_list) do
				local def = table.copy(material_node)
				def.drawtype = "mesh"
				def.paramtype = "light"
				def.paramtype2 = "facedir"
				def.description = def.description .. " " .. shape.desc
				def.mesh = shape.tex .. ".obj"
				def.on_place = place_arch
				def.place_param2 = nil
				minetest.register_node("arch_prototype:" .. material .. shape.name, def)
			end
		end
	end
end

--MOREBLOCKS
if minetest.get_modpath("moreblocks") then
	local material_list = {
		"copperpatina",
		"iron_stone_bricks",
		"grey_bricks",
		"coal_stone_bricks",
		"cactus_brick",
		"checker_stone_tile",
		"circle_stone_bricks",
		"stone_tile",
	}
	register_arch(material_list, "moreblocks")
end

--DEFAULT
if minetest.get_modpath("default") then
	local material_list = {
		"acacia_wood",
		"aspen_wood",
		"brick",
		"bronzeblock",
		"copperblock",
		"desert_sandstone_block",
		"desert_sandstone_brick",
		"desert_stone_block",
		"desert_stonebrick",
		"junglewood",
		"pine_wood",
		"obsidian_block",
		"obsidianbrick",
		"silver_sandstone_block",
		"silver_sandstone_brick",
		"steelblock",
		"stone_block",
		"stonebrick",
		"tinblock",
		"wood",
	}
	register_arch(material_list, "default")
end

--MOREORES
if minetest.get_modpath("moreores") then
	local material_list = {
		"mithril_block",
		"silver_block",
	}
	register_arch(material_list, "moreores")
end

--MORETREES
if minetest.get_modpath("moretrees") then
	local material_list = {
		"beech_planks",
		"apple_tree_planks",
		"oak_planks",
		"sequoia_planks",
		"birch_planks",
		"palm_planks",
		"date_palm_planks",
		"spruce_planks",
		"cedar_planks",
		"poplar_planks",
		"poplar_small_planks",
		"willow_planks",
		"rubber_tree_planks",
		"fir_planks",
		"jungletree_planks",
	}
	register_arch(material_list, "moretrees")
end

--UNIFIEDBRICKS
if minetest.get_modpath("unifiedbricks") then
	local material_list = {
		"brickblock_multicolor_dark",
		"brickblock_multicolor_light",
		"brickblock_multicolor_medium",
	}
	register_arch(material_list, "unifiedbricks")
end

--COLOREDWOOD
if minetest.get_modpath("coloredwood") then
	local material_list = {
		"wood_block",
--		"",
	}
	register_arch(material_list, "coloredwood")
end

--ETHEREAL
if minetest.get_modpath("ethereal") then
	local material_list = {
		"banana_wood",
		"bamboo_block",
		"birch_wood",
		"basandra_wood",
		"blue_marble",
		"blue_marble_tile",
		"crystal_block",
		"frost_wood",
		"olive_wood",
		"palm_wood",
		"redwood_wood",
		"sakura_wood",
		"yellow_wood",
		"willow_wood",
		"snowbrick",
		"icebrick",
	}
	register_arch(material_list, "ethereal")
end

--BAKEDCLAY
if minetest.get_modpath("bakedclay") then
	local material_list = {
		"terracotta_black",
		"black",
		"terracotta_blue",
		"blue",
		"terracotta_brown",
		"brown",
		"terracotta_cyan",
		"cyan",
		"terracotta_dark_green",
		"dark_green",
		"terracotta_dark_grey",
		"dark_grey",
		"terracotta_green",
		"green",
		"terracotta_grey",
		"grey",
		"terracotta_magenta",
		"magenta",
		"terracotta_orange",
		"orange",
		"terracotta_pink",
		"pink",
		"terracotta_red",
		"red",
		"terracotta_violet",
		"violet",
		"terracotta_white",
		"white",
		"terracotta_yellow",
		"yellow",
		"natural",
	}
	register_arch(material_list, "bakedclay")
end

--[[
if minetest.get_modpath("") then
	local material_list = {
		"",
		"",
	}
	register_arch(material_list, "")
end]]