local opt = vim.opt
local keymap = vim.keymap

-- always set leader first!
keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
-- never ever folding
opt.foldenable = false
opt.foldmethod = 'manual'
opt.foldlevelstart = 99

-- keep more context on screen while scrolling
opt.scrolloff = 2

-- never show me line breaks if they're not there
opt.wrap = false

-- always draw sign column. prevents buffer moving when adding/deleting sign
opt.signcolumn = 'yes'

-- sweet sweet relative line numbers
opt.relativenumber = true

-- and show the absolute line number for the current line
opt.number = true

-- keep current content top + left when splitting
opt.splitright = true
opt.splitbelow = true

-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
opt.undofile = true

--" Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
opt.wildmode = 'list:longest'

-- when opening a file with a command (like :e),
-- don't suggest files like there:
opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'

-- tabs: go big or go home
opt.shiftwidth = 8
opt.softtabstop = 8
opt.tabstop = 8
opt.expandtab = false

-- case-insensitive search/replace
opt.ignorecase = true
-- unless uppercase in search term
opt.smartcase = true

-- never ever make my terminal beep
opt.vb = true

-- more useful diffs (nvim -d)
--- by ignoring whitespace
opt.diffopt:append('iwhite')
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
opt.diffopt:append('algorithm:histogram')
opt.diffopt:append('indent-heuristic')

-- show a column at 80 characters as a guide for long lines
opt.colorcolumn = '80'

--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })

-- show more hidden characters
-- also, show tabs nicer
opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------
-- quick-open
keymap.set('', '<C-p>', '<cmd>Files<cr>')

-- rigprep
keymap.set('n', '<leader>f', '<cmd>Rg<cr>')

-- search buffers
keymap.set('n', '<leader>b', '<cmd>Buffers<cr>')

-- quick-save
keymap.set('n', '<leader>w', '<cmd>w<cr>')

-- make missing : less annoying
keymap.set('n', ';', ':')

-- Ctrl+j and Ctrl+k as Esc
keymap.set('n', '<C-j>', '<Esc>')
keymap.set('i', '<C-j>', '<Esc>')
keymap.set('v', '<C-j>', '<Esc>')
keymap.set('s', '<C-j>', '<Esc>')
keymap.set('x', '<C-j>', '<Esc>')
keymap.set('c', '<C-j>', '<Esc>')
keymap.set('o', '<C-j>', '<Esc>')
keymap.set('l', '<C-j>', '<Esc>')
keymap.set('t', '<C-j>', '<Esc>')

-- Ctrl-j is a little awkward unfortunately:
-- https://github.com/neovim/neovim/issues/5916
-- So we also map Ctrl+k
keymap.set('n', '<C-k>', '<Esc>')
keymap.set('i', '<C-k>', '<Esc>')
keymap.set('v', '<C-k>', '<Esc>')
keymap.set('s', '<C-k>', '<Esc>')
keymap.set('x', '<C-k>', '<Esc>')
keymap.set('c', '<C-k>', '<Esc>')
keymap.set('o', '<C-k>', '<Esc>')
keymap.set('l', '<C-k>', '<Esc>')
keymap.set('t', '<C-k>', '<Esc>')

-- Ctrl+h to stop searching
keymap.set('v', '<C-h>', '<cmd>nohlsearch<cr>')
keymap.set('n', '<C-h>', '<cmd>nohlsearch<cr>')

-- Jump to start and end of line using the home row keys
keymap.set('', 'H', '^')
keymap.set('', 'L', '$')

-- Neat X clipboard integration
-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
keymap.set('n', '<leader>p', '<cmd>read !wl-paste<cr>')
keymap.set('n', '<leader>c', '<cmd>w !wl-copy<cr><cr>')

-- <leader><leader> toggles between buffers
keymap.set('n', '<leader><leader>', '<c-^>')

-- <leader>, shows/hides hidden characters
keymap.set('n', '<leader>,', ':set invlist<cr>')

