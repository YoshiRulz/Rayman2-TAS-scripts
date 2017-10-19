-- v2017-10-20/00

-- Options
function init()
	delay = 90;
	is_us = false;
end



lvd = {
	[0] = {[0] = "Loading/Startup"}, [0xCCCCCCCC] = {[0xCCCCCCCC] = "Startup"}, [0xBF1C6FDF] = {[0xBF4AA423] = "Main Menu"},
	[0x3EAF1D3F] = {[0xBF708FB8] = "AtB"}, [0xBF07A8C6] = {[0x3F5919AC] = "WoL <- AtB"}, [0x3E937A1C] = {[0x3F752674] = "HoD"}, [0x3F800000] = {[0] = "WoL"},
	[0xBEAFFFDE] = {[0x3F70665E] = "FG LZ0"},
	[0x3F7FF4DC] = {[0xBC96E58A] = "MoA LZ0"},
	[0x3DC16378] = {[0xBF7EDB2F] = "WoLy"},
	[0x80000000] = {[0x3F800000] = "Bayou LZ0"},
	[0x3E1DC550] = {[0x3F7CF180] = "SoWaI LZ0"},
	[0x3F7FFB8B] = {[0xBC3EB5B3] = "MH LZ0"},
	[0x3EB77C03] = {[0xBF6EFF19] = "CoBD LZ0"},
	[0xBF7FF530] = {[0xBC94FF00] = "Canopy LZ0"}, [0x3F702F40] = {[0xBEB12BE5] = "Canopy LZ1"},
	[0xBF0F2746] = {[0xBF543BD6] = "WB LZ0"},
	[0xBF76B085] = {[0x3E88D36B] = "SoSaF LZ0"},
	[0xBEA05815] = {[0x3F731F47] = "EC LZ0"},
	[0x3F7F36AC] = {[0xBDA067CF] = "Press LZ0"},
	[0xBEAF1D3F] = {[0xBF708FB8] = "TotW LZ0"},
	[0xBF7DB1D9] = {[0x3E091CD2] = "WoP"},
	[0x3F314E09] = {[0xBF38A8C1] = "SoRaL LZ0"}
};



-- Main
memory.usememorydomain("RDRAM");
init()
addr = 0x1D0AA0;
if is_us then
	addr = addr + 0x100;
end
timer = 0;
while true do
	timer = timer - 1;
	if timer < 1 then
		hi = memory.read_u32_be(addr);
		lo = memory.read_u32_be(addr + 4);
		if lvd[hi] ~= nil and lvd[hi][lo] ~= nil then
			console.log(lvd[hi][lo]);
		else
			console.log("unknown: "..string.format("%016s", bizstring.hex(hi * 2^32 + lo)));
		end
		timer = delay;
	end
	emu.frameadvance();
end