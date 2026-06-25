-- Set <space> as leader (must happen before other plugins loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Relative line numbers
vim.o.relativenumber = true
vim.o.number = true -- display absolute line number instead of 0

-- Case-insensitive searching unless we use capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Sync vim and system clipboards
vim.schedule(function()
	local is_ssh = vim.env.SSH_TTY or vim.env.SSH_CONNECTION

	if is_ssh then
		vim.g.clipboard = "osc52"
		vim.opt.clipboard = ""
	else
		vim.g.clipboard = nil
		vim.opt.clipboard = "unnamedplus"
	end
end)

-- Copy to clipboard shortcuts
vim.keymap.set('n', '<leader>cp', function()
	local path = vim.fn.expand('%:p')
	vim.fn.setreg('+', path)
	vim.notify('Copied: ' .. path)
end, { desc = 'Copy absolute path' })

vim.keymap.set('n', '<leader>cr', function()
	local path = vim.fn.expand('%')
	vim.fn.setreg('+', path)
	vim.notify('Copied: ' .. path)
end, { desc = 'Copy relative path' })

-- Raise dialog if you close unsaved buffer (prevent mistakes)
vim.o.confirm = true

-- Disable swap files to prevent annoying errors
vim.opt.swapfile = false

-- Snappy escape
vim.o.ttimeoutlen = 1

-- Vim diagnostics
vim.diagnostic.config({
	underline = false,       -- don't underline errors
	severity_sort = true,    -- show most severe error first
	update_in_insert = false, -- don't update while typing
	float = { source = 'if_many' }, -- nicer look for floats and show source if multiple sources (ex. ruff and ty)
	jump = { float = true }, -- automatically open the diagnostic float if you jump with [d ]d
})

-- Show diagnostics
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

-- Easily move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Better command line movements
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-f>", "<S-Right>")

-- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank({ timeout = 300 }) end,
})

-- Plugins

vim.pack.add({
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/hrsh7th/nvim-cmp',         
    'https://github.com/hrsh7th/cmp-nvim-lsp',     
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/kdheepak/lazygit.nvim',
    'https://github.com/esmuellert/codediff.nvim',       
    'https://github.com/rebelot/kanagawa.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/lewis6991/gitsigns.nvim',
})

-- Activate Colorscheme
vim.cmd('colorscheme kanagawa-wave')
require('gitsigns').setup()


-- Configure Statusline Output Layout
require('lualine').setup({options = {theme = 'kanagawa', icons_enabled = true}})
require('render-markdown').setup({})
-- FzfLua Setup
local fzf = require('fzf-lua')
fzf.setup({
	fzf_colors = false,
	grep = {
		rg_opts = table.concat({
			"--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
			"--colors 'path:none'",
			"--colors 'line:none'",
			"--colors 'column:none'",
			"--colors 'match:fg:225,255,229'",
			"-e",
		}, " "),
	},
	ui_select = true,
	keymap = {
		builtin = {
			["<C-d>"] = 'preview-page-down', -- Better scrolling within the displays
			["<C-u>"] = 'preview-page-up',
		},
	},
	winopts = {
		height  = 0.95, -- window height
		width   = 0.90, -- window width
		preview = {
			layout   = 'vertical',
			vertical = "down:30%",
		}
	},
	files = {
		formatter = 'path.filename_first',
	},
})

vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })
vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua resume<cr>', { desc = 'Resume last picker' })
vim.keymap.set('n', '<leader>,', '<cmd>FzfLua buffers<cr>', { desc = 'Buffers' })

vim.keymap.set('n', 'grr', fzf.lsp_references, { desc = 'References' })
vim.keymap.set('n', 'gri', fzf.lsp_implementations, { desc = 'Implementations' })
vim.keymap.set('n', 'gra', fzf.lsp_code_actions, { desc = 'Code actions' })
vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = 'Go to definition' })

vim.keymap.set('n', '<leader>fc', '<cmd>FzfLua colorschemes<cr>', { desc = 'Pick colorscheme' })

