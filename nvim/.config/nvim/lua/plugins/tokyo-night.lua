return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,

		opts = {
			style = "night",

			transparent = true,

			styles = {
				floats = "transparent",
				sidebars = "transparent",
			},
		},

		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")

			local hl = vim.api.nvim_set_hl

			-- Highlight groups

			-- Main buffers
			hl(0, "Normal", {
				bg = "NONE",
			})

			hl(0, "NormalNC", {
				bg = "NONE",
			})

			-- Normal floats (LSP, Mason, Lazy, etc.)
			hl(0, "NormalFloat", {
				bg = "#1a1b26",
			})

			hl(0, "FloatBorder", {
				bg = "#1a1b26",
				fg = "#7aa2f7",
			})

			-- Transparent floats (Snacks)
			hl(0, "NormalTransparent", {
				bg = "NONE",
			})

			hl(0, "FloatBorderTransparent", {
				bg = "NONE",
				fg = "#7aa2f7",
			})

			-- Sidebars
			hl(0, "SidebarNormal", {
				bg = "NONE",
			})

			hl(0, "SidebarBorder", {
				bg = "NONE",
			})

			-- LSP inlay hints
			hl(0, "LspInlayHint", {
				fg = "#565f89",
				bg = "NONE",
				italic = true,
			})

			-- Treesitter context
			hl(0, "TreesitterContext", {
				bg = "NONE",
				fg = "#7aa2f7",
			})

			-- Float setup
			local function setup_float(win)
				if not vim.api.nvim_win_is_valid(win) then
					return
				end

				local cfg = vim.api.nvim_win_get_config(win)

				if cfg.relative == "" then
					return
				end

				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.bo[buf].filetype

				local is_snacks = vim.tbl_contains({
					"snacks_picker_input",
					"snacks_picker_list",
					"snacks_picker_preview",
					"snacks_explorer",
					"snacks_terminal",
				}, ft)

				if is_snacks then
					-- Snacks: fully transparent
					vim.api.nvim_set_option_value("winblend", 0, {
						win = win,
					})

					vim.api.nvim_set_option_value(
						"winhighlight",
						"Normal:NormalTransparent,NormalNC:NormalTransparent,FloatBorder:FloatBorderTransparent",
						{
							win = win,
						}
					)
				else
					-- Everything else: TokyoNight background + blend
					vim.api.nvim_set_option_value("winblend", 25, {
						win = win,
					})

					vim.api.nvim_set_option_value(
						"winhighlight",
						"Normal:NormalFloat,NormalNC:NormalFloat,FloatBorder:FloatBorder",
						{
							win = win,
						}
					)
				end
			end

			-- Refresh all existing Snacks windows
			local function refresh_snacks()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					if vim.api.nvim_win_is_valid(win) then
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.bo[buf].filetype

						if
							vim.tbl_contains({
								"snacks_picker_input",
								"snacks_picker_list",
								"snacks_picker_preview",
								"snacks_explorer",
							}, ft)
						then
							setup_float(win)
						end
					end
				end

				vim.cmd("redraw")
			end

			-- Apply to newly created floats
			vim.api.nvim_create_autocmd({
				"WinNew",
				"BufWinEnter",
			}, {
				callback = function(args)
					vim.defer_fn(function()
						local win = vim.fn.bufwinid(args.buf)

						if win ~= -1 then
							setup_float(win)
						end
					end, 20)
				end,
			})

			-- Snacks creates windows asynchronously
			vim.api.nvim_create_autocmd({
				"WinEnter",
				"BufEnter",
			}, {
				callback = function()
					vim.defer_fn(refresh_snacks, 100)
				end,
			})

			-- Sidebars
			vim.api.nvim_create_autocmd("WinEnter", {
				callback = function()
					local ft = vim.bo.filetype

					if
						vim.tbl_contains({
							"snacks_explorer",
							"undotree",
							"neo-tree",
							"NvimTree",
						}, ft)
					then
						vim.wo.winhighlight = "Normal:SidebarNormal"
					end
				end,
			})
		end,
	},
}
