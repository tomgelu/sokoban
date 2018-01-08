sW, sH = love.graphics.getDimensions()

require("utils")
mapManager = require("map")
player = require("player")
boxes = require("boxes")

function love.load(args)
  boxes:new(2,2,2)
  boxes:new(2,2)
end

function love.update(dt)
  player:update(dt)
  boxes:update(dt)
end

function love.keypressed(key, scancode)
  player:keypressed(key, scancode)
end

function love.keyreleased(key, scancode)
  
end

function love.draw()
  mapManager:push()
  mapManager:draw()
  mapManager:pop()
end