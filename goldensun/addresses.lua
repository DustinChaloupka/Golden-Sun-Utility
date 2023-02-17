local addresses = {rom = 0x080000A0}

function addresses.is_battle()
    return bit.band(bit.rshift(memory.readbyte(0x02000060), 3), 1) == 1
end

return addresses
