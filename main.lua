if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

require "src.Utils"
RequireScripts("src")
CENTER = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2};
love.window.setMode(1080, 720, {display = 2})

function love.load()


end

function love.update(dt)
    Player:Update(dt)
end

function love.draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
    Player:Draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end