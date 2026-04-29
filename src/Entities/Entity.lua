Entities = {}

Entity = {}
Entity.__index = Entity
Entity.indexes = 0

-- ------------------------------------------------------------------------------

function Entity:new(init)
    local e = init or {}
    setmetatable(e, self)
    e.Components = {}

    table.insert(Entities, e)
    return e
end

-- ------------------------------------------------------------------------------

function Entity:inherit(object)
    local obj = object or {}
    obj.__index = obj
    setmetatable(obj, self)
    return obj
end

-- ------------------------------------------------------------------------------

function Entity:AddComponent(comp)
    table.insert(self.Components, comp)
    Debug.Log(self:__tostring() .. " added " .. comp:__tostring() .. " component. [" .. #self.Components .. "]")
    return comp
end

-- ------------------------------------------------------------------------------

function Entity:CollisionResponse(other)
    for i = 1, #self.Components do
        if self.Components[i].OnCollision then self.Components[i]:OnCollision(other) end
    end
end