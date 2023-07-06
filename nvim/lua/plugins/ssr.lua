return {
  "cshuaimin/ssr.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<leader>sR",
      function()
        require("ssr").open()
      end,
      mode = { "n", "x" },
      desc = "Structural Replace",
    },
  },
}
