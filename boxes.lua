local boxes = {}

boxes.list = {}

boxes.new = function(self, tx, ty, tz)
  local new = {}
  new.tx = tx
  new.ty = ty
  new.tz = tz or 1
  new.destX = tx
  new.destY = ty
  new.type = "box"
  table.insert(self.list, new)
  return new
end

boxes.checkBelow = function(self, j, tx, ty)
  for i = 1, #self.list do
    if i ~= j and self.list[i].tx == tx and self.list[i].ty == ty then
      return true
    end
  end
  if player.destX == tx and player.destY == ty then
    return true
  end
  return false
end

boxes.update = function(self, dt)
  for i = 1, #boxes.list do
    local box = boxes.list[i]
    -- if the box didn't reached his destination yet
    if box.tx ~= box.destX or box.ty ~= box.destY then
      box.tx = box.tx + 4*math.sign(box.destX - box.tx) * dt
      box.ty = box.ty + 4*math.sign(box.destY - box.ty) * dt
      if math.abs(box.destX - box.tx) + math.abs(box.destY - box.ty) < 0.05 then
        box.tx = box.destX
        box.ty = box.destY
      end
    end
    -- if the box can fall
    if box.tz > 1 then
      if not self:checkBelow(i, box.tx, box.ty, box.tz) and player:isToDest() then
        box.tz = box.tz - 2 * dt
        if box.tz < 1 then
          box.tz = 1
        end
      end
    end
  end
end

return boxes