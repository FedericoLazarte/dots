return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },

				javascript = { "eslint_d", "prettier" },
				javascriptreact = { "eslint_d", "prettier" },
				typescript = { "eslint_d", "prettier" },
				typescriptreact = { "eslint_d", "prettier" },

				html = { "prettier" },

				css = { "prettier" },
				scss = { "prettier" },

				json = { "prettier" },

				go = { "gofmt" },

				python = { "ruff_format" },
			},

			--	format_on_save = {
			--		timeout_ms = 2500,
			--		lsp_fallback = true,
			--	},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"prettier",
					"ruff",
					"eslint_d",
				},
			})
		end,
	},
}
