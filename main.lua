if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

require "src.Utils"
RequireScripts("src")
CENTER = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2};
love.window.setMode(1080, 720, {display = 2})

function love.load()
    Enemy.New(300, 300, "dummy")
end

function love.update(dt)
    Player:Update(dt)
    for _,enemy in ipairs(Enemies) do
        enemy:Update(dt)
    end


end

function love.draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    Player:Draw()
    for _,enemy in ipairs(Enemies) do
        enemy:Draw()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    Player:Keypressed(key)
end