return { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
        require("catppuccin").setup{
            flavour = vim.g.catppuccin_flavour or "frappe"
        }

        vim.cmd[[colorscheme catppuccin]]
    end
}
