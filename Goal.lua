Goal = {}
Goal.__index = Goal

function Goal:new(x, y, width, height)
    local goal = {
        x = x,
        y = y,
        width = width,
        height = height
    }

    setmetatable(goal, Goal)

    return goal
end

function Goal:draw()

    love.graphics.setColor(0, 1, 0)  --verde

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height
    )

    love.graphics.setColor(1, 1, 1)

end

return Goal