local tbs = {}

function tbs.loadMem()
    local memMap = {
        xOver = 0x02030DAE,
        yOver = 0x02030DB6,
        xTown = 0x02030EC6,
        yTown = 0x02030ECE,
        xMapCursor = 0x02010006,
        yMapCursor = 0x0201000A,
        encounters = 0x02000478,
        moveTypeAddr = 0x02000432,
        mapAddr = 0x02000400,
        camAddr = 0x03002000,
        mapFlag = 0x02030CB6,
        zoomLock = 0x03001CF5,
        collision = {0x0800F3B0}
    }
    return memMap
end

return tbs
