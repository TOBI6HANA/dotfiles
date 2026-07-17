vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "css", "scss" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.showtabline = 1

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 150,
			higroup = "IncSearch",
		})
	end,
})

vim.opt.updatetime = 50
vim.opt.timeoutlen = 400

vim.opt.swapfile = false

vim.opt.undodir = vim.fn.stdpath("state") .. "/undo//"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.lsp.document_color.enable(false)

vim.o.wildchar = ("\t"):byte() -- Tab triggers completion (this is the default anyway)
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full" -- Tab = complete longest match, then cycle
