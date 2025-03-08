local M = {}

function M.IS_WINDOWS()
  return neoconfigs.OS:find("Windows") and true or false
end

function M.IS_MAC()
  return neoconfigs.OS == "Darwin"
end

function M.IS_LINUX()
  return neoconfigs.OS == "Linux"
end

function M.IS_WSL()
  return M.IS_LINUX() and neoconfigs.uname.release:find("Microsoft") and true or false
end

function M.getOS()
  if M.IS_WINDOWS() or M.IS_WSL() then
    return "windows"
  elseif M.IS_MAC() then
    return "mac"
  elseif M.IS_LINUX() then
    return "linux"
  else
    return "unknown"
  end
end

function M.get_augroup(name)
  return vim.api.nvim_create_augroup("xafarr_" .. name, { clear = true })
end

function M.get_java_install_path(version)
  local version_path = vim.fn.system(
    "asdf list java | grep " .. version .. " | head -n 1 | sed 's/^[ *]*//' | xargs -I{} asdf where java {}"
  )
  return version_path
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

--- Rename related files when renaming a variable
---@param from string
---@param to string
function M.on_rename(from, to)
  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("workspace/willRenameFiles") then
      ---@diagnostic disable-next-line: invisible
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

--- Calculates NvimTree width according to the window size
function M.NvimTreeWidth(percentage)
  local ratio = percentage / 100
  local width = vim.go.columns
  if width < 150 then
    return math.floor(vim.go.columns * ratio)
  elseif width < 200 then
    ratio = (percentage - 5) / 100
    return math.floor(vim.go.columns * ratio)
  else
    ratio = (percentage - 10) / 100
    return math.floor(vim.go.columns * ratio)
  end
end

function M.quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call(vim.win_findbuf(), bufnr)
  local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
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

-- Telescope - Determine file path
function M.filename_first(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

function M.lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(_)
      vim.cmd("startinsert!")
    end,
  })

  lazygit:toggle()
end

_G.neoutils = M
