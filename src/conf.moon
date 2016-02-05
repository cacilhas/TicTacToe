love.conf = (t) ->
    t.version = "0.10.0"
    t.identity = "tictactoe"

    with t.window
        .title = "TicTacToe"
        .icon = "images/tictactoe.png"
        .width = 600
        .height = 630
        .fullscreen = false

    with t.modules
        .audio = false
        .math = false
        .physics = false
        .sound = false
        .timer = false
        .video = false
