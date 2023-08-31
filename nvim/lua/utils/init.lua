local M = {}

function M.quit()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_windows = vim.call(vim.win_findbuf(), bufnr)
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
    if modified and #buf_windows == 1 then
        vim.ui.input({
            prompt = "You have unsaved changes. Quit anyway? (y/n) ",
        }, function(input)
            if input == "y" then
                vim.cmd("qa!")
            end
        end)
    else
        vim.cmd("qa!")
    end
end

function M.find_files()
    local opts = {}
    local telescope = require("telescope.builtin")

    local ok = pcall(telescope.find_files, opts)
    if not ok then
        telescope.git_files(opts)
    end
end

function M.git_files()
    local opts = {}
    local telescope = require("telescope.builtin")

    local ok = pcall(telescope.git_files, opts)
    if not ok then
        telescope.find_files(opts)
    end
end

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function M.print_table(tbl, indent)
    if not indent then
        indent = 0
    end
    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            M.print_table(v, indent + 1)
        elseif type(v) == "boolean" then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

-- Trim preceding and trailing white spaces
function M.trim(s)
    return s:match("^()%s*$") and "" or s:match("^%s*(.*%S)")
end

function M.is_empty(str)
    return str == nil or str == ""
end

function M.git_config()
    local gitDir = require("lualine.components.branch.git_branch").find_git_dir()
    local Config = {}
    if M.is_empty(gitDir) then
        return Config
    end

    local configPath = gitDir .. "/config"
    local Section, Key, Value

    for l in io.lines(configPath) do
        -- Basically we are going to read every line
        -- if it starts with a Section or a Key
        -- we will Store them into the table

        if l:match("^[[]") ~= nil then
            -- Extract the Section Name
            Section = M.trim(l:match("^[[](.+)[]]$"))

            -- Create a New Table for each Section
            Config[Section] = {}
        end

        if l:match("(.+)=") ~= nil then
            -- Extract Key and Value, using = as a Seperator
            Key, Value = l:match("(.+)=(.+)")
            Key = M.trim(Key)
            Value = M.trim(Value)

            -- Check if the Value is a Number, and Explicitly Convert it to an integer
            if tonumber(Value) ~= nil then
                Value = tonumber(Value)
            end

            -- Add Each Key and Value into its Section Table
            Config[Section][Key] = Value
        end
    end -- Lines Loop End
    return Config
end

function M.git_host_icon()
    local config = M.git_config()
    local icon = " "
    if config == nil or config['remote "origin"'] == nil then
        return icon
    end

    local url = config['remote "origin"'].url
    if string.find(url, "github.com") then
        icon = " "
    elseif string.find(url, "gitlab.com") then
        icon = " "
    elseif string.find(url, "bitbucket.com") then
        icon = " "
    elseif string.find(url, "azure.com") or string.find(url, "visualstudio.com") then
        icon = "󰿕 "
    elseif string.find(url, "git") then
        icon = " "
    end
    return icon
end

---@param plugin string
function M.has(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

_G.neoutils = M
