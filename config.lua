local M = {}
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

lvim.leader = "space"
vim.cmd("nnoremap . <Nop>")

lvim.builtin.which_key.mappings["b"] = false
lvim.builtin.which_key.mappings["<space>"] = { "<cmd>lua require('telescope.builtin').git_files()<CR>", "Project files" }
lvim.builtin.which_key.mappings["b"] ={
  k = { "<cmd>BufferClose<CR>", "Close buffer" }
}
lvim.builtin.which_key.mappings["ff"] = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser{path='%:p:h'}<CR>", "File browser"}
lvim.builtin.which_key.mappings["sP"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"}

lvim.builtin.which_key.mappings["o"] ={
  name = "+Open",
  g = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'lazygit', count = 0, direction = 'float'})<CR>", "Lazygit" },
  d = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'lazydocker', count = 1, direction = 'float'})<CR>", "Lazydocker" },
  t = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'zsh', count = 2, direction = 'horizontal'})<CR>", "Term 1" },
  o = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'zsh', count = 3, direction = 'horizontal'})<CR>", "Term 2" },
  T = { "<cmd>term<CR>", "Term here" }
}
lvim.builtin.which_key.mappings["c"] = false
lvim.builtin.which_key.mappings["c"] = {
      name = "+Code",
      a = { "<cmd>lua require('lvim.core.telescope').code_actions()<cr>", "Code Action" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
      D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    }

lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "goimports",
    filetypes = { "go" },
  },
  {
    exe = "gofumpt",
    filetypes = { "go" },
  },
}
-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

-- Additional Plugins
lvim.plugins = {
    {"nvim-telescope/telescope-file-browser.nvim"},
    {"nvim-telescope/telescope-project.nvim"},
    {"mfussenegger/nvim-jdtls"},
    {"tpope/vim-dadbod"},
    {"kristijanhusak/vim-dadbod-ui"},
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = function()
        require("spectre").setup()
      end,
    }
}

require'telescope'.load_extension('project')
require'telescope'.load_extension('file_browser')

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/home/wexder/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.400.v20211117-0650.jar',

    '-configuration', '/home/wexder/.local/share/nvim/lsp_servers/jdtls/config_ss_linux',

    '-data', '/home/wexder/development/java/workspace'
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
    }
  },

  init_options = {
    bundles = {}
  },
}

config['on_attach'] = function(client, bufnr)
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

local dap = require('dap')
dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
  { "FileType", "*.java", "lua require('jdtls').start_or_attach(config)" },
}

vim.opt.relativenumber = true
