
local ColonyShip = Thing.new()

function ColonyShip:init()
    self.x = 0
    self.y = 0
end

function ColonyShip:draw(g)
    g.setLineWidth(1)
    g.setLineStyle('rough')
    g.translate(self.x, self.y)
    g.polygon('line', -16, 32, 16, 32, 0, 0)
end

return ColonyShip

