require('src.loader') 

AsteroidSpawner = require('src.spawners.asteroid_spawner')

function love.load()
    love.physics.setMeter(1)
    world = love.physics.newWorld(0, 0, true)

    asteroid_spawner = AsteroidSpawner(world)

    layers = {
        {
            z=1, draw=function(g)
                asteroid_spawner:draw(g)
            end
        }
    }
end

function love.update(dt)
    asteroid_spawner:spawn()
    asteroid_spawner:update(dt)
end

function love.draw()
    for i, l in ipairs(layers) do
        love.graphics.push()
        l.draw(love.graphics)
        love.graphics.pop()
    end
end

