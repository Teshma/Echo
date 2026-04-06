if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- ------------------------------------------------------------------------------
function love.load()
    require "src.Utils"
    RequireScripts("src")

    CENTER = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2};
    UP_VECTOR = {0, -1}
    DOWN_VECTOR = {0, 1}
    LEFT_VECTOR = {-1, 0}
    RIGHT_VECTOR = {1, 0}

    love.window.setMode(1080, 720, {display = 1})
    Enemy.New(300, 200)
end

-- ------------------------------------------------------------------------------

function love.update(dt)
    for i,entity in ipairs(Entities) do

        if not entity.health or entity.health.alive then
            if entity.Update then entity:Update(dt) end

            for j = i + 1, #Entities do
                local other = Entities[j]

                if not other.health or other.health.alive then
                    -- broad phase
                    if AABB(entity, other) then
                        print("aabb " .. entity:__tostring() .. " - " .. other:__tostring())
                        -- resolution
                        local dx, dy = 0, 0
                        if other.solid then
                            -- <0 = moving down = hit the top of the other entity
                            local dot_product_up = DotProduct(other.centre.x - entity.centre.x, other.centre.y - entity.centre.y, UP_VECTOR[1], UP_VECTOR[2])
                            local dot_product_left = DotProduct(other.centre.x - entity.centre.x, other.centre.y - entity.centre.y, LEFT_VECTOR[1], LEFT_VECTOR[2])
                            if math.abs(dot_product_up) > math.abs(dot_product_left) then
                                if dot_product_up < 0 then
                                    dy = -1 * (entity.y + entity.h - other.y)
                                elseif dot_product_up > 0 then
                                    dy = other.y + other.h - entity.y
                                end
                            else
                                -- <0 = moving right = hit the left of the other entity
                                if dot_product_left < 0 then
                                    dx = -1 * (entity.x + entity.w - other.x)
                                elseif dot_product_left > 0 then
                                    dx = other.x + other.w - entity.x
                                end
                            end
                        end

                        if entity.CollisionResponse then entity:CollisionResponse(other, dx, dy) end
                        if other.CollisionResponse then other:CollisionResponse(entity, -dx, -dy) end
                    end
                end
            end
        end
    end
end

-- ------------------------------------------------------------------------------

function love.draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    for i = #Entities, 1, -1 do
        local entity = Entities[i]
        if not entity.health or entity.health.alive then
            if entity.Draw then entity:Draw() end
        end
    end

end

-- ------------------------------------------------------------------------------

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    Player:Keypressed(key)
end

-- ------------------------------------------------------------------------------

function AABB(this, other)
    return  (this.x < other.x + other.w and this.x + this.w > other.x) and
        (this.y < other.y + other.h and this.y + this.h > other.y)
end

-- ------------------------------------------------------------------------------

function DotProduct(x, y, x2, y2)
    local magnitude1 = math.sqrt((x*x) + (y*y))
    local magnitude2 = math.sqrt((x2*x2) + (y2*y2))
    local normX1 = x/magnitude1
    local normY1 = y/magnitude1
    local normX2 = x2/magnitude2
    local normY2 = y2/magnitude2

    return normX1*normX2 + normY1*normY2
end

-- ------------------------------------------------------------------------------