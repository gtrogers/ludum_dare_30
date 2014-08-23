local world

love.physics.setMeter(1)
world = love.physics.newWorld(0, 0, true)

function begin_collision(a, b, coll)
    a:getUserData():collision()
end

function end_collision(a, b, coll)
end

function pre_collision(a, b, coll)
end

function post_collision(a, b, coll)
end

world:setCallbacks(begin_collision, end_collision, pre_collision, post_collision)

return world

