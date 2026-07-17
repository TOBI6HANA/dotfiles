return {
	"mbbill/undotree",
	init = function()
		vim.g.undotree_WindowLayout = 3
		vim.g.undotree_SplitWidth = 30
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.opt.undofile = true
	end,
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
	},
}
