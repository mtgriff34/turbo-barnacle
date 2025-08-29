--initialise player
player = {}

--add base sprite
player.base = {}
player.base.sprite = love.graphics.newImage("sprites/player_base.png")
player.base.width = player.base.sprite:getWidth()
player.base.height = player.base.sprite:getHeight()
player.base.orientation = 0

--add gun sprite
player.gun = {}
player.gun.sprite = love.graphics.newImage("sprites/player_gun.png")
player.gun.width = player.gun.sprite:getWidth()
player.gun.height = player.gun.sprite:getHeight()
player.gun.orientation = 0

--create body
player.body = love.physics.newBody(world, 512, 256, "dynamic")
player.body:setLinearDamping(5)
player.shape = love.physics.newRectangleShape(player.base.width, player.base.height)
player.fixture = love.physics.newFixture(player.body, player.shape)

--speed
player.acceleration = 250

function player:move()
    --get input
    local fX, fY = 0, 0 
    if love.keyboard.isDown("d") then
        fX = 1
    end
    if love.keyboard.isDown("a") then
        fX = - 1
    end
    if love.keyboard.isDown("w") then
        fY = - 1
    end
    if love.keyboard.isDown("s") then
        fY = 1
    end

    --normalise
    local length = math.sqrt(fX * fX + fY * fY)
    if length > 0 then
        fX = fX / length
        fY = fY / length
    end

    --apply normalise force with acceleration
    player.body:applyForce(player.acceleration * fX, player.acceleration * fY)

    --apply velocity
    local vX, vY = player.body:getLinearVelocity()

    --get angle of movement
    local angle = math.atan2(vX, - vY)
    player.body:setAngle(angle)
    --direction of base
    player.base.orientation = angle
    --direction of gun
    player.gun.orientation = math.atan2((love.mouse.getX() - player.body:getX()), - (love.mouse.getY() - player.body:getY()))
end



function player:update(dt)
    player:move(dt)
end

function player:draw()
    --base
    love.graphics.draw(
        player.base.sprite,
        player.body:getX(), player.body:getY(),
        player.base.orientation,
        nil, nil,
        player.base.width / 2, player.base.height / 2
    )
    --gun
    love.graphics.draw(
        player.gun.sprite,
        player.body:getX(), player.body:getY(),
        player.gun.orientation,
        nil, nil,
        player.gun.width / 2, player.gun.height / 2
    )

    love.graphics.polygon("line", player.body:getWorldPoints(player.shape:getPoints()))
end