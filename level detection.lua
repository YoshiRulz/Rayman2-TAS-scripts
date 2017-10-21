-- v2017-10-21/00

-- Options
function init()
	delay = 90;
	is_us = false;
end



lvd = {
	[0x00000000] = "Loading/Startup", [0xCCCCCCCC] = "Startup",
	
	[0x42E44593] = "Demo #1 E/U: WoP -",
	[0x435B6199] = "Demo #2 E/U: PS LZx", --TODO
	[0x4353DA07] = "Demo #3 E: SoSaF LZ0", [0x43620DE1] = "Demo #13 U: SoSaF LZ0",
	[0xC2A44502] = "Demo #4 E: Bayou LZx", [0xC2A554AA] = "Demo #4 U: Bayou LZx", --TODO
	[0xC16DA530] = "Demo #5 E: FG LZ0", [0xC16D7597] = "Demo #5 U: FG LZ0",
	[0xC2D73A6F] = "Demo #6 E: Press LZx", [0xC2E3DD31] = "Demo #6 U: Press LZx", --TODO
	[0xC392AF57] = "Demo #7 E/U: MoA LZx", --TODO
	[0xC175EB52] = "Demo #8 E: SoRaL-A LZx", [0xC0D8B0AB] = "Demo #8 U: SoRaL-A LZx", --TODO
	[0x401AA748] = "Demo #9 E/U: TotA LZ0",
	[0x41A4201B] = "Demo #10 E/U: Canopy LZ0",
	[0xC2578685] = "Demo #11 E: WB LZx", [0xC293859F] = "Demo #11 U: WB LZx", --TODO
	[0x3EA92941] = "Demo #12 E: SoRaL-B LZx", [0x3F02242C] = "Demo #12 U: SoRaL-B LZx", --TODO
	[0xC3A20774] = "Demo #13 E / #3 U: SoSaF? LZx", --TODO also in notes
	[0xC2C9983C] = "Demo #14 E: PS LZx", [0xC2C90F6D] = "Demo #14 U: PS LZx", --TODO
	
	[0x41510FDC] = "Main Menu",
	[0x4275EC5C] = "AtB Cuts", [0x433FBF9C] = "AtB",
	[0x422C7B42] = "WoL <- AtB", [0xC0E183F0] = "HoD", [0x41100000] = "WoL",
	[0xC0C8A050] = "FG LZ0", --TODO
	[0xC3825B50] = "MoA LZ0", --TODO
	[0x69696969] = "Bonus -", --TODO first
	[0xC28AC2B1] = "Bayou LZ0", --TODO
	[0x4380CA50] = "Lyfe -",
	[0xC30F1097] = "SoWaI LZ0", --TODO
	
	[0xC226FEAC] = "MH LZ0", --TODO
	[0x43477F95] = "CoBD LZ0", --TODO
	[0x417EE800] = "Canopy LZ0", --TODO
	[0x417EE800] = "WB LZ0", --TODO
	[0x4361B752] = "SoSaF LZ0", --TODO
	[0x418E35AE] = "EC Cuts0", [0xC22999A3] = "EC LZ0", --TODO
	[0x422AE5C5] = "Press LZ0", --TODO
	[0xC2F4166A] = "TotW LZ0", --TODO
	[0xC368E9C0] = "SoRaL-A LZ0", --TODO
	
	[0x42E447C0] = "WoP -",
	[0xC3BBE6F6] = "SoRaL-B LZ0", --TODO
	[0x40BB44EC] = "TotA LZ0", --TODO
	[0xC060F2BC] = "Teensies (pre-IM?)",
	[0x436A6664] = "IM LZ0", [0x419C33D8] = "IM Cuts0", [0xC28EC88E] = "IM LZ1", [0xC3C8A7B3] = "IM LZ2",
	[0xC198104A] = "Polokus (post-IM?)",
	[0xBEEF1B01] = "PS ???" --TODO
};



-- Main
memory.usememorydomain("RDRAM");
init()
addr = 0x1D0A94;
if is_us then
	addr = addr + 0x100;
end
timer = 0;
while true do
	timer = timer - 1;
	if timer < 1 then
		val = memory.read_u32_be(addr);
		if lvd[val] == nil then
			console.log("unknown: "..string.format("%08s", bizstring.hex(val)));
		else
			console.log(lvd[val]);
		end
		timer = delay;
	end
	emu.frameadvance();
end
