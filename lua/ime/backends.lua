---utilities for backends.
---wrap `vim.fs` and `vim.fn`
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local lfs = require "lfs"
local M = {}

---wrap `vim.fs.joinpath()`
---@param ... string
---@return string
function M.joinpath(...)
    if vim then
        return vim.fs.joinpath(...)
    end
    return table.concat({ ... }, '/')
end

---wrap `vim.fs.dirname()`
---@param path string
---@return string
function M.dirname(path)
    if vim then
        return vim.fs.dirname(path)
    end
    return path:match("(.*)/[^/]*$") or '/'
end

---wrap `vim.fs.find()`
---@param names function
---@param opts table
function M.find(names, opts)
    if vim then
        return vim.fs.find(names, opts)
    end
    local paths = {}
    for path in lfs.dir(opts.path) do
        if path:gsub(1, 1) ~= "." and names(opts.path, path) then
            table.insert(paths, path)
        end
    end
    return paths
end

return M
