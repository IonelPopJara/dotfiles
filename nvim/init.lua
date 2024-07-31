vim.cmd("set expandtab")      -- Use spaces instead of tabs
vim.cmd("set tabstop=2")      -- Number of visual spaces per tab
vim.cmd("set softtabstop=2")  -- Number of spaces in tab when editing
vim.cmd("set shiftwidth=2")   -- Number of spaces to use for autoindenting

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- {
    --   "savq/melange-nvim",
    --   name = "melange",
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     vim.opt.termguicolors = true -- Enable 24-bit RGB colors
    --     vim.cmd.colorscheme("melange")
    --   end,
    -- },
    {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
        vim.o.background = "dark"
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_enable_italic = true
        vim.opt.termguicolors = true -- Enable 24-bit RGB colors
        vim.cmd.colorscheme("gruvbox-material")
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
          ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "elixir",
            "heex",
            "javascript",
            "html",
            "python",
            "java",
            "cpp",
            "c_sharp",
            "bash",
            "hlsl",
            "glsl"
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Setup telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

