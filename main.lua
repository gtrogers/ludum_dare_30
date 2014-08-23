require('src.loader') 

AsteroidSpawner = require('src.spawners.asteroid_spawner')

function love.load()
    world = require('src.physics')
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
    world:update(dt)
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

