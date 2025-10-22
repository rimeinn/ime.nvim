---lazy load `ime.nvim.ime`
---@module ime.nvim
local IME = require 'ime.nvim.ime'.IME
local M = {
    ime = IME()
}

---wrap `create_autocmds()`
function M.create_autocmds(...)
    if M.ime.backend then
        M.ime:create_autocmds(...)
    end
end

return M
