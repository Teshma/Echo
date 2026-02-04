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

    love.window.setMode(1080, 720, {display = 2})

    Entities = {}
    table.insert(Entities, Player)
    Enemy.New(300, 200, "dummy")
end

-- ------------------------------------------------------------------------------

function love.update(dt)
    for i,entity in ipairs(Entities) do

        if not entity.health or entity.health.alive then
            entity:Update(dt)
        end

        for j = i + 1, #Entities do
            local other = Entities[j]
            -- broad phase
            if AABB(entity, other) then

                -- resolution
                if entity.CollisionResponse then entity:CollisionResponse(other) end
                if other.CollisionResponse then other:CollisionResponse(entity) end

                if entity.velocity then
                    -- <0 = moving down = hit the top of the other entity
                    local dot_product_up = DotProduct(other.x - entity.x, other.y - entity.y, UP_VECTOR[1], UP_VECTOR[2])
                    local dot_product_left = DotProduct(other.x - entity.x, other.y - entity.y, LEFT_VECTOR[1], LEFT_VECTOR[2])
                    if math.abs(dot_product_up) > math.abs(dot_product_left) then
                        if dot_product_up < 0 then
                            local dy = entity.y + entity.h - other.y
                            entity.y = entity.y - dy
                        elseif dot_product_up > 0 then
                            local dy = other.y + other.h - entity.y
                            entity.y = entity.y + dy
                        end
                    else
                        -- <0 = moving right = hit the left of the other entity
                        if dot_product_left < 0 then
                            local dx = entity.x + entity.w - other.x
                            entity.x = entity.x - dx
                        elseif dot_product_left > 0 then
                            local dx = other.x + other.w - entity.x
                            entity.x = entity.x + dx
                        end
                    end
                end
            end
        end
    end
end

-- ------------------------------------------------------------------------------

function love.draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    for _,entity in ipairs(Entities) do

        if not entity.health or entity.health.alive then
            entity:Draw()
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
    if  (this.x < other.x + other.w and this.x + this.w > other.x) and
        (this.y < other.y + other.h and this.y + this.h > other.y) then
        return true
    end
    return false
end

function DotProduct(x, y, x2, y2)
    local magnitude1 = math.sqrt((x*x) + (y*y))
    local magnitude2 = math.sqrt((x2*x2) + (y2*y2))
    local normX1 = x/magnitude1
    local normY1 = y/magnitude1
    local normX2 = x2/magnitude2
    local normY2 = y2/magnitude2

    return normX1*normX2 + normY1*normY2
end