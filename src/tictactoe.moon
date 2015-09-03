ffi = assert require "ffi"

_VERSION = "1.1"
_DESCRIPTION = "Tic-Tac-Toe game"
_AUTHOR = "ℜodrigo Arĥimedeς ℳontegasppa ℭacilhας <batalema@cacilhas.info>"
_URL = ""
_LICENSE = "BSD 3-Clause License"
--------------------------------------------------------------------------------

ffi.cdef [[
    struct score {
        bool done;
        unsigned char value[8];
    };

    enum valid_move {
        move_none = 0,
        move_X = 1,
        move_O = 2
    };
]]


positions = ffi.new "uint16_t[?]", 8 * 4,
    116, 121, 516, 121,
    116, 331, 516, 331,
    116, 541, 516, 541,
    116, 121, 116, 541,
    316, 121, 316, 541,
    516, 121, 516, 541,
    116, 121, 516, 541,
    516, 121, 116, 541


C = ffi.C


--------------------------------------------------------------------------------
class Board
    finished: false

    new: (app) =>
        @app = app
        @board = ffi.new "enum valid_move[?]", 9
        @map = ffi.new "struct score"

    get: (x, y) => @board[(y - 1) * 3 + x - 1]

    set: (x, y, value) =>
        @board[(y - 1) * 3 + x - 1] = value
        @map.done = false

    checkend: =>
        if not @map.done
            @map.value[0] = @board[0] * @board[1] * @board[2]
            @map.value[1] = @board[3] * @board[4] * @board[5]
            @map.value[2] = @board[6] * @board[7] * @board[8]
            @map.value[3] = @board[0] * @board[3] * @board[6]
            @map.value[4] = @board[1] * @board[4] * @board[7]
            @map.value[5] = @board[2] * @board[5] * @board[8]
            @map.value[6] = @board[0] * @board[4] * @board[8]
            @map.value[7] = @board[2] * @board[4] * @board[6]
        @map.done = true

        last = 1
        for i = 1, 8
            s = @map.value[i - 1]
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
            @\set(x, y, C.move_X)
            true
        elseif xo == "o"
            @\set(x, y, C.move_O)
            true
        else
            false  -- WTF?

    draw: =>
        with love.graphics
            .draw @app.background, 0, 0
            for y = 1, 3
                for x = 1, 3
                    cur = @\get x, y
                    unless cur == C.move_none
                        .draw @app.foreground,
                              if cur == C.move_X then @app.xquad else @app.oquad,
                              (x - 1) * 200 + 16,
                              (y - 1) * 210 + 16

            finished, win, index = @\checkend!
            if finished
                @finished = true
                if win == "v"
                    .draw @app.tie, 0, 0
                else
                    coords = positions + ffi.new "size_t", (index - 1) * 4
                    .setColor 0x00, 0x00, 0x00
                    .line coords[0], coords[1], coords[2], coords[3]
                    .reset!


--------------------------------------------------------------------------------
{
    :_VERSION
    :_DESCRIPTION
    :_AUTHOR
    :_URL
    :_LICENSE
    newboard: Board
}
