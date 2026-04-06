Health = function(owner, healthValue, invulTime)
    return
    {
        owner = owner,
        maxHealth = healthValue,
        currentHealth = healthValue,
        maxInvulTime = invulTime,
        currentInvulTime = 0,
        alive = true,

        -- ------------------------------------------------------------------------------

        Update = function (self, dt)
            if self.currentInvulTime > 0 then
                self.currentInvulTime = self.currentInvulTime - dt
            end

            if self.currentHealth <= 0 then
                self.alive = false
            end
        end,

        -- ------------------------------------------------------------------------------

        Draw = function (self, x, y, width, height)
            local r, g, b, a = love.graphics.getColor()
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle("fill", x, y, self.currentHealth * width / 100, height)
            love.graphics.setColor(r, g, b, a)
        end,

        -- ------------------------------------------------------------------------------
        OnCollision = function(self, other, dx, dy)
            if not other.damage or self.currentInvulTime > 0 then return end

            print (owner:__tostring() .. " took " .. other.damage .. " by " .. other:__tostring())
            self:TakeDamage(other.damage)
        end,

        -- ------------------------------------------------------------------------------

        TakeDamage = function (self, damage)
            self.currentHealth = self.currentHealth - damage
            self.currentInvulTime = self.maxInvulTime
            if self.currentHealth <= 0 then
                self.alive = false
            end
        end


        -- ------------------------------------------------------------------------------
    }
end