Player = Entity:new({
    x = 100,
    y = 100,
    velocity = {dx = 0, dy = 0},
    dir = {1, 0},
    lastDirX = 1,
    speed = 100,
    solid = true,
    image = love.graphics.newImage("assets/aseprite/test.png"),
    priority = 1,
})

Player.health = Player:AddComponent(Health(Player, 100, 2))
Player.w = Player.image:getWidth()
Player.h = Player.image:getHeight()
Player.centre = {x = Player.x + Player.w/2, y = Player.y + Player.h/2}

Player.walkingSheet = love.graphics.newImage("assets/aseprite/walk.png")
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
    self.centre.x = self.x + self.w/2
    self.centre.y = self.y + self.h/2

    if (math.abs(self.velocity.dx) > 0 or math.abs(self.velocity.dy) > 0) then
        self.walkIndex = self.walkIndex + dt * 3

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
    --love.graphics.draw(self.walkingSheet, self.walking[math.modf(self.walkIndex)], self.x, self.y, 0, self.lastDirX, 1, offset)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    self.health:Draw(self.x, self.y - 20, self.w * 1.5, 10)
end

-- ------------------------------------------------------------------------------

function Player:Keypressed(key)
    if (key == "space") then
        print("attack")
        local offsetToPlayer = 10
        local attackW = 40
        local attackH = 40
        local attackX = (self.centre.x - attackW/2) + self.dir[1] * (self.w/2 + attackW/2 + offsetToPlayer)
        local attackY = (self.centre.y - attackH/2) + self.dir[2] * (self.h/2 + attackH/2 + offsetToPlayer)
        table.insert(Entities, #Entities, Attack.New(self, attackX, attackY, attackW, attackH, 10))
    end

end

-- ------------------------------------------------------------------------------

function Player:CollisionResponse(other, dx, dy)
    self.Base.CollisionResponse(self, other, dx, dy)
end

-- ------------------------------------------------------------------------------

function Player:__tostring()
    return "Player"
end

-- ------------------------------------------------------------------------------