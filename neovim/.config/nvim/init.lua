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
			"folke/snacks.nvim",
			lazy = false,
			priority = 1000,
			opts = {
				scroll = {
					animate = {
						duration = { step = 15, total = 150 },
						easing = "outQuad",
					},
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							"branch",
							fmt = function(str)
								return str:sub(1, 20)
							end,
						},
						"diff",
						"diagnostics",
					},
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			},
		},
		{
			"wookayin/semshi",
			build = ":UpdateRemotePlugins",
			init = function()
				if vim.loop.os_uname().sysname == "Darwin" then
					vim.g.python3_host_prog = "/opt/homebrew/bin/python3.11"
				else
					vim.g.python3_host_prog = "/usr/bin/python"
				end
				vim.g["semshi#simplify_markup"] = false
				vim.g["semshi#error_sign"] = false
				vim.g["semshi#excluded_hl_groups"] = {
					"local",
					"unresolved",
					"attribute",
					"builtin",
					"free",
					"global",
					"parameter",
					"parameterUnused",
					"self",
				}
			end,
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = { "saghen/blink.cmp" },
			config = function()
				local capabilities = require("blink.cmp").get_lsp_capabilities()
				local lspconfig = require("lspconfig")

				lspconfig.pyright.setup({
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								ignore = { "*" },
								typeCheckingMode = "off",
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				})

				lspconfig.ruff.setup({
					init_options = {
						settings = {
							format = { args = { "--line-length=100" } },
						},
					},
					on_attach = function(client)
						client.server_capabilities.hoverProvider = false
					end,
				})

				lspconfig.bashls.setup({})

				lspconfig.sqlls.setup({})
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")

				configs.setup({
					ensure_installed = { "python", "sql" },
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = false },
				})
			end,
		},
		{
			"saghen/blink.cmp",
			version = "v0.*",
			opts = {
				keymap = { preset = "super-tab" },
				highlight = {
					use_nvim_cmp_as_default = true,
				},
				nerd_font_variant = "mono",
				signature = { enabled = true },
				completion = { accept = { auto_brackets = { enabled = true } } },
			},
		},
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
		{
			"sheerun/vim-polyglot",
			init = function()
				vim.g.polyglot_disabled = { "python", "autoindent" }
			end,
		},
		{ "danymat/neogen", config = true },
		{
			"lervag/vimtex",
			config = function()
				vim.g.vimtex_view_general_viewer = "evince"
			end,
			ft = "latex",
		},
		{
			"lcheylus/overlength.nvim",
			opts = { textwidth_mode = 1 },
		},
		{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
		{ "fladson/vim-kitty", ft = "kitty" },
		{ "tpope/vim-fugitive", cmd = "Git" },
		{ "dstein64/vim-startuptime", cmd = "StartupTime" },
		{ "tpope/vim-rhubarb" },
		{ "ntpeters/vim-better-whitespace" },
		{ "tpope/vim-sleuth" },
		{ "Raimondi/delimitMate" },
		{ "tmhedberg/SimpylFold" },
		{ "tpope/vim-surround" },
		{ "tpope/vim-repeat" },
		{ "AndrewRadev/splitjoin.vim" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "tokyonight" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
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

vim.api.nvim_set_hl(0, "LineNr", { ctermfg = "grey" })

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

vim.opt.mouse = ""

vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
