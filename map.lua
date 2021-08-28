local mapManager = {}

mapManager.tW, mapManager.tH = 128, 64

mapManager.mapList = {
  {
    { 1,1,1,1,1,1,1,1 },
    { 1,1,1,1,1,1,1,1 },
    { 1,1,1,1,1,1,1,1 },
    { 1,1,1,1,1,1,1,1 },
    { 1,1,1,1,1,1,1,1 },
    { 1,1,1,1,1,1,1,1 },
    { 1,1,1,1,1,1,1,1 },
    { 1,1,1,1,1,1,1,1 }
  }  
}

mapManager.currentMap = 1

function mapManager.loadTiles(self)
  self.tiles = {}
  self.tilesn = {}
  self.tiles[1] = love.graphics.newImage("tile.png")
end

mapManager:loadTiles()

function mapManager.draw(self)
  love.graphics.setColor(255,255,255)
  -- draw the floor
  for x = 1, #self.mapList[self.currentMap] do
    for y = 1, #self.mapList[self.currentMap][1] do
      tile = self.mapList[self.currentMap][x][y]
      if tile == 1 then
        love.graphics.setColor(255,255,255)
      elseif tile == 2 then
        love.graphics.setColor(0,255,255)
      end
      drawIso(self.tiles[1], x, y)
    end
  end
  
  local depthSortingList = {}
  for i = 1, #boxes.list do
    table.insert(depthSortingList, boxes.list[i])
  end
  table.insert(depthSortingList, player)
  
  table.sort(depthSortingList, function(a,b)
    return a.tx <= b.tx + 0.99 and a.ty <= b.ty + 0.99 and a.tz <= b.tz + 0.99
  end)
  
  for i = 1, #depthSortingList do
    if depthSortingList[i].type == "player" then
      love.graphics.setColor(255,0,0)
    else
      love.graphics.setColor(255,255,255)
    end
    drawIso(mapManager.tiles[1], depthSortingList[i].tx, depthSortingList[i].ty, depthSortingList[i].tz)
  end
  
end

function mapManager.push(self)
  love.graphics.push()
  love.graphics.scale(0.5)
  love.graphics.translate((#self.mapList[self.currentMap] * self.tW)*0.33, 0)
end

function mapManager.pop(self)
  love.graphics.pop()
end

return mapManager