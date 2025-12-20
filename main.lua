if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

require "src.Utils"
RequireFolder("src")
CENTER = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2};

function love.load()
    love.window.setMode(1080, 720, {
        display = 2
    })

end

function love.update(dt)

end

function love.draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end