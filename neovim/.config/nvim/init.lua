-- Revert to pre-0.10.0 color defaults
vim.cmd.colorscheme('vim')
vim.o.termguicolors = false

-- Pre plugin loading configuration
vim.g.python3_host_prog = '/usr/bin/python'
vim.g.polyglot_disabled = { 'python', 'autoindent' }

-- Plugin loading
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Optional dependency of trouble.nvim and lualine.nvim
Plug('nvim-tree/nvim-web-devicons')

Plug('nvim-lualine/lualine.nvim')

-- Plug('bling/vim-bufferline')

Plug('Raimondi/delimitMate')

Plug('tmhedberg/SimpylFold')

-- Plug('vim-scripts/indentpython.vim')

Plug('lervag/vimtex')

Plug('tpope/vim-surround')

Plug('tpope/vim-repeat')

Plug('wookayin/semshi', { ['do'] = function()
     vim.cmd["UpdateRemotePlugins"]()
end })

Plug('ellisonleao/glow.nvim')

Plug('neovim/nvim-lspconfig')

Plug('sheerun/vim-polyglot')

Plug('tpope/vim-sleuth')

Plug('kkoomen/vim-doge')

Plug('dstein64/vim-startuptime')

Plug('folke/trouble.nvim')

Plug('tpope/vim-fugitive')

Plug('tpope/vim-rhubarb')

Plug('lcheylus/overlength.nvim')

vim.call('plug#end')

-- Post plugin loading configuration

vim.g.vimtex_view_general_viewer = 'evince'

vim.g['semshi#simplify_markup'] = false

vim.g.doge_doc_standard_python = 'google'

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

require('lualine').setup {
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
  }
}

require('glow').setup()

local lspconfig = require('lspconfig')
lspconfig.ruff_lsp.setup{
  init_options = {
    settings = {
      -- format = { args = { "--line-length=100" } },
    }
  }
}
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

require('overlength').setup({
  textwidth_mode = 1
})
