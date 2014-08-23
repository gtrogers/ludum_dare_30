require('src.loader') 

local AsteroidSpawner = require('src.spawners.asteroid_spawner')
local ColonyShip = require('src.entities.colony_ship')

local rot = 0
local ship_rot_speed = 0.05

function love.load()
    world = require('src.physics')
    asteroid_spawner = AsteroidSpawner(world)
    colony_ship = ColonyShip(world, love.window.getWidth()/2, love.window.getHeight()*0.6)

    layers = {
        {
            z=1, draw=function(g)
                asteroid_spawner:draw(g)
                colony_ship:draw(g)
            end
        }
    }
end

function love.update(dt)
    world:update(dt)
    asteroid_spawner:spawn()
    asteroid_spawner:update(dt)
    colony_ship:update(dt, rot)

    if love.keyboard.isDown("left") then rot = rot - ship_rot_speed*dt end
    if love.keyboard.isDown("right") then rot = rot + ship_rot_speed*dt end
end

function love.draw()
    for i, l in ipairs(layers) do
        love.graphics.push()
            local x, y = colony_ship:world_coords()
            local screen_x = x - love.window.getWidth()/2
            local screen_y = y - love.window.getHeight()*0.6
            love.graphics.translate(x, y)
            love.graphics.translate(-x-screen_x, -y - screen_y)
            l.draw(love.graphics)
        love.graphics.pop()
        
        love.graphics.push()
            love.graphics.print("Angle: " .. colony_ship:angle(), 8, 8)
            love.graphics.line(512,100, 512, 300)
        love.graphics.pop()
    end
end

