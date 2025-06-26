return {
	{
		"Aryansh-S/fastdark.vim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Load the colorscheme here
			vim.cmd([[colorscheme fastdark]])
		end,
	},
}
