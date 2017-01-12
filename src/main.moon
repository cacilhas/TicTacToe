local *
tictactoe = assert require "tictactoe"
import floor from math

app = {}


----------------------------------------------------------------------------------
reset = ->
    app.board = tictactoe.newboard app
    app.current, app.next = "x", "o"


----------------------------------------------------------------------------------
love.load = ->
    with love.graphics
        app.background = .newImage "images/background.png"
        app.foreground = .newImage "images/xo.png"
        app.tie        = .newImage "images/tie.png"
        app.xquad      = .newQuad  0, 0, 174, 186, 348, 186
        app.oquad      = .newQuad  174, 0, 348, 186, 348, 186
    reset!


----------------------------------------------------------------------------------
love.draw = -> app.board\draw!


----------------------------------------------------------------------------------
love.keyreleased = (key) -> reset! if key == "escape"


----------------------------------------------------------------------------------
love.mousereleased = (x, y, button) ->
    if button == 1
        rx = 1 + floor x / 200
        ry = 1 + floor y / 210
        if app.board\toggle app.current, rx, ry
            app.current, app.next = app.next, app.current
