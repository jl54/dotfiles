return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = vim.g.catppuccin_flavour or "frappe",
			transparent_background = true,
            float = {
                transparent = true,
                solid = false
            },
		})

		vim.cmd([[colorscheme catppuccin]])
	end,
}
