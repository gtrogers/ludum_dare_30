
local Asteroid = Thing.new()

function Asteroid:init(x, y, r, s)
    self.x = x
    self.y = y
    self.rot = r
    self.speed = s
    self.color = {255, 125, 50}
    self.verts = {}

    local corners = math.random(5,16)
    local arc = 2*math.pi/corners
    for i=1, corners do
        local n = i*2
        local r = math.random(16,32)
        local theta = arc*i
        self.verts[n-1] = r*math.cos(theta)
        self.verts[n] = r*math.sin(theta)
    end
end

function Asteroid:draw(g)
    g.push()
    g.setColor(self.color)
    g.translate(self.x, self.y)
    g.setLineStyle('rough')
    g.polygon('line', self.verts)
    g.setColor(255, 255, 255)
    g.pop()
end

function Asteroid:update(dt)
    self.x = self.x + math.sin(self.rot) * self.speed
    self.y = self.y + math.cos(self.rot) * self.speed
end

return Asteroid

