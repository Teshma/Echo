require("src.Entities.Entity")

Enemy = Entity:inherit()


function Enemy.New(x, y, mass)
    local enemy = Enemy:new(
    {
        x = x,
        y = y,
        --image = love.graphics.newImage("assets/aseprite/test.png"),
        damage = 10,
        solid = true,
        priority = 1,
        mass = mass or 20,
    })

    enemy.health = enemy:AddComponent(Health(enemy, 100, 2))
    enemy.w = 32 -- enemy.image:getWidth()
    enemy.h = 32 -- enemy.image:getHeight()
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

function Enemy:__tostring()
    return "Enemy"
end