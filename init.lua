local S = minetest.get_translator("digilines_lightstone")
digilines_lightstone = {}

local function on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec","field[channel;Channel;${channel}")
end
local function on_receive_fields(pos, formname, fields, sender)
	if fields.channel then
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("channel",fields.channel)
	end
end

function digilines_lightstone.add(name, base_item, texture_off, texture_on, desc)
	if not desc then
		desc = name .. " Lightstone"
	end
	minetest.register_node("digilines_lightstone:lightstone_" .. name .. "_off", {
		tiles = {texture_off},
		is_ground_content = false,
		groups = {cracky = 2},
		description = desc,
		sounds = mesecon.node_sound.stone,
		on_construct = on_construct,
		on_receive_fields = on_receive_fields,
		digiline = {effector = {action=function(pos,node,channel,msg)
			local meta = minetest.get_meta(pos)
			local setchan = meta:get_string("channel")
			if channel ~= setchan then return end

			if type(msg) == "boolean" then
				if msg == true then
					minetest.swap_node(pos, {name = "digilines_lightstone:lightstone_" .. name .. "_on", param2 = node.param2})
				end
			end
		end}},
	})
	minetest.register_node("digilines_lightstone:lightstone_" .. name .. "_on", {
		tiles = {texture_on},
		is_ground_content = false,
		groups = {cracky = 2, not_in_creative_inventory = 1},
		drop = "digilines_lightstone:lightstone_" .. name .. "_off",
		light_source = minetest.LIGHT_MAX - 2,
		sounds = mesecon.node_sound.stone,
		on_construct = on_construct,
		on_receive_fields = on_receive_fields,
		digiline = {effector = {action=function(pos,node,channel,msg)
			local meta = minetest.get_meta(pos)
			local setchan = meta:get_string("channel")
			if channel ~= setchan then return end

			if type(msg) == "boolean" then
				if msg == false then
					minetest.swap_node(pos, {name = "digilines_lightstone:lightstone_" .. name .. "_off", param2 = node.param2})
				end
			end
		end}},
	})

	minetest.register_craft({
		output = "digilines_lightstone:lightstone_" .. name .. "_off",
		recipe = {
			{"",base_item,""},
			{base_item,"mesecons_gamecompat:torch",base_item},
			{"","digilines:wire_std_00000000",""}
		}
	})

	minetest.register_craft({
		output = "digilines_lightstone:lightstone_" .. name .. "_off",
		type = "shapeless",
		recipe = {"mesecons_lightstone:lightstone_" .. name .. "_off","digilines:wire_std_00000000"}
	})
end

digilines_lightstone.add("red", "mesecons_gamecompat:dye_red", "jeija_lightstone_red_off.png", "jeija_lightstone_red_on.png", S("Red Digiline Lightstone"))
digilines_lightstone.add("green", "mesecons_gamecompat:dye_green", "jeija_lightstone_green_off.png", "jeija_lightstone_green_on.png", S("Green Digiline Lightstone"))
digilines_lightstone.add("blue", "mesecons_gamecompat:dye_blue", "jeija_lightstone_blue_off.png", "jeija_lightstone_blue_on.png", S("Blue Digiline Lightstone"))
digilines_lightstone.add("gray", "mesecons_gamecompat:dye_grey", "jeija_lightstone_gray_off.png", "jeija_lightstone_gray_on.png", S("Grey Digiline Lightstone"))
digilines_lightstone.add("darkgray", "mesecons_gamecompat:dye_dark_grey", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_darkgray_on.png", S("Dark Grey Digiline Lightstone"))
digilines_lightstone.add("yellow", "mesecons_gamecompat:dye_yellow", "jeija_lightstone_yellow_off.png", "jeija_lightstone_yellow_on.png", S("Yellow Digiline Lightstone"))
digilines_lightstone.add("orange", "mesecons_gamecompat:dye_orange", "jeija_lightstone_orange_off.png", "jeija_lightstone_orange_on.png", S("Orange Digiline Lightstone"))
digilines_lightstone.add("white", "mesecons_gamecompat:dye_white", "jeija_lightstone_white_off.png", "jeija_lightstone_white_on.png", S("White Digiline Lightstone"))
digilines_lightstone.add("pink", "mesecons_gamecompat:dye_pink", "jeija_lightstone_pink_off.png", "jeija_lightstone_pink_on.png", S("Pink Digiline Lightstone"))
digilines_lightstone.add("magenta", "mesecons_gamecompat:dye_magenta", "jeija_lightstone_magenta_off.png", "jeija_lightstone_magenta_on.png", S("Magenta Digiline Lightstone"))
digilines_lightstone.add("cyan", "mesecons_gamecompat:dye_cyan", "jeija_lightstone_cyan_off.png", "jeija_lightstone_cyan_on.png", S("Cyan Digiline Lightstone"))
digilines_lightstone.add("violet", "mesecons_gamecompat:dye_violet", "jeija_lightstone_violet_off.png", "jeija_lightstone_violet_on.png", S("Violet Digiline Lightstone"))
