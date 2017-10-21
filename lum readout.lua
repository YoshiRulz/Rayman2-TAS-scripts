-- v2017-10-21/00

-- Options
function init()
	set_watch("fg", 90)
	-- set_watch(cages, 90)
	baseline_lums = 0;
	is_us = false;
end



-- Functions
function count_bits(n)
	c = {1431655765, 858993459, 252645135}
	n = n - bit.band(bit.rshift(n, 1), c[1]);
	n = bit.band(n, c[2]) + bit.band(bit.rshift(n, 2), c[2]);
	n = bit.band(n + bit.rshift(n, 4), c[3]);
	return bit.rshift(n * 16843009, 24);
end

function check_inmem(addr, pos)
	-- note: check/set domain before call
	return bit.check(memory.read_u8(addr), pos);
end

-- Usage: check_lum(moa[0], moa[<lum number>])
function check_lum(offset, lum)
	if lum[2] > 1 then
		sum = 0;
		for i = lum[4], lum[5], -1 do
			if check_inmem(offset + lum[3], i) then
				sum = sum + 1;
			end
		end
		return lum[1]..": "..sum.."/"..lum[2];
	end
	if check_inmem(offset + lum[3], lum[4]) then
		return "true";
	else
		return "false";
	end
end

function set_watch(lv, d)
	watching = lvd[lv][0];
	watch_ext = lvd[lv][-1];
	delay = d;
end

function format_bin_8(n)
	return string.format("%08s", bizstring.binary(n));
end



--[[ Lum data, format:
	1x lum: {"desc", 1, bytes from level offset, bit}
	5x lum: {"desc", 5, bytes from level offset, BE bit, LE bit (bit pos l->r)}
	"zX" = loading zone X, from 0
	"zY c #X" = Xth cage in zY
--]]

cages = { -- in lum format
	{"WoL LZ0 c #1", 1, 3, 7}, {"WoL LZ0 c #2", 0, 2, 0},
	{"FG LZ0 c #1", 5, 2, 1}, {"FG LZ0 c #2", 1, 2, 2}, {"FG LZ2 c #1", 5, 2, 5},
	-- i missed some, up to fg lz4 but also checking lums in lz3
	{"MoA LZ1 c #5", 0, 1, 4},
	{"Bayou LZ0 c #1", 2, 1, 5}, {"Bayou LZ0 c #2", 0, 1, 7}, {"Bayou LZ0 c #3", 2, 1, 6}, {"Bayou LZ0 c #4", 3, 0, 0}, {"Bayou LZ0 c #5", 2, 0, 1}, {"Bayou LZ1 c #1", 1, 0, 2}, {"Bayou LZ1 c #2", 0, 0, 3},
}; cages[0] = 0x1F10F0; cages[-1] = 0;

-- in lum format
masks = {{"SoWaI/???", 0, 1, 7}, {"SoSaF/???", 0, 0, 0}, {"SoRaL/???", 0, 0, 1}, {"???", 0, 0, 2}}; masks[0] = 0x1F1110; masks[-1] = 0;

