Player = {} --declaro la clase player
Player.__index = Player --index para poder acceder a los valores de player

--variables para player, posicion inicial y velocidad para moverlo despues
function Player:new(x, y, width, height, speed)
    local player = {
        x = x,
        y = y,
        width = width,
        height = height,
        speed = speed
    }

    setmetatable(player, Player)    --indica la metatabla del player )el objeto) es Player (la clase)

    return player
end

--movimiento con el teclado, el update similar a lo que usaba en raylib con deltatime
function Player:update(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end

    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end

    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end

    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    end
end

--render del player
function Player:draw()

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height
    )

end

return Player