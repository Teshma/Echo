Health = function(healthValue, invulTime)
    return
    {
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
        ResolveCollision = function(self, entity, other)
            if other.damage and self.currentInvulTime <= 0 then

                print (entity:ToString() .. " took " .. other.damage .. " by " .. other:ToString())
                self.currentHealth = self.currentHealth - other.damage
                self.currentInvulTime = self.maxInvulTime

                if self.currentHealth <= 0 then
                    self.alive = false
                end
            end
        end,

        -- ------------------------------------------------------------------------------
    }
end