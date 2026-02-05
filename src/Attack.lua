Attack = function (owner, x, y, w, h, damage)
    return
    {
        owner = owner,
        x = x,
        y = y,
        w = w,
        h = h,
        damage = damage,
        health = Health(20, 1),
        solid = false,

        -- ------------------------------------------------------------------------------

        Update = function (self, dt)
            self.health.currentHealth = self.health.currentHealth - dt
            self.health:Update(dt)
        end,

        -- ------------------------------------------------------------------------------

        Draw = function ()
            love.graphics.rectangle("line", x, y, w, h)
        end,

        -- ------------------------------------------------------------------------------

        CollisionResponse = function(self, other)
            print ("Collided with " .. other:ToString())
            self.health:ResolveCollision(self, other)
        end,

        -- ------------------------------------------------------------------------------

        ToString = function (self)
            return "Attack: " .. self.owner:ToString()

        end

        -- ------------------------------------------------------------------------------
    }
end