---A system IME
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 112 113
local IME = require "ime.ime".IME
local AutoIME = require "ime.backends.auto".IME
local M = {
    IME = {}
}

---@param ime table?
---@return table ime
function M.IME:new(ime)
    ime = ime or {}
    ime = IME(ime)
    ime.backend = ime.backend or AutoIME()
    setmetatable(ime, {
        __index = self
    })
    return ime
end

setmetatable(M.IME, {
    __index = IME,
    __call = M.IME.new
})

---create autocmds.
---@param augroup_id integer?
function M.IME:create_autocmds(augroup_id)
    augroup_id = augroup_id or vim.api.nvim_create_augroup("ime", {})

    vim.api.nvim_create_autocmd("InsertLeavePre", {
        group = augroup_id,
        callback = self:enable_cb()
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        group = augroup_id,
        callback = self:enable_cb()
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        group = augroup_id,
        callback = self:disable_cb()
    })
    vim.api.nvim_create_autocmd("CmdlineEnter", {
        group = augroup_id,
        callback = self:disable_cb()
    })
end

---override `IME`.
---@section overrides

---modify `vim.o.iminsert`/`vim.o.imsearch`:
---save the flag to use IM in insert mode for each buffer.
---override `self.iminsert` because it is global to all buffers.
--- Note: `wincmd j` trigger `BufEnter`, still in cmd mode
---@param is_enabled boolean
-- luacheck: ignore 212/self
function M.IME:set_enabled(is_enabled)
    if vim.fn.mode() == 'c' then
        vim.o.imsearch = is_enabled and 1 or 0
    else
        vim.o.iminsert = is_enabled and 1 or 0
    end
end

---see `:h iminsert`/`:h imsearch`.
---@return boolean
-- luacheck: ignore 212/self
function M.IME:get_enabled()
    return (vim.fn.mode() == 'c' and vim.o.imsearch or vim.o.iminsert) > 0
end

---when `InsertLeavePre`/`CmdlineLeave`,
---disable IME backend and save its enabled flag
---@return function
function M.IME:enable_cb()
    return function()
        if self.backend:disable() then
            self:enable()
        end
    end
end

---when `InsertEnter`/`CmdlineEnter`,
---check enabled flag and call
function M.IME:disable_cb()
    return function()
        if self:disable() then
            self.backend:enable()
        end
    end
end

return M
