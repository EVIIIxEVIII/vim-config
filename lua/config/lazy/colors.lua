return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main",
				styles = {
					bold = false,
					italic = false,
					transparency = false,
				},
			})
			vim.cmd([[colorscheme rose-pine]])
		end,
	},
}

