
local Asteroid = Thing.new()

function Asteroid:init(world, x, y, r, s)

    self.rot = r
    self.speed = s
    self.color = {255, 125, 50}
    self.verts = {}
    self.p = {}

    local corners = love.math.random(5,7)
    local arc = 2*math.pi/corners
    for i=1, corners do
        local n = i*2
        local r = love.math.random(24,32)
        local theta = arc*i
        self.verts[n-1] = r*math.cos(theta)
        self.verts[n] = r*math.sin(theta)
    end

    self.p.body = love.physics.newBody(world, x, y, 'dynamic')
    self.p.shape = love.physics.newPolygonShape(unpack(self.verts))
    self.p.fixture = love.physics.newFixture(self.p.body, self.p.shape, 100)
    self.p.fixture:setUserData(self)
end

function Asteroid:draw(g)
    g.push()
    g.setColor(self.color)
    g.setLineStyle('rough')
    g.polygon('line', self.p.body:getWorldPoints(self.p.shape:getPoints()))
    g.setColor(255, 255, 255)
    g.pop()
end

function Asteroid:update(dt)
    local vx, vy = self.p.body:getLinearVelocity()
    local vChange = self.speed*self.speed - (vx*vx + vy*vy)
    self.p.body:applyLinearImpulse(math.sin(self.rot)*vChange, math.cos(self.rot)*vChange)
end

function Asteroid:collision()
    self.color = {200, 255, 50}
end

return Asteroid

