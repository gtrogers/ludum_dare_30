Asteroid = require('src.entities.asteroid')


local AsteroidSpawner = Thing.new()

function AsteroidSpawner:init(world)
    self.world = world
    self.asteroids = {}
end

function AsteroidSpawner:spawn()
    if #self.asteroids < 100 then
        self.asteroids[#self.asteroids+1] = Asteroid(400, 400, math.random()*math.pi*2, 0.5)
    end
end

function AsteroidSpawner:update(dt)
    for i, ast in ipairs(self.asteroids) do
        ast:update(dt)
    end
end

function AsteroidSpawner:draw(g)
    for i, ast in ipairs(self.asteroids) do
        ast:draw(g)
    end
end

return AsteroidSpawner

