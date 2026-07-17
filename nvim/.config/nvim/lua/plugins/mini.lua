return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.ai").setup({})
			require("mini.surround").setup({})
			require("mini.pairs").setup({})
			require("mini.move").setup({
				mappings = {
					left = "<C-S-h>",
					right = "<C-S-l>",
					down = "<C-S-j>",
					up = "<C-S-k>",

					line_left = "<C-S-h>",
					line_right = "<C-S-l>",
					line_down = "<C-S-j>",
					line_up = "<C-S-k>",
				},
			})
			require("mini.splitjoin").setup({})
			local tabline = require("mini.tabline")

			tabline.setup({
				tabpage_section = "none",
			})

			local function update_tabline()
				if vim.fn.tabpagenr("$") < 2 then
					vim.opt.showtabline = 0
				else
					vim.opt.showtabline = 2
				end
			end

			vim.api.nvim_create_autocmd({ "TabNew", "TabClosed", "VimEnter" }, {
				callback = update_tabline,
			})

			update_tabline()
		end,
	},
}