-- always center search results
keymap.set('n', 'n', 'nzz', { silent = true })
keymap.set('n', 'N', 'Nzz', { silent = true })
keymap.set('n', '*', '*zz', { silent = true })
keymap.set('n', '#', '#zz', { silent = true })
keymap.set('n', 'g*', 'g*zz', { silent = true })

-- "very magic" (less escaping needed) regexes by default
keymap.set('n', '?', '?\\v')
keymap.set('n', '/', '/\\v')
keymap.set('c', '%s/', '%sm/')

-- no arrow keys --- force yourself to use the home row
keymap.set('n', '<up>', '<nop>')
keymap.set('n', '<down>', '<nop>')
keymap.set('i', '<up>', '<nop>')
keymap.set('i', '<down>', '<nop>')
keymap.set('i', '<left>', '<nop>')
keymap.set('i', '<right>', '<nop>')

-- let the left and right arrows be useful: they can switch buffers
keymap.set('n', '<left>', ':bp<cr>')
keymap.set('n', '<right>', ':bn<cr>')

-- make j and k move by visual line, not actual line, when text is soft-wrapped
keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')

-------------------------------------------------------------------------------
--
-- configuring diagnostics
--
-------------------------------------------------------------------------------
-- Allow virtual text
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

-------------------------------------------------------------------------------
--
-- autocommands
--
-------------------------------------------------------------------------------
-- highlight yanked text
vim.api.nvim_create_autocmd(
	'TextYankPost',
	{
		pattern = '*',
		command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })'
	}
)
-- jump to last edit position on opening file
vim.api.nvim_create_autocmd(
	'BufReadPost',
	{
		pattern = '*',
		callback = function(ev)
			if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
				-- except for in git commit messages
				-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
				if not vim.fn.expand('%:p'):find('.git', 1, true) then
					vim.cmd('exe "normal! g\'\\""')
				end
			end
		end
	}
)

-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })

-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup('text', { clear = true })
for _, pat in ipairs({'text', 'markdown', 'mail', 'gitcommit'}) do
	vim.api.nvim_create_autocmd('Filetype', {
		pattern = pat,
		group = text,
		command = 'setlocal spell tw=72 colorcolumn=73',
	})
end

