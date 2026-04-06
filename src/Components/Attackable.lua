Attackable = function (owner)
    return
    {
        owner = owner,
        OnAttacked = function (self, direction, damage)
            --self.owner.x = self.owner.x + direction[1] * 50
            --self.owner.y = self.owner.y + direction[2] * 50

            self.owner.health:TakeDamage(damage)
        end
    }
end
