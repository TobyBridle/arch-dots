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
{{ #if (eq_string theme-name "gruvbox") }}
local colorschemes = {
  "ellisonleao/gruvbox.nvim",
}
{{ /if }}

return {
  {{ #if (eq_string theme-name "oxocarbon") }}
  build_colorscheme_spec(colorschemes),
  {{ /if }}
  {{ #if (eq_string theme-name "gruvbox") }}
  build_colorscheme_spec(colorschemes),
  {{ /if }}
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "{{theme-name}}",
    },
    config = function()
        vim.cmd [[ colorscheme {{theme-name }}]]
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        normal["bg"] = None
        vim.api.nvim_set_hl(0, "normal", normal)
    end
  },
}
