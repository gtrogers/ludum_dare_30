Asteroid = require('src.entities.asteroid')


local AsteroidSpawner = Thing.new()

function AsteroidSpawner:init(world)
    self.world = world
    self.asteroids = {}
end

function AsteroidSpawner:spawn()
    if #self.asteroids < 12 then
        local ast = Asteroid(
            self.world,
            100*#self.asteroids,
            5*#self.asteroids,
            love.math.random()*math.pi*2,
            10)
        self.asteroids[#self.asteroids+1] = ast
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

