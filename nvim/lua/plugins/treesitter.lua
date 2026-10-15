return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "c",
        "cpp",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
      },

      auto_install = true,

      highlight = { enable = true },
      indent    = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = "<C-space>",
          node_incremental  = "<C-space>",
          scope_incremental = false,
          node_decremental  = "<bs>",
        },
      },
    },
  },
}
