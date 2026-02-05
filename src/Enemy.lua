Enemy = {}
Enemy.__index = function (table, key)
    return Enemy[key]
end


function Enemy.New(x, y, type)
    if type == "dummy" then
        local t = {}
        setmetatable(t, Enemy)
        t.x = x
        t.y = y
        t.w = 40
        t.h = 40
        t.health = Health(100, 2)
        t.damage = 10
        t.solid = true

        table.insert(Entities, t)
    end
end

-- ------------------------------------------------------------------------------

function Enemy:Update(dt)
    self.health:Update(dt)
end

-- ------------------------------------------------------------------------------

function Enemy:Draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(r, g, b, a)

    self.health:Draw(self.x, self.y - 20, self.w * 1.5, 10)
end

-- ------------------------------------------------------------------------------

function Enemy:CollisionResponse(other)
    self.health:ResolveCollision(self, other)
end

-- ------------------------------------------------------------------------------

function Enemy:ToString()
    return "Enemy"
end