local vox_texture = {}

local function getPoints(model)
  local points, len = {}, 0
  for _,voxel in ipairs(model.voxels) do
    len = len + 1
    local color8 = model.palette[voxel[4]]
    local color = {color8[1]/255, color8[2]/255, color8[3]/255, color8[4]/255}
    local x,y,z = voxel[1], voxel[2], voxel[3]

    points[len] = { x + 0.5,
    model.sizeY * model.sizeZ - z * model.sizeY - y + 0.5,
                    color[1], color[2], color[3], color[4]>0 and color[4] or 255} -- r,g,b,a      
  end
  return points
end


-- model is a vox model parsed by vox_model.new(binaryString)
-- vox_texture.new returns a table with the following attributes:
--   {
--     sizeX = <the model sizeX>,
--     sizeY = <the model sizeY>,
--     sizeZ = <the model sizeZ>,
--     canvas = <a love2d canvas where the model has been "sliced and rasterized"
--   }

function vox_texture.new(model)
  local canvas = love.graphics.newCanvas(model.sizeX, model.sizeY * model.sizeZ)
  canvas:renderTo(function()
    love.graphics.points(getPoints(model))
  end)
  return love.graphics.newImage(canvas:newImageData())
end

return vox_texture
