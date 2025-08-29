local width, height = love.graphics.getWidth(), love.graphics.getHeight()

--build walls
walls = {}
walls.n = {}
walls.n.body = love.physics.newBody(world, 0, 0, "static")
walls.n.shape = love.physics.newEdgeShape(0, 0, width, 0)
walls.n.fixture = love.physics.newFixture(walls.n.body, walls.n.shape)
walls.e = {}
walls.e.body = love.physics.newBody(world, 0, 0, "static")
walls.e.shape = love.physics.newEdgeShape(width, 0, width, height)
walls.e.fixture = love.physics.newFixture(walls.e.body, walls.e.shape)
walls.s = {}
walls.s.body = love.physics.newBody(world, 0, 0, "static")
walls.s.shape = love.physics.newEdgeShape(width, height, 0, height)
walls.s.fixture = love.physics.newFixture(walls.s.body, walls.s.shape)
walls.w = {}
walls.w.body = love.physics.newBody(world, 0, 0, "static")
walls.w.shape = love.physics.newEdgeShape(0, height, 0, 0)
walls.w.fixture = love.physics.newFixture(walls.w.body, walls.w.shape)