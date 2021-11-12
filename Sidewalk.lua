require 'Util'

Sidewalk = Class{}


local SCROLL_SPEED = 60

SIDEWALK_LEFT = 20, 120
SIDEWALK_RIGHT = 310, 410
CROSSWALK_BOTTOM = 770, 835
CROSSWALK_TOP = 105, 115

function Sidewalk:init ()
    self.texture = love.graphics.newImage('Art/Sidewalk.png')
    self.state = 'load'

    self.map = generateQuads(self.texture, 432, 234)
    self.tileheight = 234
    self.tilewidth = 432
    self.mapwidth = 1
    self.mapheight = 4

    self.tiles = {}
    self.player = Man(self)

    self.camX = 0
    self.camY = 698

    -- cache width and height of map in pixels
    self.mapWidthPixels = self.mapwidth * self.tilewidth
    self.mapHeightPixels = self.mapheight * self.tileheight

    for y = 1, self.mapheight do
        self:setTile(1, y, y )
    end


end

function Sidewalk:update(dt)
    if self.state == 'play' then
        self.player:update(dt)
        
        -- keep camera's y coordinate following the player, preventing camera from
        -- scrolling past 0 to the left and the map's width
        self.camY = math.max(0, math.min(self.mapHeightPixels - 243, self.player.y))
    end
end

function Sidewalk:tileAt(x, y)
    return {
        x = math.floor(x / self.tilewidth) + 1,
        y = math.floor(y / self.tileheight) + 1,
        id = self:getTile(math.floor(x / self.tilewidth) + 1, math.floor(y / self.tileheight) + 1)
    }
end

-- returns an integer value for the tile at a given x-y coordinate
function Sidewalk:getTile(x, y)
    return self.tiles[(y - 1) * self.mapwidth + x]
end

-- sets a tile at a given x-y coordinate to an integer value
function Sidewalk:setTile(x, y, id)
    self.tiles[(y - 1) * self.mapwidth + x] = id
end

function Sidewalk:walkable(x, y)

end

function Sidewalk:render()
    
    for y = 1, self.mapheight do
        for x = 1, self.mapwidth do
        local tile = self:getTile(x, y)
            love.graphics.draw(self.texture, self.map[tile],
                (x - 1) * self.tilewidth, (y - 1) * self.tileheight)
        end
    end
    self.state = 'play'
    gamestate = 'sidewalk'
        
    self.player:render()
end
