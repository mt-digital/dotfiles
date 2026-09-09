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
-- vim.cmd.colorscheme("everforest")
vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")

-- Set background to be black in active window, charcoal in others.
vim.api.nvim_set_hl(0, "Normal",   { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#0f0f0f" }) -- charcoal