local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(), -- Force completion manually
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- Suggestions from my active LSPs
    }, {
        { name = 'buffer' },   -- Text words from current file
    }),
    -- Formats the popup window menu to show [LSP] and [buffer]
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer   = "[buffer]",
            })[entry.source.name]
            return vim_item
        end
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = { "utf-8" }

-- ---  Custom Odoo LS ---
vim.lsp.config("odoo_ls", {
    cmd = { 
        vim.fn.expand("$HOME/bin/odoo_ls_server"),
        -- "--config-path",
        -- vim.fn.expand("$HOME/prj/ac19/odools.toml"),
    },
    filetypes = { 'python', 'xml' },
    root_markers = { "odools.toml", ".git" },
    capabilities = capabilities,
    settings = {
        Odoo = {
            selectedProfile = 'main', 
        }
    }
})

-- -- --- 2. Pyright Typing Companion Engine ---
-- vim.lsp.config("pyright", {
--     filetypes = { "python" },
--     root_markers = { "odools.toml", "pyproject.toml", ".git" },
--     capabilities = capabilities,
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 diagnosticMode = "openFilesOnly",
--                 extraPaths = {
--                     vim.fn.expand("$HOME/prj/oc19"),
--                     vim.fn.expand("$HOME/prj/oc19/odoo/addons"),
--                 },
--             },
--             pythonPath = vim.fn.expand("$HOME/prj/oc19/.venv/bin/python"),
--         }
--     }
-- })

-- -- --- 3. Ruff Linter & Formatter ---
-- vim.lsp.config("ruff", {
--     filetypes = { "python" },
--     root_markers = { "pyproject.toml", "ruff.toml", ".git" },
--     capabilities = capabilities,
-- })

vim.lsp.enable({
    'odoo_ls', 
    -- 'pyright', 
    --'ruff',    
})

-- Treesitter

vim.cmd('syntax off')
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('modern-treesitter', { clear = true }),
    callback = function() pcall(vim.treesitter.start) end,
})

-- Oil.nvim
require("oil").setup({
	keymaps = {
		["<C-h>"] = "<C-w>h",
		["<BS>"] = "<C-w>h", -- only if your terminal sends Ctrl-h as BS
		["<C-l>"] = "<C-w>l",
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
	},
	columns = {
		{ "mtime", highlight = "Comment" } },
	view_options = {
		show_hidden = true,
		sort = {
			{ "type",  "asc" },
			{ "mtime", "desc" },
		}
	},
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Lazygit.nvim
local function git_line_history(start_line, end_line)
	start_line, end_line = math.min(start_line, end_line), math.max(start_line, end_line)
	local range = start_line .. ',' .. end_line .. ':' .. vim.fn.expand('%:t')
	local command = { 'git', '-C', vim.fn.expand('%:p:h'), '--no-pager', 'log', '-L', range }
	local output = vim.fn.systemlist(command)
	local command_text = vim.fn.join(vim.tbl_map(vim.fn.shellescape, command), ' ')

	vim.cmd('vnew')
	vim.bo.buftype = 'nofile'
	vim.bo.filetype = 'diff'
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.list_extend({ command_text, '' }, output))
	vim.bo.modified = false
end

vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gb', function() vim.ui.open(vim.fn.systemlist('git remote get-url origin')[1]) end,
	{ desc = 'Open git remote' })
vim.keymap.set('n', '<leader>gl', function()
	git_line_history(vim.fn.line('.'), vim.fn.line('.'))
end, { desc = 'Git line history' })
vim.keymap.set('v', '<leader>gl', function()
	git_line_history(vim.fn.line('v'), vim.fn.line('.'))
end, { desc = 'Git line history' })

-- Codediff (vscode like diffs :))
require("codediff").setup({})
vim.keymap.set('n', '<leader>ru', '<cmd>CodeDiff<cr>', { desc = 'Code diff not staged' })
vim.keymap.set('n', '<leader>rm', '<cmd>CodeDiff main<cr>', { desc = 'Code diff main' })
vim.keymap.set('n', '<leader>rh', '<cmd>CodeDiff HEAD~1<cr>', { desc = 'Code diff previous commit' })
