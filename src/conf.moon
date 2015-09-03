love.conf = (t) ->
    t.version = "0.9.2"
    t.identity = "tictactoe"
    with t.window
        .title = "TicTacToe"
        .icon = "images/tictactoe.png"
        .width = 600
        .height = 630
        .fullscreen = false
