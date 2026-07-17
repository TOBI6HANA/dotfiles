return {
	{ "nvzone/volt", lazy = true },

	{
		"nvzone/minty",
		cmd = { "Shades", "Huefy" },
		keys = {
			{
				"<leader>cp",
				function()
					require("minty.huefy").open()
				end,
				desc = "Minty picker",
			},
		},
	},
}
