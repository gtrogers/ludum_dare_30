
local ColonyShip = Thing.new()

function ColonyShip:init(world, x, y)
    self.p = {}
    self.p.body = love.physics.newBody(world, x, y, 'dynamic')
    self.p.shape = love.physics.newPolygonShape(-32,32, 32,32, 0, -32)
    self.p.fixture = love.physics.newFixture(self.p.body, self.p.shape, 20)
    self.p.fixture:setUserData(self)

    self.color = {255, 255, 255}
end

function ColonyShip:draw(g)
    g.setLineWidth(1)
    g.setLineStyle('rough')
    g.setColor(self.color)
    g.polygon('line', self.p.body:getWorldPoints(self.p.shape:getPoints()))
    g.setColor(255,255,255)
end

function ColonyShip:update(dt, rot)
    self.p.body:setAngle(rot)
    self.p.body:setLinearVelocity(math.cos(rot - math.pi/2)*5, math.sin(rot - math.pi/2)*5)
end

function ColonyShip:world_coords()
    return self.p.body:getWorldCenter()
end

function ColonyShip:velocity()
    return self.p.body:getLinearVelocity()
end

function ColonyShip:angle()
    return self.p.body:getAngle()
end

function ColonyShip:collision()
    self.color = {200, 0, 0}
end

return ColonyShip

