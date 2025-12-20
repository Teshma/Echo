-- ------------------------------------------------------------------------------

function RequireFolder(folderPath)
    local children = love.filesystem.getDirectoryItems(folderPath)
    print(folderPath)
    while #children > 0 do
        local toAppend = {}
        local toRemove = {}
        for i = 1, #children do
            local filePath = folderPath.."/"..children[i]
            local info = love.filesystem.getInfo(filePath)
            if info ~= nil then
                if info.type == "directory" then
                    toAppend = love.filesystem.getDirectoryItems(filePath)
                elseif info.type == "file" then
                    local requirePath = filePath:gsub("/", "."):gsub(".lua", "")
                    _G[children[i]] = require(requirePath)
                    print("requiring " .. requirePath)
                end
            end
            table.insert(toRemove, i)
        end

        for i = 1, #toRemove do
            table.remove(children, toRemove[i])
        end

        table.append(children, toAppend)
    end
end

-- ------------------------------------------------------------------------------

function table.append(table1, table2)
    if #table2 <= 0 then return end

    for i=1, #table2 do
        table.insert(table1, table2[i])
    end
end