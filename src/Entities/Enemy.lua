require("src.Entities.Entity")

Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, Entity)

function Enemy.New(x, y)
    local enemy = Enemy:new(
    {
        x = x,
        y = y,
        image = love.graphics.newImage("assets/aseprite/test.png"),
        damage = 10,
        solid = true,
        priority = 1,
    })

    enemy.health = enemy:AddComponent(Health(enemy, 100, 2))
    enemy.attackable = Attackable(enemy)
    enemy.w = enemy.image:getWidth()
    enemy.h = enemy.image:getHeight()
    enemy.centre = {x = enemy.x + enemy.w/2, y = enemy.y + enemy.h/2}
end

-- ------------------------------------------------------------------------------

function Enemy:Update(dt)
    self.health:Update(dt)
end

-- ------------------------------------------------------------------------------

function Enemy:Draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 1)
    --love.graphics.draw(self.image, self.x, self.y)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.setColor(r, g, b, a)

    self.health:Draw(self.x, self.y - 20, self.w * 1.5, 10)
end

-- ------------------------------------------------------------------------------

function Enemy:CollisionResponse(other, dx, dy)
    self.Base.CollisionResponse(self, other, dx, dy)
end

-- ------------------------------------------------------------------------------

function Enemy:__tostring()
    return "Enemy"
end