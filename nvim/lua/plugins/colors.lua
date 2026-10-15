return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = true,
			dimInactive = false,
			terminalColors = true,
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					Pmenu = { bg = "none" },
					PmenuSel = { bg = theme.ui.bg_p2 },
					TelescopeBorder = { fg = theme.ui.float.fg_border, bg = "none" },
					TelescopeTitle = { fg = theme.ui.special, bold = true },
				}
			end,
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
