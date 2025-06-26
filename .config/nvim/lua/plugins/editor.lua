return {
	{
		"francoiscabrol/ranger.vim",
		disabled = true,
		dependencies = {
			"rbgrouleff/bclose.vim",
		},
		config = function()
			vim.g.ranger_replace_netrw = 1
		end
	},
	{
		"kevinhwang91/rnvimr",
		config = function() 
            -- Make Ranger replace Netrw and be the file explorer
			vim.g.rnvimr_enable_ex = 1
            -- Make Ranger to be hidden after picking a file
            vim.g.rnvimr_enable_picker = 1
            vim.g.rnvimr_edit_cmd = 'drop'
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		}
	},
    { 'nvim-treesitter/nvim-treesitter' },
    { 'puremourning/vimspector' }
}
