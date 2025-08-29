function love.load()
    --settings
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, false)
    love.graphics.setDefaultFilter("nearest", "nearest")

    --background
    background = love.graphics.newImage("map/map.png")

    --modules
    require("source/walls")
    require("source/player")
    require("source/enemies")
    require("source/bullets")
end

objects = {}

function love.update(dt)
    world:update(dt)
    player:update(dt)
    enemies:update(dt)
end

function love.draw()
    --background
    love.graphics.draw(background)

    --draw
    player:draw()
    enemies:draw()
end