Enemy = {}
Enemy.__index = function (table, key)
    return Enemy[key]
end
Enemies = {}

function Enemy.New(x, y, type)
    if type == "dummy" then
        local t = {}
        setmetatable(t, Enemy)
        t.x = x
        t.y = y
        t.w = 40
        t.h = 40

        table.insert(Enemies, t)
    end
end

function Enemy:Update(dt)

end

function Enemy:Draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(r, g, b, a)
end