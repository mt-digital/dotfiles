-- ==========================================
-- CORE SETTINGS
-- ==========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.colorcolumn.guibg = "white"
vim.opt.wrap = true              -- Enable soft wrapping
vim.opt.linebreak = true         -- Break at word boundaries, not mid-word
vim.opt.showbreak = "↪ "         -- Optional: visual indicator for wrapped lines
vim.opt.hlsearch = false
-- Cursor blink
vim.opt.guicursor = "n:block-blinkwait1000-blinkoff200-blinkon500,i:ver68-blinkwait760-blinkoff200-blinkon200";



-- ==========================================
-- KEYMAPS (Leader = Space)
-- ==========================================
local map = vim.keymap.set

-- Navigation & Files
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- Standard Ops
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Diagnostic float" })

-- Surround (vim-surround replacement)
map("n", "ys", "<cmd>lua require('nvim-surround').surround()<cr>", { desc = "Surround" })
map("n", "cs", "<cmd>lua require('nvim-surround').change()<cr>", { desc = "Change Surround" })
map("n", "ds", "<cmd>lua require('nvim-surround').delete()<cr>", { desc = "Delete Surround" })

-- ==========================================
-- PLUGIN MANAGER (Packer)
-- ==========================================
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)

  use("wbthomason/packer.nvim") -- Package manager

  -- Quarto
  use("quarto-dev/quarto-nvim")
  use("jmbuhr/nvim-config")
  use("jmbuhr/otter.nvim")

  -- UI/Theme
  use("rebelot/kanagawa.nvim")
  use("ellisonleao/gruvbox.nvim")
  use("catppuccin/nvim")
  use("nvim-lua/plenary.nvim")

  -- LSP & Tools (Mason)
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("WhoIsSethDaniel/mason-tool-installer.nvim")

  ----- Autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  -- Lua
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  -- Interactive repls over vim (iron.vim)
  use("Vigemus/iron.nvim") 
  -- HTML
  use("mattn/emmet-vim")

  -- Fuzzy Finder
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-fzf-native.nvim", { run = "make" })

  -- Git & Surround
  use("lewis6991/gitsigns.nvim")
  use("kylechui/nvim-surround")

  -- Statusline (Powerline enabled below)
  use("nvim-lualine/lualine.nvim")

  -- Syntax & Editing
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  use("windwp/nvim-autopairs")
  -- use("numToStr/Comment.nvim")
  use("tpope/vim-commentary")
  use("nvim-neotest/nvim-nio")

  -- rust
  use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
        }
    }
  use("rouge8/neotest-rust")

  use {
    "alexpasmantier/tv.nvim",
    config = function()
      require("tv").setup{
        -- your config here (see Configuration section below)
      }
    end,
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Configure tab for emmet-vim autocomplete if editing html
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()

    require("cmp").setup.buffer({ enabled = false })
    vim.keymap.set('i', '<tab>', '<C-y>,e', { buffer = true })

  end,
})

-- ==========================================
-- LSP CONFIGURATION
-- ==========================================
-- local lspconfig = require("lspconfig")
local mason = require("mason")
-- local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")



