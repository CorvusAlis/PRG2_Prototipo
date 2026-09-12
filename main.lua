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
    MENU = 1,
    PLAYING = 2,
    DEFEAT = 3,
    VICTORY = 4
}

local gameState = GameState.MENU

--LOAD
function love.load()

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

    --DIBUJO PANTALLA DE MENU
    if gameState == GameState.MENU then

        love.graphics.print("PROTOTIPO - FASE 1", 300, 100)
        love.graphics.print("Presiona ENTER para comenzar", 250, 200)

        love.graphics.print("CONTROLES", 300, 280)
        love.graphics.print("WASD - Moverse", 300, 320)
        love.graphics.print("R - Reiniciar", 300, 350)

    --DIBUJO PANTALLA DE JUEGO
    elseif gameState == GameState.PLAYING then

        player:draw()
        goal:draw()

        for _, enemy in ipairs(enemies) do
            enemy:draw()
        end

     --DIBUJO PANTALLA DE DERROTA
    elseif gameState == GameState.DEFEAT then

        love.graphics.print("DERROTA", 300, 200)
        love.graphics.print("Presiona R para reiniciar", 250, 250)

    -- DIBUJO PANTALLA DE VICTORIA
    elseif gameState == GameState.VICTORY then

        love.graphics.print("VICTORIA", 300, 200)
        love.graphics.print("Presiona R para jugar nuevamente", 220, 250)

    end

end

function startGame()    --para poder reiniciar el nivel desde load

    gameState = GameState.PLAYING

    player = Player:new(100, 100, 32, 32, 200)
    goal = Goal:new(500, 300, 32, 32)

    enemies = {}

    --ENEMIGO 1

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

    --ENEMIGO 2

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

    table.insert(enemies, enemy1)
    table.insert(enemies, enemy2)

end

function love.keypressed(key)

    --MENU A JUEGO
    if gameState == GameState.MENU then

        if key == "return" then --al apretar enter
            startGame()
        end

    -- VICTORY / DEFEAT AL JUEGO
    elseif gameState == GameState.VICTORY
        or gameState == GameState.DEFEAT then

        if key == "r" then
            startGame()
        end

    end

end