return {
	"folke/snacks.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			formats = {
				header = { "%s", align = "left" },
			},
			preset = {
				header = [[
       ████ ██████           █████      ██                    
      ███████████             █████                            
      █████████ ███████████████████ ███   ███████████  
     █████████  ███    █████████████ █████ ██████████████  
    █████████ ██████████ █████████ █████ █████ ████ █████  
  ███████████ ███    ███ █████████ █████ █████ ████ █████ 
 ██████  █████████████████████ ████ █████ █████ ████ ██████


			]],
			},
		},

		debug = { enabled = true },
		explorer = { enabled = true },
		git = { enabled = true },
		gitbrowse = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = {
			enabled = true,
			win = {
				position = "float",
				width = 0.9,
				height = 0.9,
			},
		},
		notifier = { enabled = true },
		picker = { enabled = true },
		quickfile = { enabled = true },
		rename = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		terminal = {
			enabled = true,
			win = {
				position = "bottom",
				height = 10,
			},
		},
		toggle = { enabled = true },
		words = { enabled = false },
		zen = { enabled = true },
	},
	keys = {
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss all notifications",
		},
		{
			"<leader>sf",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.pick("files")
			end,
			desc = "Find Files",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep Files",
		},
		{
			"<leader>n",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<C-\\>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle terminal",
		},
	},
}
