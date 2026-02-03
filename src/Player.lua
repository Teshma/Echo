Player =
{
    x = 100,
    y = 100,
    w = 40,
    h = 40,
    velocity = {dx = 0, dy = 0},
    speed = 100,
}
-- ------------------------------------------------------------------------------

function Player:Update(dt)
    self.velocity.dx, self.velocity.dy = 0, 0

    if love.keyboard.isDown("w") then
        self.velocity.dy = -self.speed
    end
    if love.keyboard.isDown("s") then
        self.velocity.dy = self.speed
    end
    if love.keyboard.isDown("a") then
        self.velocity.dx = -self.speed
    end
    if love.keyboard.isDown("d") then
        self.velocity.dx = self.speed
    end

    self.x = self.x + self.velocity.dx * dt
    self.y = self.y + self.velocity.dy * dt
end

-- ------------------------------------------------------------------------------

function Player:Draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

-- ------------------------------------------------------------------------------

function Player:Keypressed(key)
    if (key == "space") then

    end

end

-- ------------------------------------------------------------------------------