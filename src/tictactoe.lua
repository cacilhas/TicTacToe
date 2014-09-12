local tictactoe = {
    _VERSION = "1.0",
    _DESCRIPTION = "Tic-Tac-Toe game",
    _AUTHOR = "ℜodrigo ℭacilhας <batalema@cacilhas.info>",
    _URL = "",
    _LICENSE = "BSD 3-Clause License",
}


------------------------------------------------------------------------
local indexes = {
    {1, 1, 3, 1},
    {1, 2, 3, 2},
    {1, 3, 3, 3},
    {1, 1, 1, 3},
    {2, 1, 2, 3},
    {3, 1, 3, 3},
    {1, 1, 3, 3},
    {3, 1, 1, 3},
}


------------------------------------------------------------------------
local Board = {
    new = function(cls, app)
        return setmetatable({0, 0, 0, 0, 0, 0, 0, 0, 0; app=app}, cls)
    end,

    __index = {
        get = function(self, x, y)
            return self[(y - 1) * 3 + x]
        end,

        set = function(self, x, y, value)
            self[(y - 1) * 3 + x] = value
            self._m = nil
        end,

        check_end = function(self)
            local m
            if self._m then
                m = self._m
            else
                m = {
                    self[1] * self[2] * self[3],
                    self[4] * self[5] * self[6],
                    self[7] * self[8] * self[9],
                    self[1] * self[4] * self[7],
                    self[2] * self[5] * self[8],
                    self[3] * self[6] * self[9],
                    self[1] * self[5] * self[9],
                    self[3] * self[5] * self[7],
                 }
                self._m = m
            end

            local t = 1
            local i, s
            for i, s in ipairs(m) do
                if s == 1 then return true, 'x', i end
                if s == 8 then return true, 'o', i end
                t = t * s
            end

            if t > 0 then return true, 'v' end
            return false
        end,

        toggle = function(self, xo, x, y)
            if self.finished then return end
            if self:get(x, y) ~= 0 then return false end
            if xo == 'x' then self:set(x, y, 1) return true
            elseif xo == 'o' then self:set(x, y, 2) return true end
            return false
        end,

        draw = function(self)
            local app = self.app
            local xo = app.foreground
            local xquad = app.xquad
            local oquad = app.oquad
            local x, y

            love.graphics.draw(app.background, 0, 0)
            for y = 1, 3 do
                for x = 1, 3 do
                    local cur = self:get(x, y)
                    if cur ~= 0 then
                        local lx = (x - 1) * 200 + 16
                        local ly = (y - 1) * 210 + 16
                        local quad
                        if cur == 1 then quad = xquad else quad = oquad end
                        love.graphics.draw(xo, quad, lx, ly)
                    end
                end
            end

            local finished, win, index = self:check_end()
            if finished then
                self.finished = true
                if win == 'v' then
                    love.graphics.draw(app.tie, 0, 0)
                else
                    local coords = indexes[index]
                    local x0 = (coords[1] - .5) * 200 + 16
                    local y0 = (coords[2] - .5) * 210 + 16
                    local x1 = (coords[3] - .5) * 200 + 16
                    local y1 = (coords[4] - .5) * 210 + 16

                    love.graphics.setColor({0x00, 0x00, 0x00})
                    love.graphics.line(x0, y0, x1, y1)
                    love.graphics.reset()
                end
            end
        end,
    },
}


------------------------------------------------------------------------
tictactoe.newboard = function (...) return Board:new(...) end


------------------------------------------------------------------------
return tictactoe
