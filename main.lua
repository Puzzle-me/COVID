Class = require 'class'
push = require 'push'

require 'title'
require 'Animation'
require 'Coronavirus'
require 'Sidewalk'
require 'Man'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432
math.randomseed(os.time())

love.graphics.setDefaultFilter('nearest', 'nearest')

title = title()
sidewalk = Sidewalk()

function love.load()

    love.graphics.setFont(love.graphics.newFont('font.ttf', 8))
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true
    })
    
    love.window.setTitle('COVID-19 the Game')

    gamestate = 'title'

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end

function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end

function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

function love.resize(w, h)
    push:resize(w,h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.update(dt)
    title:update(dt)

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}

    if gamestate == 'sidewalk' then
        sidewalk:update(dt)
    end
end

function love.draw()
    push:apply('start')

    if gamestate == 'title' then

        love.graphics.clear(142/255, 68/255, 173/255, 255/255)

        love.graphics.translate(0,0)
        title:render()
        currentmap = title
    end

    if gamestate == 'start' then
        love.graphics.translate(math.floor(-sidewalk.camX + 0.5), math.floor(-sidewalk.camY + 0.5))
        sidewalk:render()
        currentmap = Sidewalk
    end

    if gamestate == 'sidewalk' then
        love.graphics.translate(math.floor(-sidewalk.camX + 0.5), math.floor(-sidewalk.camY + 0.5))
        sidewalk:render()
    end

    push:apply('end')
end
