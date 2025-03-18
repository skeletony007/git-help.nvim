local M = {}

local Job = require("plenary.job")

---@param cwd string current working directory
---@return table upstreams list-like-vector of upstreams
M.get_upstreams = function(cwd)
    local find_upstream = Job:new({ "git", "remote", cwd = cwd })
    local stdout, code = find_upstream:sync()
    if code ~= 0 then
        error("failed getting upstreams")
    end

    return stdout
end

---@return string head head branch name
M.get_head_branch = function()
    local find_head = Job:new({
        "git",
        "symbolic-ref",
        "HEAD",
        cwd = vim.loop.cwd(),
    })
    local stdout, code = find_head:sync()
    if code ~= 0 then
        error("Error in determining HEAD branch name using Git")
    end

    return table.concat(stdout, ""):match("^refs/heads/([%w%-]+)$")
end

function M.setup(opts) end

return M
