
local Drone = Thing.new()

function Drone:init(world, x, y)
    self.p = {}
    self.p.body = love.physics.newBody(world, x, y, 'dynamic')
    self.p.shape = love.physics.newPolygonShape(-8,8, 8,8, 0,-8)
    self.p.fixture = love.physics.newFixture(self.p.body, self.p.shape, 2)
    self.p.fixture:setUserData(self)

    self.color = {200, 200, 0}
    self.speed = 10
end

function Drone:draw(g)
    g.setLineWidth(1)
    g.setLineStyle('rough')
    g.setColor(self.color)
    g.polygon('line', self.p.body:getWorldPoints(self.p.shape:getPoints()))
    g.setColor(255,255,255)
end

function Drone:inherit_velocity(x, y, r)
    self.p.body:setAngle(r)
    self.p.body:setLinearVelocity(x, y)
end

function Drone:update(dt)
    local vx, vy = self.p.body:getLinearVelocity()
    local vChange = self.speed*self.speed - (vx*vx + vy*vy)
    local angle = self.p.body:getAngle()
    self.p.body:applyLinearImpulse(math.cos(angle - math.pi/2)*vChange, math.sin(angle - math.pi/2)*vChange)
end

function Drone:collision()
end

function Drone:onclick()
    self.color = {255,255,0}
end

return Drone

