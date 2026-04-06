Entities = {}

Entity = {}
Entity.__index = Entity

-- ------------------------------------------------------------------------------

function Entity:new(init)
    local e = init or {}
    setmetatable(e, self)
    e.Base = Entity
    e.Components = {}

    table.insert(Entities, e)
    return e
end

-- ------------------------------------------------------------------------------

function Entity:AddComponent(comp)
    table.insert(self.Components, comp)
    print(tostring(self) .. " " .. #self.Components)
    return comp
end

-- ------------------------------------------------------------------------------

function Entity:CollisionResponse(other, dx, dy)
    for i = 1, #self.Components do
        if self.Components[i].OnCollision then self.Components[i]:OnCollision(other, dx, dy) end
    end
end