return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"gopls",
				"intelephense",
				"vtsls",
				"twiggy_language_server",
			},
			automatic_installation = true,
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			local vue_language_server_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			local vtsls_config = {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
				},
				filetypes = tsserver_filetypes,
			}

			local gopls_config = {}

			local emmet_language_server_config = {
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"typescriptreact",
					"twig",
				},
			}

			local html_config = {
				filetypes = { "html", "twig" },
			}

			local vue_ls_config = {}

			local markdown_oxide_config = {
				-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
				-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
				capabilities = vim.tbl_deep_extend("force", capabilities, {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				}),
				on_attach = function(client, bufnr)
					-- setup Markdown Oxide daily note commands
					if client.name == "markdown_oxide" then
						vim.api.nvim_create_user_command("Daily", function(args)
							local input = args.args
							vim.lsp.buf.execute_command({
								command = "jump",
								arguments = { input },
							})
						end, { desc = "Open daily note", nargs = "*" })
					end
				end,
			}

			vim.lsp.config("vtsls", vtsls_config)
			vim.lsp.config("vue_ls", vue_ls_config)
			vim.lsp.config("gopls", gopls_config)
			vim.lsp.config("markdown_oxide", markdown_oxide_config)
			vim.lsp.enable({ "vtsls", "vue_ls", "gopls", "tofu_ls", "markdown_oxide" }) -- If using `ts_ls` replace `vtsls` to `ts_ls`
			vim.lsp.config("emmet_language_server", emmet_language_server_config)
			vim.lsp.config("html", html_config)
			vim.lsp.enable({
				"vtsls",
				"vue_ls",
				"gopls",
				"tofu_ls",
				"twiggy_language_server",
				"emmet_language_server",
				"html",
			}) -- If using `ts_ls` replace `vtsls` to `ts_ls`

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			vim.diagnostic.config({
				update_in_insert = true,
				virtual_text = true,
			})
		end,
	},
}
