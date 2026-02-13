Player =
{
    x = 100,
    y = 100,
    velocity = {dx = 0, dy = 0},
    dir = {1, 0},
    lastDirX = 1,
    speed = 100,
    health = Health(100, 2),
    solid = true,
    image = love.graphics.newImage("assets/aseprite/test.png"),
}
Player.w = Player.image:getWidth()
Player.h = Player.image:getHeight()

Player.walkingSheet = love.graphics.newImage("assets/aseprite/walk.png")
local numAnims = Player.walkingSheet:getWidth() / 16 * 4
Player.walkIndex = 1
Player.walking =
{
    love.graphics.newQuad(0, 0, 16 * 4, 32 * 4, Player.walkingSheet),
    love.graphics.newQuad(16 * 4, 0, 16 * 4, 32 * 4, Player.walkingSheet),
    love.graphics.newQuad(16 * 8, 0, 16 * 4, 32 * 4, Player.walkingSheet)
}
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
        self.lastDirX = -1
    end
    if love.keyboard.isDown("d") then
        self.velocity.dx = self.speed
        self.dir[1] = 1
        self.dir[2] = 0
        self.lastDirX = 1
    end

    self.x = self.x + self.velocity.dx * dt
    self.y = self.y + self.velocity.dy * dt

    if (math.abs(self.velocity.dx) > 0 or math.abs(self.velocity.dy) > 0) then
        self.walkIndex = self.walkIndex + dt * 4

        if (math.modf(self.walkIndex) >= 4) then
            self.walkIndex = 2
        end
    else
        self.walkIndex = 1
    end

    self.health:Update(dt)
end

-- ------------------------------------------------------------------------------

function Player:Draw()
    --love.graphics.draw(self.image, self.x, self.y)
    local offset = 0
    if (self.lastDirX < 0 ) then
        offset = 16 * 4
    end
    love.graphics.draw(self.walkingSheet, self.walking[math.modf(self.walkIndex)], self.x, self.y, 0, self.lastDirX, 1, offset)

    self.health:Draw(self.x, self.y - 20, self.w * 1.5, 10)
end

-- ------------------------------------------------------------------------------

function Player:Keypressed(key)
    if (key == "space") then
        print("attack")
        table.insert(Entities, #Entities, Attack(self, (self.x + self.w/2 - 10) + self.lastDirX * 40, (self.y + self.h/2 - 10) + self.dir[2] * 40, 20, 20, 10))
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