--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,               -- Disable setting background
    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,              -- Non focused panes set to alternative background
    styles = {                         -- Style to be applied to different syntax groups
      functions = "italic",
      operators = "NONE",
      strings = "italic",
      comments = "italic",
      keywords = "NONE",
      conditionals = "NONE",
      constants = "NONE",
      numbers = 'NONE',
      types = "bold",
      variables = "italic",

    },
    inverse = { -- Inverse highlight for different types
      match_paren = true,
      visual = false,
      search = true,
    },
    modules = { -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

require('kanagawa').setup({
  compile = true,   -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = { italic = true },
  keywordStyle = { italic = true, underline = true },
  statementStyle = { bold = true },
  typeStyle = { bold = true },
  transparent = false,   -- do not set background color
  dimInactive = true,    -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      PmenuThumb = { bg = theme.ui.bg_p2 },
    }
  end,
  theme = "wave",  -- Load "wave" theme when 'background' option is not set
  background = {   -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus"
  },
})

require("catppuccin").setup({
  flavour = "latte", -- latte, frappe, macchiato, mocha
  background = {     -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true, -- disables setting the background color.
  show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
  term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false,             -- dims the background color of inactive window
    shade = "light",
    percentage = 0.15,           -- percentage of the shade to apply to the inactive window
  },
  no_italic = false,             -- Force no italic
  no_bold = false,               -- Force no bold
  no_underline = false,          -- Force no underline
  styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" },     -- Change the style of comments
    conditionals = { "bold" },
    loops = { "bold" },
    functions = { "bold", "italic" },
    keywords = { "bold" },
    strings = { "italic" },
    variables = { "italic" },
    numbers = { "bold" },
    booleans = { "underline" },
    properties = { "italic" },
    types = { "bold" },
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})
lvim.builtin.dap.active = true

-- Python DAP
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "kanagawa-wave"
vim.opt.termguicolors = true
-- lvim.lsp.diagnostics.virtual_text = false
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":SaveSession<CR>"
lvim.keys.normal_mode["<M-1>"] = false
lvim.keys.normal_mode["<S-t>"] = ":ToggleTerm direction=horizontal size=12<cr>"
lvim.keys.normal_mode["<Space>t"] = ":ToggleTerm<cr>"
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"
vim.opt.relativenumber = true -- set relative numbered lines
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-f>"] = ":SearchSession<CR>"
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "cmake"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    name = "black"
  },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--single-quote", "--tab-width=2", "--print-width", "88" },
    { '--line-width', '88' },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
  {
    command = "clang-format",
    filetypes = { "java" },
    extra_args = { "--style", "Google" },
  },
  {
    name = "rustfmt"
  }
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- {
  --   command = "flake8",
  --   filetypes = { "python" },
  --   extra_args = {'--max-line-length', '88'},
  -- },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  },
  {
    command = 'eslint_d',
    filetypes = { 'typescript', 'typescriptreact' },
    extra_args = { '--cache' },
  },
}

-- Additional Plugins
lvim.plugins = {
  {
    "EdenEast/nightfox.nvim",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
    end
  },
  {
    'rmagatti/session-lens',
    dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('session-lens').setup({ --[[your custom config--]] })
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin"
  },
  {
    "folke/tokyonight.nvim"
  },
  {
    "sainnhe/everforest"
  },
  {
    "mfussenegger/nvim-dap-python"
  },
  {
    "nvim-neotest/neotest"
  },
  {
    "nvim-neotest/neotest-python"
  },
  {
    "ChristianChiarulli/swenv.nvim"
  },
  {
    "stevearc/dressing.nvim"
  },
  {
    "OmniSharp/omnisharp-vim",
  },
  {
    "rebelot/kanagawa.nvim"
  },
  { "nvim-neotest/nvim-nio" },
  -- { "mfussenegger/nvim-jdtls" }
}
