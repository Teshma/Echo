require("src.Entities.Entity")

Attack = Entity:inherit({})
Attack.__index = Attack


function Attack.New(owner, x, y, w, h, damage)
    local attack = Attack:new(
    {
        owner = owner,
        x = x,
        y = y,
        w = w,
        h = h,
        damage = damage,
        solid = false,
    })

    attack.health = attack:AddComponent(Health(attack, 15, 1))
    attack.centre = {x = x + w/2, y = y + h/2}

    return attack
end

-- ------------------------------------------------------------------------------

function Attack:Update(dt)
    self.health.currentHealth = self.health.currentHealth - dt * 2
    self.health:Update(dt)
end

-- ------------------------------------------------------------------------------

function Attack:Draw()
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end

-- ------------------------------------------------------------------------------

function Attack:CollisionResponse(other, dx, dy)
    print ("Collided with " .. other:__tostring())

    if other and other == self.owner then
        return
    end

    if other.attackable then
        -- need to get x or y plane of attack wrt to other object, and then knockback in that plane.
        local direction =
        {
            self.centre.x - self.owner.centre.x,
            self.centre.y - self.owner.centre.y
        }
        local mag = math.sqrt(direction[1] * direction[1] + direction[2] * direction[2])
        direction[1] = direction[1]/mag
        direction[2] = direction[2]/mag
        other.attackable:OnAttacked(direction, self.damage)
    end

    self.health.alive = false
end

-- ------------------------------------------------------------------------------

function Attack:__tostring()
    return "Attack: " .. self.owner:__tostring()

end

-- ------------------------------------------------------------------------------