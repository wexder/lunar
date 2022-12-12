local M = {}
lvim.log.level = "warn"
lvim.format_on_save = true


vim.opt.number = true
vim.opt.relativenumber = true
vim.g.catppuccin_flavour = "mocha"
lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "catppuccin"
lvim.transparent_window = true

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.options.theme = "onedark"
lvim.builtin.lualine.sections.lualine_y = {
  components.location
}

lvim.leader = "space"
vim.cmd("nnoremap . <Nop>")
vim.cmd("nnoremap ∆ <c-w>-")
vim.cmd("nnoremap ˚ <c-w>+")
vim.cmd("nnoremap ˙ <c-w><")
vim.cmd("nnoremap ¬ <c-w>>")
vim.api.nvim_set_keymap('n', 'H', [[<Cmd>BufferLineCyclePrev<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', [[<Cmd>BufferLineCycleNext<CR>]], { noremap = true, silent = true })

lvim.builtin.which_key.mappings["b"] = false
lvim.builtin.which_key.mappings["<space>"] = { "<cmd>lua require('telescope.builtin').git_files()<CR>", "Project files" }
lvim.builtin.which_key.mappings["b"] = {
  k = { "<cmd>BufferKill<CR>", "Close buffer" },
  b = { "<cmd>Telescope buffers<CR>", "List buffers" }
}
lvim.builtin.which_key.mappings["ff"] = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser{path='%:p:h'}<CR>",
  "File browser" }
lvim.builtin.which_key.mappings["sP"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DapUI" }

lvim.builtin.which_key.mappings["o"] = {
  name = "+Open",
  g = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'lazygit', count = 0, direction = 'float'})<CR>",
    "Lazygit" },
  d = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'lazydocker', count = 1, direction = 'float'})<CR>",
    "Lazydocker" },
  t = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'zsh', count = 2, direction = 'horizontal'})<CR>",
    "Term 1" },
  o = { "<cmd>lua require('lvim.core.terminal')._exec_toggle({ cmd = 'zsh', count = 3, direction = 'horizontal'})<CR>",
    "Term 2" },
  T = { "<cmd>term<CR>", "Term here" }
}
lvim.builtin.which_key.mappings["c"] = false
lvim.builtin.which_key.mappings["c"] = {
  name = "+Code",
  a = { "<cmd>lua require('lvim.core.telescope').code_actions()<cr>", "Code Action" },
  f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
  i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
  d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
  D = { "<cmd>lua vim.lsp.buf.references()<cr>", "Declaration" },
  r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
}
lvim.builtin.which_key.mappings["w"] = {
  name = "window",
  s = { "<cmd>split<cr>", "Split window" },
  v = { "<cmd>vsplit<cr>", "Split window vertically" },
  w = { "<c-w>w", "Switch windows" },
  d = { "<c-w>q", "Quit a window" },
  ["-"] = { "<c-w>-", "Decrease height" },
  ["+"] = { "<c-w>+", "Increase height" },
  ["<lt>"] = { "<c-w><", "Decrease width" },
  [">"] = { "<c-w>>", "Increase width" },
  ["|"] = { "<c-w>|", "Max out the width" },
  ["="] = { "<c-w>=", "Equally high and wide" },
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "java",
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
  -- {
  --   exe = "golines",
  --   filetypes = { "go" },
  -- },
}
-- vim.lsp.buf.formatting_sync(nil, 4000) -- 2 seconds

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "shellcheck",
    extra_args = { "--severity", "warning" },
  },
}

-- Additional Plugins
lvim.plugins = {
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-project.nvim" },
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "mfussenegger/nvim-jdtls" },
  { "buoto/gotests-vim" },
  -- { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },
  { "skywind3000/asynctasks.vim", requires = { "skywind3000/asyncrun.vim" } },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  { "leoluz/nvim-dap-go", config = function()
    require('dap-go').setup()
  end },
  { "catppuccin/nvim", as = "catppuccin", config = function()
    require("catppuccin").setup({
      transparent_background = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.9,
      },
    })
  end,
    run = ":CatppuccinCompile"
  },
  { "navarasu/onedark.nvim", config = function()
    require('onedark').setup {
      style = 'warmer',
      transparent = true,
      term_colors = false,
      ending_tildes = true,
      diagnostics = {
        darker = false,
        background = false
      }
    }
    require('onedark').load()
  end },
  { "williamboman/nvim-lsp-installer", config = function()
    require("nvim-lsp-installer").setup {
      ensure_installed = { "jdtls@1.12.0-202206011637" },
      automatic_installation = { exclude = { "jdtls" } }
    }
  end }
}

require 'telescope'.load_extension('project')
require 'telescope'.load_extension('file_browser')

vim.cmd("let g:asyncrun_open = 6")
vim.cmd("let g:asynctasks_term_pos = 'right'")
vim.cmd("let g:asynctasks_term_cols = 60")
vim.lsp.buf.format({
  timeout_ms = 2000
})

lvim.lsp.automatic_servers_installation = false
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
  "dockerls",
  "jdtls",
})

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

lvim.autocommands = {
  {
    "BufEnter", -- see `:h autocmd-events`
    { -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
      pattern = { "*" }, -- see `:h autocmd-events`
      command = "set number relativenumber",
    }
  },
}
