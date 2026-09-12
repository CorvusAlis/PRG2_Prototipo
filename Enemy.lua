Enemy = {}
Enemy.__index = Enemy

function Enemy:new(x, y, width, height, speed, pointA, pointB)

    local enemy = {
        x = x,
        y = y,
        width = width,
        height = height,
        speed = speed,

        --puntos de movimiento patrulla
        pointA = pointA,
        pointB = pointB,

        --hacia que punto se esta moviendo
        target = pointB
    }

    setmetatable(enemy, Enemy)

    return enemy
end

function Enemy:update(dt)

    local dx = self.target.x - self.x
    local dy = self.target.y - self.y

    --normalizacion de vector
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance < 2 then
        --cambios de direccion
        if self.target == self.pointA then
            self.target = self.pointB
        else
            self.target = self.pointA
        end

    else

        local directionX = dx / distance
        local directionY = dy / distance

        self.x = self.x + directionX * self.speed * dt
        self.y = self.y + directionY * self.speed * dt

    end

end

function Enemy:draw()

    love.graphics.setColor(1, 0, 0) --rojo

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height
    )

    love.graphics.setColor(1, 1, 1)

end

return Enemy