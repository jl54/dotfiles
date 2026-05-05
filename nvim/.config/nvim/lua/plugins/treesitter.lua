return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		auto_install = true,
		folds = { enable = true },
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		local ensureInstalled = {
			-- ... your parsers
			"bash",
			"html",
			"css",
			"javascript",
			"typescript",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"php",
			"regex",
			"toml",
			"yaml",
			"vim",
			"vimdoc",
			"xml",
			"go",
			"gomod",
            "typescript"
		}
		local alreadyInstalled = require("nvim-treesitter.config").get_installed()
		local parsersToInstall = vim.iter(ensureInstalled)
			:filter(function(parser)
				return not vim.tbl_contains(alreadyInstalled, parser)
			end)
			:totable()
		require("nvim-treesitter").install(parsersToInstall)
	end,
}
