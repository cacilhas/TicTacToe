local tictactoe = assert(require "tictactoe")
local app = {}


------------------------------------------------------------------------
function love.load()
    app.background = love.graphics.newImage("images/background.png")
    app.foreground = love.graphics.newImage("images/xo.png")
    app.tie = love.graphics.newImage("images/tie.png")
    app.xquad = love.graphics.newQuad(0, 0, 174, 186, 348, 186)
    app.oquad = love.graphics.newQuad(174, 0, 348, 186, 348, 186)
    app.board = tictactoe.newboard(app)
    app.current, app.next = "x", "o"
end


------------------------------------------------------------------------
function love.draw()
    app.board:draw()
end


------------------------------------------------------------------------
function love.mousereleased(x, y, button)
    if button == "l" then
        local rx = math.floor(x / 200) + 1
        local ry = math.floor(y / 210) + 1
        if app.board:toggle(app.current, rx, ry) then
            app.current, app.next = app.next, app.current
        end
    end
end
