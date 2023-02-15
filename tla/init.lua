local tla = {}

function tla.loadMem()
    local memMap = {
        xOver = 0x020321C2,
        yOver = 0x020321CA,
        xBoat = 0x02032242,
        yBoat = 0x0203224A,
        xTown = 0x020322F6,
        yTown = 0x020322FE,
        xTownBoat = 0x02032376,
        yTownBoat = 0x0203237E,
        xMapCursor = 0x0202A006,
        yMapCursor = 0x0202A00A,
        encounters = 0x02000498,
        moveTypeAddr = 0x02000452,
        mapAddr = 0x02000420,
        camAddr = 0x03001300,
        mapFlag = 0x02030CA2,
        zoomLock = 0x03001169,
        collision = {0x08027A52, 0x0802860C, 0x08028B9A}
    }
    return memMap
end

return tla