lvd = {
	["wol"] = {
		{"z0 c #1", 1, 1, 6}, {"z0 bank #1", 1, 1, 3}, {"z0 bank #2", 1, 1, 5}, {"z0 waterfall", 1, 1, 7}, {"z0 climb", 1, 1, 4},
		[0] = 0x1F1134, [-1] = 0
	},
	["fg"] = {
		{"z0 c #1", 5, 3, 4, 0}, {"z0 spring", 1, 3, 6}, {"z0 log", 1, 3, 7}, {"z0 c #2", 1, 2, 3}, {"z0 lake", 1, 3, 5},
		{"z1 loner", 1, 2, 2},
		{"z2 c #1", 5, 1, 5, 1}, {"z2 keg room closer", 1, 1, 6}, {"z2 keg room further", 1, 1, 7},
		{"z3 ladder #1", 1, 0, 6}, {"z3 ladder #2", 1, 0, 5}, {"z3 pipes #1", 1, 0, 7}, {"z3 pipes #2", 1, 7, 0},
		{"z4 fall #1", 1, 7, 1}, {"z4 fall #2", 1, 7, 2}, {"z4 fall #3", 1, 7, 3}, {"z4 fall #4", 1, 7, 4}, {"z4 c #1 lums 1-2", 2, 5, 0, 1}, {"z4 c #1 lum 3", 1, 5, 3},
		{"z4 duct #1", 1, 7, 5}, {"z4 duct #2", 1, 6, 1}, {"z4 duct #3", 1, 6, 4}, {"z4 duct #4", 1, 6, 3}, {"z4 duct #5", 1, 6, 2}, {"z4 duct #6", 1, 7, 6}, {"z4 duct #7", 1, 6, 5}, {"z4 duct #8", 1, 6, 6}, {"z4 duct #9", 1, 6, 0}, {"z4 duct #10", 1, 7, 7},
		[0] = 0x1F1088, [-1] = 1
	},
	["moa"] = {
		{"z0 switch", 5, 7, 5, 1},
		{"z0 c #2", 5, 5, 4, 0}, {"z0 c #3 lums 1-2", 2, 4, 1, 0}, {"z0 c #3 lums 3-5", 3, 5, 7, 5}, {"z0 c #4", 5, 4, 6, 2},
		
		{"z1 scaffold #1", 1, 0, 2}, {"z1 scaffold #2", 1, 0, 3},
		{"z1 bombs lums 1-2", 3, 6, 2, 0}, {"z1 bombs lums 3-5", 2, 7, 7, 6}, {"z1 post lums 1-4", 4, 0, 7, 4}, {"z1 post lum 5", 1, 7, 0},
		{"z1 rock #1", 1, 7, 1}, {"z1 rock #2", 1, 0, 1}, {"z1 rock #3", 1, 0, 0}, {"z1 pirate", 5, 1, 6, 2}, {"z1 bomb lums 1-4", 4, 8, 3, 0}, {"z1 bomb lum 5", 1, 4, 7},
		
		{"z0 to cobd", 1, 6, 3},
		
		[0] = 0x1F108C, [-1] = 2
	},
	["bayou"] = {
		{"z0 c #1", 2, 0, 2, 1},
		{"z0 ladder foot #1", 1, 3, 4}, {"z0 ladder foot #2", 1, 3, 5}, {"z0 ladder foot #3", 1, 3, 6},
		{"z0 up ladder #1", 1, 1, 7}, {"z0 up ladder #2", 1, 0, 0},
		{"z0 boardwalk A #1", 1, 0, 7}, {"z0 boardwalk A #2", 1, 7, 0}, {"z0 boardwalk A #3", 1, 7, 1}, {"z0 boardwalk A #4", 1, 7, 2},
		{"z0 barrel #1", 1, 3, 7}, {"z0 barrel #2", 1, 2, 0}, {"z0 barrel #3", 1, 2, 1}, {"z0 barrel #4", 1, 2, 2}, {"z0 barrel #5", 1, 2, 3},
		{"z0 c #3", 2, 1, 6, 5},
		{"z0 to boardwalk B #1", 1, 3, 4}, {"z0 to boardwalk B #2", 1, 3, 5}, {"z0 to boardwalk B #3", 1, 3, 6}, {"z0 to boardwalk B #4", 1, 7, 6},
		{"z0 boardwalk B #1", 1, 0, 3}, {"z0 boardwalk B #2", 1, 0, 4}, {"z0 boardwalk B #3", 1, 0, 5}, {"z0 boardwalk B #4", 1, 0, 6},
		{"z0 c #4", 3, 7, 5, 3},
		{"z0 boardwalk B #5", 1, 1, 1}, {"z0 boardwalk B #6", 1, 1, 2}, {"z0 boardwalk B #7", 1, 1, 3}, {"z0 boardwalk B #8", 1, 1, 4},
		{"z0 c #5 lum 1", 1, 1, 0}, {"z0 c #5 lum 2", 1, 2, 7},
		{"z1 piranha", 1, 6, 0}, {"z1 land #1", 1, 6, 7}, {"z1 land #2", 1, 5, 0},
		{"z1 barrels #1", 1, 5, 1}, {"z1 barrels #2", 1, 5, 2}, {"z1 barrels #3", 1, 5, 3},
		{"z1 switch", 1, 5, 4},
		{"z1 midair", 1, 5, 5},
		{"z1 c #1", 1, 7, 7},
		{"z1 trampolines #1", 1, 6, 1}, {"z1 trampolines #2", 1, 6, 2}, {"z1 trampolines #3", 1, 6, 3}, {"z1 trampolines #4", 1, 6, 4}, {"z1 trampolines #5", 1, 6, 5}, {"z1 trampolines #6", 1, 6, 6},
		[0] = 0x1F1094, [-1] = 1
	},
	["lyfe"] = {[0] = 0, [-1] = 0},
	["sowai"] = {
		{"z0 c #1", 3, 0, 5, 3},
		{"z0 hill #1", 1, 7, 4},
		{"z0 hill #2", 1, 7, 5},
		{"z0 hill #3", 1, 7, 6},
		{"z0 hill #4", 1, 6, 0},
		{"z0 hill #5", 1, 6, 1},
		{"z0 hill #6", 1, 6, 2},
		{"z0 cave pool #1", 5, 6, 7, 3},
		{"z0 cave pool #2", 1, 5, 1},
		{"z0 cave pool #3", 1, 5, 0},
		{"z0 c #2 lum 1", 1, 0, 0},
		{"z0 c #2 lums 2-3", 2, 1, 7, 6},
		{"z0 cave #1", 1, 0, 1},
		{"z0 cave #2", 1, 0, 2},
		{"z0 cave #3", 1, 0, 6},
		{"z0 cave #4", 1, 0, 7},
		{"z0 keg", 5, 7, 4, 0},
		{"z0 door #1", 1, 5, 3},
		{"z0 door #2", 1, 4, 5},
		{"z0 door #3", 1, 5, 2},
		{"z0 door #4", 1, 4, 4},
		{"z0 door #5", 1, 4, 3},
		{"z0 door #6", 1, 4, 0},
		{"z0 door #7", 1, 4, 2},
		{"z0 door #8", 1, 4, 1},
		{"z0 door #9", 1, 5, 7},
		{"z0 door #10", 1, 5, 4},
		{"z0 door #10", 1, 5, 6},
		{"z0 door #12", 1, 5, 5},
		{"z1 slide #1", 1, 11, 4},
		{"z1 slide #2", 1, 11, 6},
		{"z1 slide #3", 1, 11, 0},
		{"z1 slide #4", 1, 11, 1},
		{"z1 slide #5", 1, 11, 2},
		{"z1 slide #6", 1, 11, 5},
		{"z1 slide #7", 1, 11, 3},
		{"z1 slide #8", 1, 4, 6},
		{"z1 slide #9", 1, 4, 7},
		{"z1 throne", 1, 11, 7},
		[0] = 0x1F1098
	},
	["mh"] = {
		{"z0 c #1 lums 1-2", 2, 1, 1, 0},
		{"z0 c #1 lums 3-5", 3, 2, 7, 5},
		{"z0 c #2", 5, 2, 4, 0},
		{"z0 c #2", 5, 1, 6, 2},
		
		-- post-lz:
		-- courtyard 4,2 offset 7
		-- cage 4 16,8,4 offset 0
		-- todo menhir ride
		-- 1 offset 7
		-- cage 5 offset 0 FC7Fxxxx -> FFFFxxxx
		-- lz
		[0] = 0x1F10A0
	},
	["cobd"] = {
		-- starting from 6 offset 2, going left
		-- 5x at 5-1 offset 0
		-- 0x1 offset 7
		-- hobs 7-6 offset 0
		-- 0x2 offset 7
		-- bits 64-4 offset 7
		-- 5x bit 128 offset 7 and bits 8-1 offset 6
		-- slide 5x bits 128-16 offset 6 and bit 1 offset 5
		-- 5x bits 32-2 offset 5
		-- 5x bits 128-64 offset 5 and bits 4-1 offset 4
		[0] = 0x1F10E4
	},
	["canopy"] = {[0] = 0, [-1] = 0},
	["wb"] = {[0] = 0, [-1] = 0},
	["sosaf"] = {[0] = 0, [-1] = 0},
	["ec"] = {[0] = 0, [-1] = 0},
	["press"] = {[0] = 0, [-1] = 0},
	["totw"] = {[0] = 0, [-1] = 0},
	["soral"] = {[0] = 0, [-1] = 0},
	["wop"] = {[0] = 0, [-1] = 0},
	["soralb"] = {[0] = 0, [-1] = 0},
	["tota"] = {[0] = 0, [-1] = 0},
	["im"] = {[0] = 0, [-1] = 0},
	["ps"] = {[0] = 0, [-1] = 0}
};



-- Main
memory.usememorydomain("RDRAM");
init()
if is_us then
	watching = watching + 0x100;
end
timer = 0;
function o(s)
	output = output..s;
end
while true do
	timer = timer - 1;
	if timer < 1 then
		output = count_bits(memory.read_u32_be(watching));
		if watch_ext > 0 then
			output = output + count_bits(memory.read_u32_be(watching + 4));
			if watch_ext > 1 then
				output = output + count_bits(memory.read_u32_be(watching + 8));
			end
		end
		output = output - baseline_lums;
		output = string.format("%02s", output)..";";
		if watch_ext > 0 then
			if watch_ext > 1 then
				o(" 11-8");
				for i = 0, 3 do
					o(" "..format_bin_8(memory.readbyte(watching + 8 + i)));
				end
				o(",");
			end
			o(" 4-7");
			for i = 0, 3 do
				o(" "..format_bin_8(memory.readbyte(watching + 4 + i)));
			end
			o(", 0-3");
		end
		for i = 0, 3 do
			o(" "..format_bin_8(memory.readbyte(watching + i)));
		end
		console.log(output);
		timer = delay;
	end
	emu.frameadvance();
end
