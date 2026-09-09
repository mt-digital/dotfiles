vim.keymap.set(
  "n",
  "<C-r>",
  ":w<CR>:!cargo run<CR>",
  { silent = true, buffer = true }
)
