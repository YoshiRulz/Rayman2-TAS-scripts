-- v2017-10-26/00

-- Options
function init()
	is_us = true;
end



-- Functions
function format_4h(n)
	return string.format("%08s", bizstring.hex(n));
end



lvd = {
	[0x801DC308] = "invalid (is_us == true?)",

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
};



-- Main
memory.usememorydomain("RDRAM");
init()
addr = 0x1D0A94;
if is_us then
	addr = addr + 0x100;
end
last = 0;
while true do
	val = memory.read_u32_be(addr);
	if val ~= last then
		console.write("0x"..format_4h(val)..": ");
		if lvd[val] == nil then
			console.write("unknown");
		else
			console.write(lvd[val]);
		end
		console.writeline();
		last = val;
	end
	emu.frameadvance();
end
