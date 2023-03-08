local movetype = {}

local Chunk = require("goldensun.memory.chunk")
local MoveType = Chunk.new()

function MoveType:is_normal() return self:read() == self.normal end
function MoveType:is_overworld() return self:read() == self.overworld end
function MoveType:is_climbing_wall() return self:read() == self.climbing_wall end
function MoveType:is_climbing_rope() return self:read() == self.climbing_rope end
function MoveType:is_walking_rope() return self:read() == self.walking_rope end
function MoveType:is_overworld_sand() return self:read() == self.overworld_sand end
function MoveType:is_slippery_ground() return
    self:read() == self.slippery_ground end

function MoveType:get_speed(speed)
    local s = {x = 0, y = 0, z = 0}
    if emulator:button_pressed("down") then s.y = s.y + speed end
    if emulator:button_pressed("up") then s.y = s.y - speed end
    if emulator:button_pressed("left") then s.x = s.x - speed end
    if emulator:button_pressed("right") then s.x = s.x + speed end
    return s
end

local settings = require("config.settings")
function MoveType:speed_up()
    local speed
    local location
    if self:is_overworld() and emulator:button_pressed("B") then
        speed = self:get_speed(settings.overworld_run_speed)
        location = game.field_player.overworld_location
    elseif self:is_overworld() then
        speed = self:get_speed(settings.overworld_speed)
        location = game.field_player.overworld_location
    elseif self:is_normal() then
        speed = self:get_speed(settings.town_speed)
        location = game.field_player.normal_location
    end

    if location then location:add_speed(speed) end
    return speed
end

function movetype.new(o)
    local self = o or {}
    setmetatable(self, {__index = MoveType})
    self.__index = self
    return self
end

return movetype
