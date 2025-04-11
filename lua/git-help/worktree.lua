local git_help = require("git-help")

M = {}

--- Prompt the user for new worktree details (path, branch, and upstream).
---
--- Using a menu with three stages:
---
--- 1. Input a new worktree path
--- 2. Input a branch name (defaults to the worktree path)
--- 3. Select an upstream from existing remotes or specify a new one.
---    (I am not familiar with working with multiple remotes, please forgive
---    any shortcomings ;)
---
--- If the user cancels any prompt, the function exits early.
---
--- This function returns the parameters for the `create_worktree()` function
--- of [git-worktree.nvim] such that:
---
--- ```lua
--- worktree.create_worktree(path, branch, name)
--- ```
---
--- is equivelant to
---
--- ```lua
--- worktree.create_worktree(M.create_worktree_menu(current_worktree_path))
--- ```
---
--- [git-worktree.nvim]: https://github.com/ThePrimeagen/git-worktree.nvim
---
---@return string path path
---@return string branch branch name
---@return string upstream upstream
M.create_worktree_menu = function(cwd)
    local path = vim.fn.input("Enter new worktree path: ", "", "dir")
    if path == "" then
        error("path cannot be empty")
    end
    local branch = vim.fn.input("Enter new worktree branch: ", path, "dir")
    if branch == "" then
        error("branch cannot be empty")
    end
    local upstream = vim.fn.input("Enter new worktree upstream: ", git_help.get_upstreams(cwd)[1])
    if upstream == "" then
        error("upstream cannot be empty")
    end

    return path, branch, upstream
end

return M