-- ==========================================
-- TREESITTER
-- ==========================================
require("nvim-treesitter").setup({
  ensure_installed = { "lua", "python", "javascript", "typescript", "rust" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
-- OTHER RUST STUFF
vim.lsp.enable("rust_analyzer")
require("neotest").setup({
  adapters = {
    require("neotest-rust"),
  },
})

-- ==========================================
-- COMPLETION (CMP)
-- ==========================================
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

-- ==========================================
-- GIT & EDITING TOOLS
-- ==========================================
require("gitsigns").setup()
require("nvim-autopairs").setup()


-- ==========================================
-- STATUSLINE (POWERLINE STYLE)
-- ==========================================
require("lualine").setup({
  options = {
    -- theme = "catppuccin",
    -- Powerline separators (requires Nerd Font)
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
})

-- ==========================================
-- THEME
-- ==========================================
-- vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("tokyonight-moon")
-- vim.g.everforest_background = "soft"
vim.cmd.colorscheme("everforest")
vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")

vim.keymap.set("n", ";", ":", { desc = "Remap ; to :" })

map("n", "ys", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
map("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change Surround" })
map("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete Surround" })

map("x", "ys", "<Plug>(nvim-surround-visual)", { desc = "Surround Visual" })


-- Disable cmp for writing/text filetypes
local writing_ft = {
  "markdown",
  "quarto",   -- .qmd files
  "tex",      -- .tex, .bib
  "plaintex",
  "rst",      -- ReStructuredText
  "org",      -- Org mode
  "asciidoc",
  "text",     -- Plain .txt
  "gitcommit",
  "gitmessage"
}

for _, ft in ipairs(writing_ft) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      require("cmp").setup.buffer({ enabled = false })

      vim.opt_local.textwidth = 80
      vim.opt_local.wrapmargin = 0
      vim.opt_local.breakindent = true
      -- vim.opt_local.formatoptions:append("a") -- Auto-wrap while typing
      vim.opt_local.formatoptions = "t" -- auto-wrap text ("t") only; nothing else
    end,
  })
end

map("i", "<M-BS>", "<C-o>dB", { desc = "Delete word backward" })
map("i", "<C-s>", "<cmd>w<cr>", { desc = "Save in insert mode" })


local iron = require("iron.core")
local view = require("iron.view")
local common = require("iron.fts.common")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      },
      python = {
        command = { "python3" },  -- or { "ipython", "--no-autoindent" }
        format = common.bracketed_paste_python,
        block_dividers = { "# %%", "#%%" },
        env = {PYTHON_BASIC_REPL = "1"} --this is needed for python3.13 and up.
      }
    },
    -- set the file type of the newly created repl to ft
    -- bufnr is the buffer id of the REPL and ft is the filetype of the 
    -- language being used for the REPL. 
    repl_filetype = function(bufnr, ft)
      return ft
      -- or return a string name such as the following
      -- return "iron"
    end,
    -- Send selections to the DAP repl if an nvim-dap session is running.
    dap_integration = true,
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = view.bottom(40),

    -- repl_open_cmd can also be an array-style table so that multiple 
    -- repl_open_commands can be given.
    -- When repl_open_cmd is given as a table, the first command given will
    -- be the command that `IronRepl` initially toggles.
    -- Moreover, when repl_open_cmd is a table, each key will automatically
    -- be available as a keymap (see `keymaps` below) with the names 
    -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
    -- For example,
    -- 
    -- repl_open_cmd = {
    --   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
    --   view.split.rightbelow("%25")  -- cmd_2: open a repl below
    -- }

  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    toggle_repl = "<space>rr", -- toggles the repl open and closed.
    -- If repl_open_command is a table as above, then the following keymaps are
    -- available
    -- toggle_repl_with_cmd_1 = "<space>rv",
    -- toggle_repl_with_cmd_2 = "<space>rh",
    restart_repl = "<space>rR", -- calls `IronRestart` to restart the repl
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_paragraph = "<space>sp",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    send_code_block = "<space>sb",
    send_code_block_and_move = "<space>sn",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

vim.api.nvim_set_hl(0, "WinSeparator", {
  fg = "#555555",
  bg = "NONE"
})

vim.opt.fillchars = {
  vert = "│",
  horiz = "─",
}

require('quarto').setup{
  debug = false,
  closePreviewOnExit = true,
  lspFeatures = {
    enabled = true,
    chunks = "curly",
    languages = { "r", "python", "julia", "bash", "html" },
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" },
    },
    completion = {
      enabled = true,
    },
  },
  codeRunner = {
    enabled = true,
    default_method = "iron", -- "molten", "slime", "iron" or <function>
    ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
    -- Takes precedence over `default_method`
    never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
  },
}

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#888888", bg = "#222222" })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#555555", bg = "#222222" })
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", {
      fg = "#555555",
      bg = "NONE",
    })
  end,
})
