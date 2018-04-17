-- v2018-04-17/00

-- Opts
check_last = false;
check_loaded = true;
draw_to_osd = true;

--[[ Level
map_id = "level";
function format_output(v) return v end
function format_unknown(v) return "UNKNOWN: 0x"..format_4B_h(v) end
--]]
---[[ Movement
map_id = "mvmt_u";
function format_output(v) return format_mvmt_table(v) end
function format_unknown(v) return {"UNKNOWN:", "0x"..format_2B_h(v), "", "", ""} end
--]]



-- Functions
function read_n_bytes_at(addr, n) return n == 1 and memory.read_u8_be(addr) or (n == 2 and memory.read_u16_be(addr) or memory.read_u32_be(addr)) end

function format_1B_h(n) return string.format("%02s", bizstring.hex(n)) end
function format_2B_h(n) return string.format("%04s", bizstring.hex(n)) end
function format_4B_h(n) return string.format("%08s", bizstring.hex(n)) end

function rpad(s, with, to_len) return s..string.rep(with, to_len - #s) end
function format_mvmt_table(t) return rpad(t[1], " ", 16).." | "..rpad(t[2], " ", 13).." | "..rpad(t[3], " ", 13).." | "..rpad(t[4], " ", 14).." | "..t[5] end



-- Data
data_map = {
	["level"] = {
		["meta_addr_eu"] = 0x1D0A94, ["meta_addr_us"] = 0x1D0B94, ["meta_field_width"] = 4, ["meta_eu_offset"] = 0,
		[0x00000000] = "Loading/Startup", [0xCCCCCCCC] = "Startup",

		[0x42E44593] = "Demo #1 U/E: WoP -",
		[0x435B6199] = "Demo #2 U/E: PS LZ3",
		[0xC3A20774] = "Demo #3 U / #13 E: SoSaF LZ2",
		[0xC2A554AA] = "Demo #4 U: Bayou LZ1", [0xC2A44502] = "Demo #4 E: Bayou LZ1",
		[0xC16D7597] = "Demo #5 U: FG LZ0", [0xC16DA530] = "Demo #5 E: FG LZ0",
		[0xC2E3DD31] = "Demo #6 U: Press LZ1", [0xC2D73A6F] = "Demo #6 E: Press LZ1",
		[0xC392AF57] = "Demo #7 U/E: MoA LZ1",
		[0xC0D8B0AB] = "Demo #8 U: SoRaL-A LZ2", [0xC175EB52] = "Demo #8 E: SoRaL-A LZ2",
		[0x401AA748] = "Demo #9 U/E: TotA LZ0",
		[0x41A4201B] = "Demo #10 U/E: Canopy LZ0",
		[0xC293859F] = "Demo #11 U: WB LZ2", [0xC2578685] = "Demo #11 E: WB LZ2",
		[0x3F02242C] = "Demo #12 U: SoRaL-B LZ1", [0x3EA92941] = "Demo #12 E: SoRaL-B LZ1",
		[0x43620DE1] = "Demo #13 U: SoSaF LZ0", [0x4353DA07] = "Demo #3 E: SoSaF LZ0",
		[0xC2C90F6D] = "Demo #14 U: PS LZ1", [0xC2C9983C] = "Demo #14 E: PS LZ1",

		[0x41510FDC] = "Main Menu E",
		[0x4275EC5C] = "AtB Cuts0 U/E", [0x433FBF9C] = "AtB U/E",
		[0x422C7B42] = "WoL <- AtB U/E", [0xC0E183F0] = "HoD U/E", [0x41100000] = "WoL E",
		[0xC0C8A050] = "FG LZ0 U/E", [0xC145F840] = "FG LZ1 U/E", [0xC2AC756C] = "FG LZ2 U/E", [0xC2BDB373] = "FG LZ3 U/E", [0xC214239A] = "FG LZ4 U/E",
		[0xC3825B50] = "MoA LZ0 U/E", [0xC392B4E8] = "MoA LZ1 U/E",
		[0x4291DFE4] = "Bonus - U/E",
		[0xC24833D6] = "Bayou Cuts0 U", [0xC28AC2B1] = "Bayou LZ0 U/E", [0xC13FECF8] = "Bayou LZ1 U/E",
		[0x4380CA50] = "Lyfe - U/E",
		[0xC060F2BC] = "TCC - U/E",
		[0xC30F1097] = "SoWaI LZ0 U/E", [0xC30BD9F1] = "SoWaI LZ1 U/E", [0xBD5A2000] = "Polokus 1 U",

		[0xC226FEAC] = "MH LZ0 U/E", [0xC3BC156C] = "MH LZ1 U/E", [0x435CA3A0] = "MH LZ2 U/E", [0xC39B9EBF] = "MH LZ3 U/E",
		[0x43477F95] = "CoBD LZ0 U/E", [0x435F45E8] = "CoBD LZ1 U/E", [0xC2A27A10] = "CoBD LZ2 U/E",
		[0x417EE800] = "Canopy LZ0 U/E", [0xC24F0E00] = "Canopy LZ1 U/E", [0x41464000] = "Canopy LZ2 U/E",
		[0xC2563383] = "WB LZ0 U/E", [0x425359BE] = "WB LZ1 U/E", [0xC297F280] = "WB LZ2 U/E",
		[0x4361B752] = "SoSaF LZ0 U/E", [0xC2F7E5F8] = "SoSaF LZ1 <- LZ0 U", [0xC3A2282F] = "SoSaF LZ2 U", [0xC357A18A] = "SoSaF LZ1 <- LZ2 U", [0xC35C0EAD] = "SoSaF LZ3 U",
		[0x43387243] = "SoSaF LZ4 <- LZ3 U", [0x438A50E2] = "SoSaF LZ5 <- LZ4 U", [0x435A1EED] = "SoSaF LZ4 <- LZ5 U", [0x433625D3] = "SoSaF LZ6", [0x4340F423] = "SoSaF LZ5 <- LZ6 U", [0xC183B04E] = "Polokus 2 U",
		[0x418E35AE] = "EC Cuts0 U/E", [0xC22999A3] = "EC LZ0 U/E", [0xC320961A] = "EC LZ1 U", [0x427FA376] = "EC LZ2 U",
		[0x422AE5C5] = "Press LZ0 U/E", [0xC2FC7F4E] = "Press LZ1 U", [0x42B5A035] = "Press LZ2 U",
		[0xC2F4166A] = "TotW LZ0 E", [0xC29CB89C] = "TotW LZ1 U",
		[0xC368E9C0] = "SoRaL-A LZ0 E", [0xC24FEE00] = "SoRaL-A LZ1 U", [0xC2C85E80] = "SoRaL-A LZ2 U",

		[0x42E447C0] = "WoP - E",
		[0xC3BBE6F6] = "SoRaL-B LZ0 E", [0xBF234FA4] = "SoRaL-B LZ1 U", [0xC1D3A218] = "SoRaL-B LZ2 U", [0xC19724DA] = "Polokus 3 U",
		[0x40BB44EC] = "TotA LZ0 E", --TODO
		[0x436A6664] = "IM LZ0 E", [0x419C33D8] = "IM Cuts0 E", [0xC28EC88E] = "IM LZ1 E", [0xC3C8A7B3] = "IM LZ2 E",
		[0xC198104A] = "Polokus (post-IM?) E", --TODO
		[0xC19092C0] = "PS Cuts0 E", [0x404CB638] = "PS LZ0 E", [0xC2C99880] = "PS LZ1 E", [0x437A7D95] = "PS LZ2 E", [0x435AE5F8] = "PS LZ3 E",
		[0x4341DAC7] = "PS LZ4 E", [0xC1933333] = "PS LZ4 no cuts E", [0x41A4FB9A] = "PS CutsX E", [0xC0973FE1] = "Credits E"
	},
	["mvmt_u"] = {
		["meta_addr_eu"] = 0x1C689E, ["meta_addr_us"] = 0x1C699E, ["meta_field_width"] = 2, ["meta_eu_offset"] = 0x100,
--		[0xXXXX] = {`damage`, `(spec./-) lat. movement`, `vert. movement`, `spec. vert. movement`, `other`}
		[0x0000] = {"", "", "", "", "Startup"}, [0xCCCC] = {"", "", "", "", "Startup"},

		[0xD478] = {"", "Idle", "", "", ""},
		[0xD498] = {"", "", "", "", "Unknown A"},
		[0xD4B8] = {"", "Move lat.", "", "", ""},
		[0xD4F8] = {"", "", "Init. jump", "", ""},
		[0xD538] = {"", "", "Fall", "", ""},
		[0xD5B8] = {"", "Move lat.", "", "Hang", ""},
		[0xD5D8] = {"", "", "", "Hang", ""},
		[0xD698] = {"", "", "Fall", "<'Copter/LDGRB", "; Loading; HoD"},
		[0xD6F8] = {"", "Idle", "", "LDGRB", ""},
		[0xD758] = {"", "", "Hover; Fall", "'Copter", ""},
		[0xD838] = {"", "", "", "Pull up <LDGRB", ""},
		[0xD878] = {"", "Idle", "", "Climb", ""},
		[0xD898] = {"", "Up", "", "Climb", ""},
		[0xD8B8] = {"", "Down", "", "Climb", ""},
		[0xD8D8] = {"", "Left", "", "Climb", ""},
		[0xD8F8] = {"", "Right", "", "Climb", ""},
		[0xDAF8] = {"", "Idle", "", "", "Swim"},
		[0xDB18] = {"", "Swim", "", "", ""},
		[0xDBB8] = {"", "Strafe right", "", "", ""},
		[0xDBF8] = {"", "Strafe left", "", "", ""},
		[0xDC18] = {"", "Strafe forward", "", "", ""},
		[0xDC38] = {"", "Strafe back", "", "", ""},
		[0xDD98] = {"", "Acc. forward", "", "", "Purple lum"},
		[0xDDD8] = {"", "Acc. back", "", "", "Purple lum"},
		[0xDF98] = {"", "Move lat.", "Init. jump", "", ""},
		[0xDFB8] = {"", "Move lat.", "Fall", "", ""},
		[0xE058] = {"", "Slide", "", "", ""},
		[0xE0D8] = {"", "Idle", "", "", "Carry"},
		[0xE0F8] = {"", "Move lat.", "", "", "Carry"},
		[0xE138] = {"", "Keg rocket", "", "", ""},
		[0xE218] = {"", "", "", "", "Release from purple lum?"},
		[0xE2B8] = {"", "", "", "", "Throw up"},
		[0xE2D8] = {"", "", "", "", "Throw forward"},
		[0xE338] = {"", "Misc. control", "", "", "; Cutscene"},
		[0xE358] = {"", "Idle", "", "Wedged", ""},
		[0xE378] = {"", "Strafe forward", "", "Wedged", ""},
		[0xE398] = {"", "Strafe back", "", "Wedged", ""},
		[0xE4B8] = {"", "Strafe right", "", "Hang", ""},
		[0xE4D8] = {"", "Strafe back", "", "Hang", ""},
		[0xE4F8] = {"", "Strafe forward", "", "Hang", ""},
		[0xE518] = {"", "Strafe left", "", "Hang", ""},
		[0xE618] = {"Death (freefall)", "", "", "", "; Teensy Doorway"},
		[0xE638] = {"", "", "Freefall", "", ""},
		[0xE678] = {"KB from hit", "", "Jump/Fall/", "/Climb/LDGRB", ""},
		[0xE698] = {"KB from hit", "", "", "", ""},
		[0xE758] = {"", "", "", "", "Pick up (orb/keg)"},
		[0xE778] = {"", "", "", "", "Pick up (plum); Catch falling obj."},
		[0xE898] = {"Death (misc.)", "", "", "", ""},
		[0xE8B8] = {"Respawn", "", "", "", ""},
		[0xE9B8] = {"", "Rail chair", "", "", ""},
		[0xE9D8] = {"", "Slide left", "", "", ""},
		[0xE9F8] = {"", "Slide right", "", "", ""},
		[0xEA98] = {"", "", "", "", "Unknown B"},
		[0xEAB8] = {"", "", "", "", "Unknown C"},
		[0xEBB8] = {"", "Idle+", "", "", "Victory dance"},
		[0xEC38] = {"Prepare shot", "", "", "", ""},
		[0xEC58] = {"Charge shot", "", "", "", ""},
		[0xEC98] = {"Fire shot", "", "", "", ""},
		[0xECD8] = {"Prepare shot", "", "", "Hang", ""},
		[0xECF8] = {"Charge shot", "", "", "Hang", ""},
		[0xED18] = {"Fire shot", "", "", "Hang", ""},
		[0xED98] = {"Charge shot", "", "", "'Copter", ""},
		[0xEDF8] = {"Prepare shot", "", "", "'Copter", ""},
		[0xEF18] = {"Fire shot", "", "(jump-cancel)", "", ""},
		[0xF038] = {"", "", "", "", "Unknown D"},
		[0xF3D8] = {"", "", "", "", "Unknown E"},
		[0xF6D8] = {"Fire shot", "", "", "'Copter", ""},
		[0xF758] = {"Charge shot", "Strafe right", "", "", ""},
		[0xF778] = {"Charge shot", "Strafe left", "", "", ""},
		[0xF998] = {"", "Idle+", "", "", "Left-hand dribble"},
		[0xF9B8] = {"", "Idle+", "", "", "Spin on finger"},
		[0xF9D8] = {"", "Idle+", "", "", "Dribble between hands"},
		[0xFA38] = {"", "Idle+", "", "", "Dribble beneath self"},
		[0xFAB8] = {"", "Idle+", "", "", "Right-hand dribble"},
		[0xFB18] = {"", "", "", "", "Concentration"}
	}
};



-- Main
memory.usememorydomain("RDRAM");
if check_loaded then
	while memory.read_u8(0x43921) > 85 do emu.frameadvance() end
end
is_eu = memory.read_u8(0x43921) == 69;
addr = is_eu and data_map[map_id]["meta_addr_eu"] or data_map[map_id]["meta_addr_us"];
all_c = data_map[map_id]["meta_field_width"] == 1 and 0xCC or (data_map[map_id]["meta_field_width"] == 2 and 0xCCCC or 0xCCCCCCCC);

if check_last then
	last = 0;
	while true do
		v = read_n_bytes_at(addr, data_map[map_id]["meta_field_width"]);
		if v ~= last then
			last = v;
			if v ~= 0 and v ~= all_c and is_eu then v = v + data_map[map_id]["meta_eu_offset"] end
			v = data_map[map_id][v] == nil and format_unknown(v) or data_map[map_id][v];
		if draw_to_osd then gui.addmessage(format_output(v)) else console.writeline(format_output(v)) end
		end
		emu.frameadvance();
	end
else
	while true do
		v = read_n_bytes_at(addr, data_map[map_id]["meta_field_width"]);
		if v ~= 0 and v ~= all_c and is_eu then v = v + data_map[map_id]["meta_eu_offset"] end
		v = data_map[map_id][v] == nil and format_unknown(v) or data_map[map_id][v];
		if draw_to_osd then gui.text(0, 8, format_output(v), 0xFF3F7FFF, "bottomleft") else console.writeline(format_output(v)) end
		emu.frameadvance();
	end
end
