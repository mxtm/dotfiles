-- Plugin loading

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
	-- load the colorscheme here
	vim.cmd([[colorscheme tokyonight]])
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
	sections = {
	  lualine_a = {'mode'},
	  lualine_b = {
	    {'branch', fmt = function(str) return str:sub(1, 20) end },
	    'diff', 'diagnostics'
	  },
	  lualine_c = {'filename'},
	  lualine_x = {'encoding', 'fileformat', 'filetype'},
	  lualine_y = {'progress'},
	  lualine_z = {'location'}
	},
      },
    },
    {"Raimondi/delimitMate"},
    {"tmhedberg/SimpylFold"},
    {
      "lervag/vimtex",
      config = function()
	vim.g.vimtex_view_general_viewer = 'evince'
      end,
    },
    {"tpope/vim-surround"},
    {"tpope/vim-repeat"},
    {
      "wookayin/semshi",
      build = ":UpdateRemotePlugins",
      init = function()
	if vim.loop.os_uname().sysname == "Darwin" then
	  vim.g.python3_host_prog = "/opt/homebrew/bin/python3.11"
	else
	  vim.g.python3_host_prog = "/usr/bin/python"
	end
	vim.g['semshi#simplify_markup'] = false
      end,
    },
    {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
    {"neovim/nvim-lspconfig"},
    {
      "sheerun/vim-polyglot",
      init = function()
	vim.g.polyglot_disabled = { "python", "autoindent" }
      end,
    },
    {"tpope/vim-sleuth"},
    {
      "kkoomen/vim-doge",
      config = function()
	vim.g.doge_doc_standard_python = 'google'
      end,
    },
    {"dstein64/vim-startuptime"},
    {
      "folke/trouble.nvim",
      cmd = { "Trouble" },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
	icons = {
	  indent = {
	    middle = " ",
	    last = " ",
	    top = " ",
	    ws = "│  ",
	  },
	},
	modes = {
	  diagnostics = {
	    groups = {
	      { "filename", format = "{file_icon} {basename:Title} {count}" },
	    },
	    filter = { buf = 0 },
	  },
	},
	warn_no_results = false,
	open_no_results = true,
      },
    },
    {"tpope/vim-fugitive"},
    {"tpope/vim-rhubarb"},
    {
      "lcheylus/overlength.nvim",
      opts = { textwidth_mode = 1 },
    },
    {"ntpeters/vim-better-whitespace"},
    -- {"bling/vim-bufferline"},
    -- {"vim-scripts/indentpython.vim"},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- General neovim configuration

vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.showmatch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.clipboard = "unnamed"

vim.api.nvim_set_hl(0, 'LineNr', { ctermfg = 'grey' })

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

vim.opt.mouse = ''

vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')

--[[
"Auto indenting toggle for pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"Reformat key
map <F7> mzgg=G`z<CR>
--]]

-- Lua plugin configuration

local lspconfig = require('lspconfig')
lspconfig.ruff.setup({
  init_options = {
    settings = {
      format = { args = { "--line-length=100" } },
    }
  }
})
lspconfig.bashls.setup{}
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
