return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"gf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			html = { "prettier" },
			css = { "prettier" },
			-- qml = { "qmlformat" },
			-- qmljs = { "qmlformat" },
			qml = {},
			qmljs = {},
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500 },
		-- Customize formatters
		formatters = {
			shfmt = {
				append_args = { "-i", "2" },
			},
			qmlformat = {
				command = "qmlformat",
				args = { "-i", "$FILENAME" },
				stdin = false,
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
