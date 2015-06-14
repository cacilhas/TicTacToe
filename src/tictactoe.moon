indexes = {
    {1, 1, 3, 1}
    {1, 2, 3, 2}
    {1, 3, 3, 3}
    {1, 1, 1, 3}
    {2, 1, 2, 3}
    {3, 1, 3, 3}
    {1, 1, 3, 3}
    {3, 1, 1, 3}
}


--------------------------------------------------------------------------------
class Board
    finished: false
    _m: nil

    new: (app) =>
        @app = app
        @[i] = 0 for i = 1, 9

    get: (x, y) => @[(y - 1) * 3 + x]

    set: (x, y, value) =>
        @[(y - 1) * 3 + x] = value
        @_m = nil

    checkend: =>
        if not @_m
            @_m = {
                @[1] * @[2] * @[3]
                @[4] * @[5] * @[6]
                @[7] * @[8] * @[9]
                @[1] * @[4] * @[7]
                @[2] * @[5] * @[8]
                @[3] * @[6] * @[9]
                @[1] * @[5] * @[9]
                @[3] * @[5] * @[7]
            }

        last = 1
        for i, s in ipairs @_m
            return true, "x", i if s == 1
            return true, "o", i if s == 8
            last *= s
        if last > 0 then true, "v" else false

    toggle: (xo, x, y) =>
        if @finished
            nil  -- ignore when finished
        elseif (@\get x, y) != 0
            false  -- out of board
        elseif xo == "x"
            @\set(x, y, 1)
            true
        elseif xo == "o"
            @\set(x, y, 2)
            true
        else
            false  -- WTF?

    draw: =>
        with love.graphics
            .draw @app.background, 0, 0
            for y = 1, 3
                for x = 1, 3
                    cur = @\get x, y
                    unless cur == 0
                        .draw @app.foreground,
                              if cur == 1 then @app.xquad else @app.oquad,
                              (x - 1) * 200 + 16,
                              (y - 1) * 210 + 16

            finished, win, index = @\checkend!
            if finished
                @finished = true
                if win == "v"
                    .draw @app.tie, 0, 0
                else
                    coords = indexes[index]
                    x0 = (coords[1] - .5) * 200 + 16
                    y0 = (coords[2] - .5) * 210 + 16
                    x1 = (coords[3] - .5) * 200 + 16
                    y1 = (coords[4] - .5) * 210 + 16
                    .setColor 0x00, 0x00, 0x00
                    .line x0, y0, x1, y1
                    .reset!


--------------------------------------------------------------------------------
{
    _VERSION: "1.1"
    _DESCRIPTION: "Tic-Tac-Toe game"
    _AUTHOR: "ℜodrigo Arĥimedeς ℳontegasppa ℭacilhας <batalema@cacilhas.info>"
    _URL: ""
    _LICENSE: "BSD 3-Clause License"

    newboard: Board
}
