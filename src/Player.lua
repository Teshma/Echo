Player =
{
    x = 100,
    y = 100,
    w = 40,
    h = 40,
    velocity = {dx = 0, dy = 0},
    dir = {1, 0},
    speed = 100,
    health = Health(100, 2),
    solid = true,
    image = love.graphics.newImage("assets/aseprite/test.png")
}
Player.w = Player.image:getWidth()
Player.h = Player.image:getHeight()
-- ------------------------------------------------------------------------------

function Player:Update(dt)
    self.velocity.dx, self.velocity.dy = 0, 0

    if love.keyboard.isDown("w") then
        self.velocity.dy = -self.speed
        self.dir[1] = 0
        self.dir[2] = -1
    end
    if love.keyboard.isDown("s") then
        self.velocity.dy = self.speed
        self.dir[1] = 0
        self.dir[2] = 1
    end
    if love.keyboard.isDown("a") then
        self.velocity.dx = -self.speed
        self.dir[1] = -1
        self.dir[2] = 0
    end
    if love.keyboard.isDown("d") then
        self.velocity.dx = self.speed
        self.dir[1] = 1
        self.dir[2] = 0
    end

    self.x = self.x + self.velocity.dx * dt
    self.y = self.y + self.velocity.dy * dt

    self.health:Update(dt)
end

-- ------------------------------------------------------------------------------

function Player:Draw()
    love.graphics.draw(self.image, self.x, self.y)

    self.health:Draw(self.x, self.y - 20, self.w * 1.5, 10)
end

-- ------------------------------------------------------------------------------

function Player:Keypressed(key)
    if (key == "space") then
        print("attack")
        local mag = math.sqrt((self.velocity.dx * self.velocity.dx) + (self.velocity.dy) * (self.velocity.dy))
        local normDirX = self.velocity.dx / mag
        local normDirY = self.velocity.dy / mag

        table.insert(Entities, #Entities, Attack(self, (self.x + self.w/2 - 10) + self.dir[1] * 40, (self.y + self.h/2 - 10) + self.dir[2] * 40, 20, 20, 10))
    end

end

-- ------------------------------------------------------------------------------

function Player:CollisionResponse(other)
    self.health:ResolveCollision(self, other)
end

-- ------------------------------------------------------------------------------

function Player:ToString()
    return "Player"
end

-- ------------------------------------------------------------------------------