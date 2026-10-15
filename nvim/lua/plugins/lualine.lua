return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local colors = {
			bg = "#161617",
			bg_dark = "#0f0e0e",
			bg_light = "#2a2929",
			red = "#ea83a5",
			magenta = "#e29eca",
			orange = "#ffa07f",
			yellow = "#e6b99d",
			green = "#90b99f",
			blue = "#9ca2cf",
			purple = "#957fb8",
			cyan = "#85b5ba",
			fg = "#c9c7cd",
			fg_dark = "#a6a69c",
			fg_light = "#c0c0b8",
			error = "#c34043",
			warning = "#ffa066",
			info = "#7fb4ca",
			hint = "#957fb8",
		}

		local custom_kanagawa = {
			normal = {
				a = { fg = colors.bg, bg = colors.fg, gui = "bold" },
				b = { fg = colors.fg, bg = colors.bg_light },
				c = { fg = colors.fg_dark, bg = colors.bg },
			},
			insert = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.fg, bg = colors.bg_light },
				c = { fg = colors.fg_dark, bg = colors.bg },
			},
			visual = {
				a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
				b = { fg = colors.fg, bg = colors.bg_light },
				c = { fg = colors.fg_dark, bg = colors.bg },
			},
			replace = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = colors.bg_light },
				c = { fg = colors.fg_dark, bg = colors.bg },
			},
			command = {
				a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
				b = { fg = colors.fg, bg = colors.bg_light },
				c = { fg = colors.fg_dark, bg = colors.bg },
			},
			inactive = {
				a = { fg = colors.fg_dark, bg = colors.bg_dark, gui = "bold" },
				b = { fg = colors.fg_dark, bg = colors.bg_dark },
				c = { fg = colors.fg_dark, bg = colors.bg_dark },
			},
		}

		require("lualine").setup({
			options = {
				theme = custom_kanagawa,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = {}, winbar = {} },
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { left = "", right = "" },
						right_padding = 2,
						left_padding = 2,
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
						color = { fg = colors.bg_dark, bg = colors.orange },
						separator = { left = "", right = "" },
						right_padding = 2,
						left_padding = 2,
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = { fg = colors.green },
							modified = { fg = colors.orange },
							removed = { fg = colors.red },
						},
						color = { fg = colors.fg_dark },
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = { modified = " ", readonly = " ", unnamed = "[No Name]" },
						color = { fg = colors.bg_dark, bg = colors.cyan },
						separator = { right = "" },
						right_padding = 2,
						left_padding = 2,
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						diagnostics_color = {
							error = { fg = colors.error },
							warn = { fg = colors.warning },
							info = { fg = colors.info },
							hint = { fg = colors.hint },
						},
						color = { fg = colors.fg_dark },
					},
				},
				lualine_x = {
					{
						"fileformat",
						symbols = {
							unix = "", -- e712
							dos = "", -- e70f
							mac = "", -- e711
						},
						color = {
							bg = colors.yellow,
							fg = colors.bg_dark,
						},
						separator = { left = "" },
						right_padding = 2,
						left_padding = 2,
					},
				},
				lualine_y = {
					{
						"lsp_status",
						icon = "",
						symbols = {
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							done = "✓",
						},
						ignore_lsp = {},
						show_name = true,
						color = { fg = colors.bg_dark, bg = colors.green },
						left_padding = 2,
						right_padding = 2,
						separator = { left = "" },
					},
					{
						"location",
						color = { fg = colors.bg_dark, bg = colors.purple },
						left_padding = 2,
						right_padding = 2,
						separator = { left = "" },
					},
				},
				lualine_z = {
					{
						"filetype",
						icon_only = true,
						colored = false,
						color = { fg = colors.bg_dark, bg = colors.red },
						left_padding = 2,
						right_padding = 2,
						separator = { left = "", right = "" }, -- 🟢 CAMBIADO A  PARA CERRAR REDONDO
					},
				},
			},
			inactive_sections = {
				lualine_a = {
					{
						"mode",
						separator = { left = "", right = "" },
						right_padding = 2,
						left_padding = 2,
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
						color = { fg = colors.bg_dark, bg = colors.orange },
						separator = { left = "", right = "" },
						right_padding = 2,
						left_padding = 2,
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = { fg = colors.green },
							modified = { fg = colors.orange },
							removed = { fg = colors.red },
						},
						color = { fg = colors.fg_dark },
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = { modified = " ", readonly = " ", unnamed = "[No Name]" },
						color = { fg = colors.bg_dark, bg = colors.cyan },
						separator = { right = "" },
						right_padding = 2,
						left_padding = 2,
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						diagnostics_color = {
							error = { fg = colors.error },
							warn = { fg = colors.warning },
							info = { fg = colors.info },
							hint = { fg = colors.hint },
						},
						color = { fg = colors.fg_dark },
					},
				},
				lualine_x = {
					{
						"fileformat",
						symbols = {
							unix = "", -- e712
							dos = "", -- e70f
							mac = "", -- e711
						},
						color = {
							bg = colors.yellow,
							fg = colors.bg_dark,
						},
						separator = { left = "" },
						right_padding = 2,
						left_padding = 2,
					},
				},
				lualine_y = {
					{
						"lsp_status",
						icon = "",
						symbols = {
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							done = "✓",
						},
						ignore_lsp = {},
						show_name = true,
						color = { fg = colors.bg_dark, bg = colors.green },
						left_padding = 2,
						right_padding = 2,
						separator = { left = "" },
					},
					{
						"location",
						color = { fg = colors.bg_dark, bg = colors.purple },
						left_padding = 2,
						right_padding = 2,
						separator = { left = "" },
					},
				},
				lualine_z = {
					{
						"filetype",
						icon_only = true,
						colored = false,
						color = { fg = colors.bg_dark, bg = colors.red },
						left_padding = 2,
						right_padding = 2,
						separator = { left = "", right = "" }, -- 🟢 CAMBIADO A  PARA CERRAR REDONDO
					},
				},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
