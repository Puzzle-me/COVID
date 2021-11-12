require 'Util'
require 'Animation'
Man = Class{}

WALKING_SPEED = 60

function Man:init(currentmap)

    self.x = 70
    self.y = 700
    self.width = 18
    self.height = 40

    --offset to support sprite flipping
    self.xOffset = self.width/2
    self.yOffset = self.height/2

    self.map = currentmap
    self.texture = love.graphics.newImage('Art/Man Spritesheet.png')

    -- animation frames
    self.frames = {}

    -- current animation frame
    self.currentFrame = nil

    -- used to determine behavior and animations
    self.state = 'forward idle'
    self.direction = 'forward'

    -- x and y velocity
    self.dx = 0
    self.dy = 0

     -- initialize all player animations
     self.animations = {
        ['forward idle'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(0, 0, 18, 40, self.texture:getDimensions())
            }
        }),
        ['back idle'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(126, 0, 18, 40, self.texture:getDimensions()),
            }
        }),
        ['side idle'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(252, 0, 18, 40, self.texture:getDimensions()),
            }
        }),
        ['forward walk'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(18, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(36, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(54, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(72, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(90, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(108, 0, 18, 40, self.texture:getDimensions())
            },
            interval = 0.15
        }),
        ['back walk'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(144, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(162, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(180, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(198, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(216, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(234, 0, 18, 40, self.texture:getDimensions())
            },
            interval = 0.15
        }),
        ['side walk'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(270, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(288, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(306, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(324, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(342, 0, 18, 40, self.texture:getDimensions()),
                love.graphics.newQuad(360, 0, 18, 40, self.texture:getDimensions())
            },
            interval = 0.15
        })
    }

    -- initialize animation and current frame we should render
    self.animation = self.animations['forward idle']
    self.currentFrame = self.animation:getCurrentFrame()

    -- behavior map we can call based on player state
    self.behaviors = {
        ['forward idle'] = function(dt)
            
            if love.keyboard.isDown('up') then 
                self.direction = 'forward'
                self.dy = -WALKING_SPEED
                self.state = 'forward walk'
                self.animations['forward walk']:restart()
                self.animation = self.animations['forward walk']
            elseif love.keyboard.isDown('down') then 
                self.direction = 'back'
                self.dy = WALKING_SPEED
                self.state = 'back walk'
                self.animations['back walk']:restart()
                self.animation = self.animations['back walk']
            elseif love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
                self.state = 'side walk'
                self.animations['side walk']:restart()
                self.animation = self.animations['side walk']
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                self.state = 'side walk'
                self.animations['side walk']:restart()
                self.animation = self.animations['side walk']
            else
                self.dx = 0
                self.dy = 0
            end
        end,
        ['back idle'] = function(dt)
            
            if love.keyboard.isDown('up') then 
                self.direction = 'forward'
                self.dy = -WALKING_SPEED
                self.state = 'forward walk'
                self.animations['forward walk']:restart()
                self.animation = self.animations['forward walk']
            elseif love.keyboard.isDown('down') then 
                self.direction = 'back'
                self.dy = -WALKING_SPEED
                self.state = 'back walk'
                self.animations['back walk']:restart()
                self.animation = self.animations['back walk']
            elseif love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
                self.state = 'side walk'
                self.animations['side walk']:restart()
                self.animation = self.animations['side walk']
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                self.state = 'side walk'
                self.animations['side walk']:restart()
                self.animation = self.animations['side walk']
            else
                self.dx = 0
                self.dy = 0
            end
        end,
        ['side idle'] = function(dt)
            
            if love.keyboard.isDown('up') then 
                self.direction = 'forward'
                self.dy = -WALKING_SPEED
                self.state = 'forward walk'
                self.animations['forward walk']:restart()
                self.animation = self.animations['forward walk']
            elseif love.keyboard.isDown('down') then 
                self.direction = 'back'
                self.dy = -WALKING_SPEED
                self.state = 'back walk'
                self.animations['back walk']:restart()
                self.animation = self.animations['back walk']
            elseif love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
                self.state = 'side walk'
                self.animations['side walk']:restart()
                self.animation = self.animations['side walk']
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                self.state = 'side walk'
                self.animations['side walk']:restart()
                self.animation = self.animations['side walk']
            else
                self.dx = 0
                self.dy = 0
            end
        end,
        ['forward walk'] = function(dt)
            
            if love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
                self.state = 'side walk'
                self.animation = self.animations['side walk']
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                self.state = 'side walk'
                self.animation = self.animations['side walk']
            elseif love.keyboard.isDown('up') then 
                self.direction = 'forward'
                self.dy = -WALKING_SPEED
                self.dx = 0
            elseif love.keyboard.isDown('down') then 
                self.direction = 'back'
                self.dy = WALKING_SPEED
                self.dx = 0
            else
                self.dx = 0
                self.dy = 0 
                self.state = 'forward idle'
                self.animation = self.animations['forward idle']
            end
        end,
        ['back walk'] = function(dt)
            
            
            if love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
                
                self.state = 'side walk'
                self.animation = self.animations['side walk']
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                
                self.state = 'side walk'
                self.animation = self.animations ['side walk']
            elseif love.keyboard.isDown('up') then 
                self.direction = 'forward'
                self.dy = -WALKING_SPEED
                self.dx = 0
            elseif love.keyboard.isDown('down') then 
                self.direction = 'back'
                self.dy = WALKING_SPEED
                self.dx = 0
            else
                self.dx = 0
                self.dy = 0
                self.state = 'back idle'
                self.animation = self.animations['back idle']
            end
        end,
        ['side walk'] = function(dt)
            
            if love.keyboard.isDown('up') then 
                self.direction = 'forward'
                self.dy = -WALKING_SPEED
                self.state = 'forward walk'
                self.animation = self.animations['forward walk']
            elseif love.keyboard.isDown('down') then 
                self.direction = 'back'
                self.dy = WALKING_SPEED
                self.state = 'back walk'
                self.animation = self.animations['back walk']
            elseif love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
                self.dy = 0 
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                self.dy = 0
            else
                self.dx = 0
                self.dy = 0
                self.state = 'side idle'
                self.animation = self.animations['side idle']
            end
        end
    }
end

function Man:update(dt)
    self.behaviors[self.state](dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Man:render()
    local scaleX

    -- set negative x scale factor if facing left, which will flip the sprite
    -- when applied
    if self.direction == 'left' then
        scaleX = -1
    else
        scaleX = 1
    end

    -- draw sprite with scale factor and offsets
    love.graphics.draw(self.texture, self.currentFrame, math.floor(self.x + self.xOffset),
        math.floor(self.y + self.yOffset), 0, scaleX, 1, self.xOffset, self.yOffset)
end
