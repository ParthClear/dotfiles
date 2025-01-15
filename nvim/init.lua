-- Source vim config
vim.cmd('source ~/.vimrc') 
-- neovim config

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.o.statusline = "%t %F"
vim.wo.statusline = '%t %F'
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
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"nvim-java/nvim-java",
		{
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{
				'nvim-telescope/telescope.nvim', tag = '0.1.5',
				 dependencies = { 'nvim-lua/plenary.nvim' ,
				'BurntSushi/ripgrep',
				'sharkdp/fd',
				'princejoogie/dir-telescope.nvim'}

			}
		},
		{
			"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
			lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
			dependencies = {
				-- main one
				{ "ms-jpq/coq_nvim", branch = "coq" },

				-- 9000+ Snippets
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },

				-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
				-- Need to **configure separately**
				{ 'ms-jpq/coq.thirdparty', branch = "3p" }
				-- - shell repl
				-- - nvim lua api
				-- - scientific calculator
				-- - comment banner
				-- - etc
			},
			init = function()
				vim.g.coq_settings = {
					auto_start = "shut-up", -- if you want to start COQ at startup
				}
			end,
			config = function()
				-- Your LSP settings here
			end,
		},
		{
			"nvim-tree/nvim-tree.lua",
			version = "*",
			lazy = false,
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			config = function()
				require("nvim-tree").setup {}
			end,
		}
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "shine" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
-- Nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_group_empty = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
	hijack_cursor = true,
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
-- Mason 
require("mason").setup()
require("mason-lspconfig").setup()
require('spring_boot').init_lsp_commands()
require("lspconfig").jdtls.setup {
	init_options = {
		bundles = require("spring_boot").java_extensions(),
	},
}
require("lspconfig").pyright.setup {settings = {pyright = {autoImportCompletion = true,},python = {analysis = {autoSearchPaths = true,diagnosticMode = 'openFilesOnly',useLibraryCodeForTypes = true,typeCheckingMode = 'off'}}}}
require("lspconfig").biome.setup({})
-- colorscheme
vim.cmd [[colorscheme shine]]
-- telescope
require("telescope").setup({
        defaults = {
          path_display = {
            "shorten"
          },
        },
      })
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

function ffglobal ()
	return require('telescope.builtin').find_files({search_dirs={"~/"}})
end
function dirffglobal ()
	return require("telescope").extensions.dir.find_files({search_dirs{"./"}})
end
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.git_files, {})
vim.keymap.set('n', '<leader>p', ffglobal, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>e', "<cmd>NvimTreeFindFileToggle<CR>", {})

