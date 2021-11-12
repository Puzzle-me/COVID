require 'Util'

title = Class{}


function title:init()
    
    hyphen = love.graphics.newImage('Art/Title.png')
    coronabg = love.graphics.newImage('Art/Coronavirus.png')

    self.texture = love.graphics.newImage('Art/Covid-19.png')

    self.frames = {}
    self.currentFrame = nil
    self.state = 'title' 

    self.words = generateQuads(self.texture, 321, 60)
    self.titleheight = 60
    self.titlewidth = 321

    self.animations = {
        ['title'] = Animation({
            texture = self.texture,
            frames = self.words,
            interval = 0.15
        })
    }
    self.animation = self.animations['title']
    self.currentFrame = self.animation:getCurrentFrame()

    

end

function title:update(dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
    if love.keyboard.wasPressed('space') then
        self.state = 'start'
    end
end

function title:render()
    if self.state == 'title' then
        love.graphics.draw(coronabg, 0, 0)
        love.graphics.draw(hyphen, 0, 0)
        love.graphics.draw(self.texture, self.currentFrame, 49, 105)
        if math.floor(love.timer.getTime()) % 2 == 0 then
            love.graphics.print("Press Space to Start", VIRTUAL_WIDTH / 2 - 43, VIRTUAL_HEIGHT - 40)
        end
    end

    if self.state == 'start' then
        love.graphics.clear(0,0,0)
        gamestate = 'start'
    end

end