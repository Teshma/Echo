Component = {}
Component.__index = Component

function Component:new(t)
    local c = t or {}
    setmetatable(c, Component)
    c.__index = Component
    return c
end