-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- main color scheme
	{
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme gruvbox-dark-hard]])
			vim.o.background = 'dark'
			-- XXX: hi Normal ctermbg=NONE
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
			vim.api.nvim_set_hl(0, 'Comment', bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
			vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
			-- XXX
			-- Would be nice to customize the highlighting of warnings and the like to make
			-- them less glaring. But alas
			-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
			-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
		end
	},
	-- nice bar at the bottom
	{
		'itchyny/lightline.vim',
		lazy = false, -- also load at start since it's UI
		config = function()
			-- no need to also show mode in cmd line when we have bar
			vim.o.showmode = false
			vim.g.lightline = {
				active = {
					left = {
						{ 'mode', 'paste' },
						{ 'readonly', 'filename', 'modified' }
					},
					right = {
						{ 'lineinfo' },
						{ 'percent' },
						{ 'fileencoding', 'filetype' }
					},
				},
				component_function = {
					filename = 'LightlineFilename'
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand('%:t') == '' then
					return '[No Name]'
				else
					return vim.fn.getreg('%')
				end
			end
			-- https://github.com/itchyny/lightline.vim/issues/657
			vim.api.nvim_exec(
				[[
				function! g:LightlineFilename()
					return v:lua.LightlineFilenameInLua()
				endfunction
				]],
				true
			)
		end
	},
	-- quick navigation
	{
		'ggandor/leap.nvim',
		config = function()
			require('leap').create_default_mappings()
		end
	},
	-- better %
	{
		'andymass/vim-matchup',
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end
	},
	-- auto-cd to root of git project
	-- 'airblade/vim-rooter'
	{
		'notjedi/nvim-rooter.lua',
		config = function()
			require('nvim-rooter').setup()
		end
	},
	-- show gitsigns in the gutter
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},
	-- fzf support for ^p
	{
		'junegunn/fzf.vim',
		dependencies = {
			{ 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
		},
		config = function()
			-- stop putting a giant window over my editor
			vim.g.fzf_layout = { down = '~20%' }
			-- when using :Files, pass the file list through
			--
			--   https://github.com/jonhoo/proximity-sort
			--
			-- to prefer files closer to the current file.
			-- function list_cmd()
			-- 	local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
			-- 	if base == '.' then
			-- 		-- if there is no current file,
			-- 		-- proximity-sort can't do its thing
			-- 		return 'fd --hidden --type file --follow'
			-- 	else
			-- 		return vim.fn.printf('fd --hidden --type file --follow | proximity-sort %s', vim.fn.shellescape(vim.fn.expand('%')))
			-- 	end
			-- end
			-- vim.api.nvim_create_user_command('Files', function(arg)
			-- 	vim.fn['fzf#vim#files'](arg.qargs, { source = list_cmd(), options = '--scheme=path --tiebreak=index' }, arg.bang)
			-- end, { bang = true, nargs = '?', complete = "dir" })
		end
	},
	-- LSP
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- Setup language servers.

			-- Rust
			vim.lsp.config('rust_analyzer', {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
						checkOnSave = {
							enable = true,
						},
						check = {
							command = "clippy",
						},
						imports = {
							group = {
								enable = false,
							},
						},
						completion = {
							postfix = {
								enable = false,
							},
						},
					},
				},
			})
			vim.lsp.enable('rust_analyzer')

			-- Bash LSP
			if vim.fn.executable('bash-language-server') == 1 then
				vim.lsp.enable('bashls')
			end

			-- TS LSP
			if vim.fn.executable('typescript-language-server') == 1 then
				-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
				vim.lsp.enable('ts_ls')
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			keymap.set('n', '<leader>e', vim.diagnostic.open_float)
			keymap.set('n', '[d', vim.diagnostic.goto_prev)
			keymap.set('n', ']d', vim.diagnostic.goto_next)
			keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					--keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
					keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
					keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- TODO: find some way to make this only apply to the current line.
					if client.server_capabilities.inlayHintProvider then
					    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end
	},
	-- LSP-based code-completion
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			'neovim/nvim-lspconfig',
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require'cmp'
			cmp.setup({
				snippet = {
					-- REQUIRED by nvim-cmp. get rid of it once we can
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					-- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
				}, {
					{ name = 'path' },
				}),
				experimental = {
					ghost_text = true,
				},
			})

			-- Enable completing paths in :
			cmp.setup.cmdline(':', {
				sources = cmp.config.sources({
					{ name = 'path' }
				})
			})
		end
	},
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require "lsp_signature".setup({
				doc_lines = 0,
				handler_opts = {
					border = "none"
				},
			})
		end
	},
	-- yaml
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- rust
	{
		'rust-lang/rust.vim',
		ft = { "rust" },
		config = function()
			vim.g.rustfmt_autosave = 1
			vim.g.rustfmt_emit_files = 1
			vim.g.rustfmt_fail_silently = 0
			vim.g.rust_clip_command = 'wl-copy'
		end
	},
	{
		'plasticboy/vim-markdown',
		ft = { "markdown" },
		dependencies = {
			'godlygeek/tabular',
		},
		config = function()
			-- never ever fold!
			vim.g.vim_markdown_folding_disabled = 1
			-- support front-matter in .md files
			vim.g.vim_markdown_frontmatter = 1
			-- 'o' on a list item should insert at same level
			vim.g.vim_markdown_new_list_item_indent = 0
			-- don't add bullets when wrapping:
			-- https://github.com/preservim/vim-markdown/issues/232
			vim.g.vim_markdown_auto_insert_bullets = 0
		end
	},
})
