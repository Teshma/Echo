if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

function love.load()

end

function love.update(dt)

end

function love.draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
end