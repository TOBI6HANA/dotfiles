return {
	"brenoprata10/nvim-highlight-colors",
	event = "BufReadPre",
	opts = {
		render = "virtual",
		virtual_text = "■",
		virtual_text_style = "before",

		enable_hex = true,
		enable_short_hex = true,
		enable_rgb = true,
		enable_hsl = true,
		enable_var_usage = true,
		enable_named_colors = true,
		enable_tailwind = false,

		custom_colors = {},
	},
}
