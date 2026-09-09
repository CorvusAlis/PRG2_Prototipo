-- importo las clases que necesita el programa para funcionar (como el include en c)

local Player = require("Player")
local Goal = require("Goal")
local checkAABB = require("Collision")

local player    --un objeto player
local goal


function love.load()
    player = Player:new(100, 100, 32, 32, 200)
    goal = Goal:new(500, 300, 32, 32)
end

function love.update(dt)
    player:update(dt)

    --checkeo la colision
    if checkAABB(player, goal) then
        player.colliding = true
    else
        player.colliding = false
    end

end

function love.draw()
    player:draw()
    goal:draw()
end