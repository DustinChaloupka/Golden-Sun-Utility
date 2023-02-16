local bizhawk = {}

function bizhawk.memory()
    memory.readword = memory.read_u16_le
    memory.readdword = memory.read_u32_le
    memory.writeword = memory.write_s16_le
    return memory
end

function bizhawk.frameadvance() emu.frameadvance() end

return bizhawk
