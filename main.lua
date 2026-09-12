--IMPORT DE CLASES
local Player = require("Player")
local Goal = require("Goal")
local Enemy = require("Enemy")

local checkAABB = require("Collision")

local player
local goal
local enemies = {}  --para crear varios enemigos

--ESTADOS DEL JUEGO
local GameState = {
    PLAYING = 1,
    DEFEAT = 2,
    VICTORY = 3
}

local gameState = GameState.PLAYING

--LOAD
function love.load()
    player = Player:new(100, 100, 32, 32, 200)
    goal = Goal:new(500, 300, 32, 32)

    -- ENEMIGO 1

    local pointA1 = { x = 300, y = 200 }
    local pointB1 = { x = 500, y = 200 }

    local enemy1 = Enemy:new(
        pointA1.x,
        pointA1.y,
        32, 32,
        100,
        pointA1,
        pointB1
    )

    -- ENEMIGO 2

    local pointA2 = { x = 200, y = 400 }
    local pointB2 = { x = 600, y = 400 }

    local enemy2 = Enemy:new(
        pointA2.x,
        pointA2.y,
        32, 32,
        150,
        pointA2,
        pointB2
    )

    --inserto enemigos
    table.insert(enemies, enemy1)
    table.insert(enemies, enemy2)

end

--UPDATE
function love.update(dt)
    
    --PLAYING
    if gameState == GameState.PLAYING then

        player:update(dt)

        if checkAABB(player, goal) then
            gameState = GameState.VICTORY   --cambio estado victoria
        
        else

            for _, enemy in ipairs(enemies) do  --checkeo colision con cualquer enemigo

                enemy:update(dt)

                if checkAABB(player, enemy) then
                    gameState = GameState.DEFEAT    --cambio estado derrota
                    break
                end

            end
        end
    end
end

--DRAW
function love.draw()

    if gameState == GameState.PLAYING then

        player:draw()
        goal:draw()

        for _, enemy in ipairs(enemies) do
            enemy:draw()
        end

    elseif gameState == GameState.DEFEAT then

        love.graphics.print("DERROTA", 300, 200)

    elseif gameState == GameState.VICTORY then

        love.graphics.print("VICTORIA", 300, 200)

    end

end