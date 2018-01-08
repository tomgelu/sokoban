local player = {}

player.tx = 3
player.ty = 3
player.tz = 1
player.type = "player"
player.destX = 3
player.destY = 3
player.isToDest = function(self)
  if math.abs(self.destX - self.tx) + math.abs(self.destY - self.ty) < 0.05 then
    player.tx = player.destX
    player.ty = player.destY
    return true
  end
end

function player.update(self, dt)
  if not self:isToDest() then
    self.tx = self.tx + 4*math.sign(self.destX - self.tx) * dt
    self.ty = self.ty + 4*math.sign(self.destY - self.ty) * dt
  end
end

function player.keypressed(self, key, scancode)
  if self:isToDest() then
    if key == "z" then
      self.destY = self.ty - 1
    elseif key == "s" then
      self.destY = self.ty + 1
    elseif key == "q" then
      self.destX = self.tx - 1
    elseif key == "d" then
      self.destX = self.tx + 1
    end
    -- player out of the map
    if self.destX < 1 or self.destX > #mapManager.mapList[mapManager.currentMap] or self.destY < 1 or self.destY > #mapManager.mapList[mapManager.currentMap][1] then
      self.destX = self.tx
      self.destY = self.ty
    end
    
    for i = 1, #boxes.list do
      local box = boxes.list[i]
      if box.tx == self.destX and box.ty == self.destY and box.tz == player.tz then
        box.destX = box.destX + math.sign(self.destX - self.tx)
        box.destY = box.destY + math.sign(self.destY - self.ty)
        
        -- cube out of the map
        if box.destX < 1 or box.destX > #mapManager.mapList[mapManager.currentMap] or box.destY < 1 or box.destY > #mapManager.mapList[mapManager.currentMap][1] then
          self.destX = self.tx
          self.destY = self.ty
          box.destX = box.tx
          box.destY = box.ty
        end
        
        -- reset destinations if you're trying to push a box to another box
        for j = 1, #boxes.list do
          if i ~= j and box.destX == boxes.list[j].tx and box.destY == boxes.list[j].ty then
            self.destX = self.tx
            self.destY = self.ty
            box.destX = box.tx
            box.destY = box.ty
          end
        end
        
      end
    end
  end
end

return player