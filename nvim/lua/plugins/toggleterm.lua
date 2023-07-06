return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      size = 20,
      hide_numbers = true, -- hide the number column in toggleterm buffers
      open_mapping = [[<c-\>]],
      start_in_insert = true,
      -- insert_mappings = true, -- whether or not the open mapping applies in insert mode
      -- persist_size = true,
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = "/usr/bin/zsh", -- change the default shell
      float_opts = { border = "curved" },
    })
  end,
}
