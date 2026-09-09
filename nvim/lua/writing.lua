
vim.opt.spelllang = "en_us,pt_br,es_mx"

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



