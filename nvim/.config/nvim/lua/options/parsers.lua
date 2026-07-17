vim.treesitter.language.register("bash", "zsh")
vim.treesitter.language.register("tsx", "typescriptreact")

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"bash",
		"zsh",
		"cpp",
		"css",
		"html",
		"java",
		"javascript",
		"python",
		"rust",
		"typescript",
		"typescriptreact",
		"qml",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

vim.filetype.add({
	extension = {
		qml = "qmljs",
	},
})

vim.treesitter.language.register("qmljs", "qml")

vim.filetype.add({
	extension = {
		qml = "qmljs",
	},
})

vim.treesitter.language.register("qmljs", "qml")
