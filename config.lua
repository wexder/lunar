local M = {}
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

lvim.leader = "space"
vim.cmd("nnoremap . <Nop>")
vim.cmd("nnoremap ∆ <c-w>-")
vim.cmd("nnoremap ˚ <c-w>+")
vim.cmd("nnoremap ˙ <c-w><")
vim.cmd("nnoremap ¬ <c-w>>")

lvim.builtin.which_key.mappings["b"] = false
lvim.builtin.which_key.mappings["<space>"] = { "<cmd>lua require('telescope.builtin').git_files()<CR>", "Project files" }
lvim.builtin.which_key.mappings["b"] ={
  k = { "<cmd>BufferClose<CR>", "Close buffer" }
}
lvim.builtin.which_key.mappings["ff"] = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser{path='%:p:h'}<CR>", "File browser"}
lvim.builtin.which_key.mappings["sP"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"}
lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DapUI"}

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
      D = { "<cmd>lua vim.lsp.buf.references()<cr>", "Declaration" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    }
lvim.builtin.which_key.mappings["w"] = {
      name = "window",
      s = { "<cmd>split<cr>", "Split window"},
      v = { "<cmd>vsplit<cr>", "Split window vertically"},
      w = { "<c-w>w", "Switch windows"},
      d = { "<c-w>q", "Quit a window"},
      ["-"] = {"<c-w>-", "Decrease height"},
      ["+"] = {"<c-w>+", "Increase height"},
      ["<lt>"] = { "<c-w><", "Decrease width"},
      [">"] = { "<c-w>>", "Increase width"},
      ["|"] = { "<c-w>|", "Max out the width"},
      ["="] = { "<c-w>=", "Equally high and wide"},
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
    {"nvim-telescope/telescope-file-browser.nvim"},
    {"nvim-telescope/telescope-project.nvim"},
    {"mfussenegger/nvim-jdtls"},
    {"tpope/vim-dadbod"},
    {"kristijanhusak/vim-dadbod-ui"},
    {"buoto/gotests-vim"},
    { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} },
    { "skywind3000/asynctasks.vim", requires = {"skywind3000/asyncrun.vim"} },
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

vim.cmd("let g:asyncrun_open = 6")
vim.cmd("let g:asynctasks_term_pos = 'right'")
vim.cmd("let g:asynctasks_term_cols = 60")

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
}

vim.opt.relativenumber = true
