local Player = require("Player")
local Goal = require("Goal")

local player    --un objeto player
local goal


function love.load()
    player = Player:new(100, 100, 32, 32, 200)
    goal = Goal:new(500, 300, 32, 32)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
    goal:draw()
end