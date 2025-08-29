enemies = {}

--initialise enemy
function spawnEnemy(x, y)
    local enemy = {}

    --add base sprite
    enemy.base = {}
    enemy.base.sprite = love.graphics.newImage("sprites/enemy_base.png")
    enemy.base.width = enemy.base.sprite:getWidth()
    enemy.base.height = enemy.base.sprite:getHeight()
    enemy.base.orientation = 0

    --add gun sprite
    enemy.gun = {}
    enemy.gun.sprite = love.graphics.newImage("sprites/enemy_gun.png")
    enemy.gun.width = enemy.gun.sprite:getWidth()
    enemy.gun.height = enemy.gun.sprite:getHeight()
    enemy.gun.orientation = 0

    --create body
    enemy.body = love.physics.newBody(world, x, y, "dynamic")
    enemy.body:setLinearDamping(5)
    enemy.shape = love.physics.newRectangleShape(enemy.base.width, enemy.base.height)
    enemy.fixture = love.physics.newFixture(enemy.body, enemy.shape)

    --force
    enemy.force = 125

    function enemy:update()
        --distance from players
        local dX, dY = player.body:getX() - enemy.body:getX(), player.body:getY() - enemy.body:getY()

        local aimAngle = math.atan2(dX, - dY)

        --normalise
        local length = math.sqrt(dX * dX + dY * dY)
        if length > 0 then
            dX = dX / length
            dY = dY / length
        end

        --apply normalise force with force
        enemy.body:applyForce(enemy.force * dX, enemy.force * dY)

        --apply velocity
        local vX, vY = enemy.body:getLinearVelocity()

        --get angle of movement
        local moveAngle = math.atan2(vX, - vY)
        enemy.body:setAngle(moveAngle)
        --direction of base
        enemy.base.orientation = moveAngle

        --direction of gun
        enemy.gun.orientation = aimAngle
    end

    function enemy:draw()
        --base
        love.graphics.draw(
            enemy.base.sprite,
            enemy.body:getX(), enemy.body:getY(),
            enemy.base.orientation,
            nil, nil,
            enemy.base.width / 2, enemy.base.height / 2
        )
        --gun
        love.graphics.draw(
            enemy.gun.sprite,
            enemy.body:getX(), enemy.body:getY(),
            enemy.gun.orientation,
            nil, nil,
            enemy.gun.width / 2, enemy.gun.height / 2
        )

        love.graphics.polygon("line", enemy.body:getWorldPoints(enemy.shape:getPoints()))
    end

    table.insert(enemies, enemy)
end

function enemies:update(dt)
    --spawn enemy

    --update all spawned enemies
    for _, e in ipairs(self) do
        e:update(dt)
    end
end

function enemies:draw()
    --draw all spawned enemies
    for _, e in ipairs(self) do
        e:draw(dt)
    end
end