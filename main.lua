require('src.loader') 
ColonyShip = require('src.entities.colony_ship')
Asteroid = require('src.entities.asteroid')

local star_angle = 0

function love.load()
    star_field = {}

    asteroids = {
        Asteroid(200, 200, math.pi*2*math.random(), 0.1),
        Asteroid(300, 200, math.pi*2*math.random(), 0.2),
        Asteroid(400, 200, math.pi*2*math.random(), 0.1),
        Asteroid(500, 200, math.pi*2*math.random(), 0.3)
    }

    for i=0,500 do
        local x = math.random(-512, 1024+512)
        local y = math.random(-384, 768+384)
        star_field[i] = {x, y}
    end

    layers = {
        {
            z=1, draw=function(g)
                for i=1, #asteroids do
                    asteroids[i]:draw(g)
                end
            end
        },
        {
            z=0.8, draw=function(g)
                g.setPointStyle('rough')
                g.translate(512,384)
                g.rotate(star_angle)
                g.translate(-512,-384)
                for i=0, #star_field do
                    g.point(star_field[i][1], star_field[i][2])
                end
            end
        }
    }
end

function love.update(dt)
    star_angle = star_angle + 0.1*dt*math.pi/2
    star_angle = star_angle % (2*math.pi)
    for i=1, #asteroids do
        asteroids[i]:update(dt)
    end
end

function love.draw()
    for i, l in ipairs(layers) do
        love.graphics.push()
        l.draw(love.graphics)
        love.graphics.pop()
    end
end

