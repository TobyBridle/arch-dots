local function build_colorscheme_spec(colorschemes)
  return vim.tbl_map(function(colorscheme)
    local fqn = type(colorscheme) == "string" and colorscheme or colorscheme[1]
    local spec =
      vim.tbl_extend("force", { fqn, event = "VeryLazy" }, type(colorscheme) == "table" and colorscheme or {})
    return spec
  end, colorschemes)
end

{{ #if (eq_string theme-name "oxocarbon") }}
local colorschemes = {
  "nyoom-engineering/oxocarbon.nvim",
  "sindrets/oxocarbon-lua.nvim",
}
{{ /if }}

return {
  {{ #if (eq_string theme-name "oxocarbon") }}
  build_colorscheme_spec(colorschemes),
  {{ /if }}

  -- Effortlessly sync the terminal background with Neovim.
  -- As a side effect, get effortless transparency across color schemes!
  {
    "typicode/bg.nvim",
    lazy = false,
    cond = function()
      return os.getenv("NVIM_COLORSYNC") == nil
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "{{theme-name}}",
    },
  },
}
