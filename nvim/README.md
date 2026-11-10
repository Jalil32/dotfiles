# Neovim Configuration

A modern, minimal Neovim configuration focused on developer productivity with LSP, fuzzy finding, and efficient navigation.

## Features

- **LSP Support** - Built-in language server support for Go, Python, TypeScript, Lua, and Biome
- **Auto-formatting** - Format on save for all supported languages
- **Fuzzy Finding** - Fast file and text search with Telescope and FZF
- **Quick Navigation** - Harpoon for lightning-fast file switching
- **Smart Completion** - nvim-cmp with LSP, buffer, path, and snippet sources
- **Git Integration** - Gitsigns and Fugitive for Git operations
- **Syntax Highlighting** - TreeSitter for accurate syntax highlighting
- **Transparent Background** - Clean, transparent UI that works with terminal themes
- **Minimal UI** - Focused editing experience with lualine status bar

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- ripgrep (for Telescope live grep)
- Node.js (for some LSP servers)
- CMake (for telescope-fzf-native)

## Installation

1. Backup your existing Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. Clone this configuration:
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. Launch Neovim:
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

## Plugins

### Core
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager

### LSP & Completion
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP server installer
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)** - Bridge between mason and lspconfig
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine
- **[cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)** - LSP completion source
- **[cmp-buffer](https://github.com/hrsh7th/cmp-buffer)** - Buffer completion source
- **[cmp-path](https://github.com/hrsh7th/cmp-path)** - Path completion source
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
- **[cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)** - Snippet completion source

### Navigation & Search
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)** - FZF sorter for Telescope
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation

### Git
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)** - Git commands

### Editing
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto close brackets
- **[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)** - Auto close HTML tags
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Easy commenting

### UI
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - Color scheme
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Status line
- **[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)** - File icons

## Command Cheatsheet

Leader key: `Space`

### File Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<leader>pv` | Normal | Open file explorer (netrw) |
| `<leader>pf` | Normal | Find files (Telescope) |
| `<C-p>` | Normal | Git files (Telescope) |
| `<leader>ps` | Normal | Grep search (Telescope) |
| `<A-6>` | Normal | Previous buffer |
| `<C-6>` | Normal | Alternate buffer (toggle last two) |

### Harpoon (Quick File Marks)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>a` | Normal | Add current file to harpoon |
| `<C-e>` | Normal | Toggle harpoon quick menu |
| `<C-u>` | Normal | Jump to harpoon file 1 |
| `<C-i>` | Normal | Jump to harpoon file 2 |
| `<C-o>` | Normal | Jump to harpoon file 3 |

### LSP (Language Server)
| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Show references |
| `K` | Normal | Hover documentation |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |
| `<leader>d` | Normal | Show diagnostics (floating window) |

### Code Completion
| Key | Mode | Action |
|-----|------|--------|
| `<C-Space>` | Insert | Trigger completion menu |
| `<C-n>` | Insert | Next completion item |
| `<C-p>` | Insert | Previous completion item |
| `<C-y>` | Insert | Confirm/accept completion |

### Editing
| Key | Mode | Action |
|-----|------|--------|
| `gcc` | Normal | Toggle comment on current line |
| `gc` | Visual | Toggle comment on selected lines |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |

### Git
| Key | Mode | Action |
|-----|------|--------|
| `<leader>gs` | Normal | Git status (Fugitive) |
| `<leader>gb` | Normal | Git blame |
| `:Git` | Command | Run git commands |
| `:Gread` | Command | Checkout current file from git |
| `:Gwrite` | Command | Stage current file |
| `:Gdiff` | Command | Git diff |

### Auto-Formatting
| Trigger | Action |
|---------|--------|
| Save file | Automatically formats on every save (BufWritePre) |

## LSP Servers

The following language servers are automatically installed and configured:

- **gopls** - Go
- **pyright** - Python
- **ts_ls** - TypeScript/JavaScript
- **lua_ls** - Lua
- **biome** - JavaScript/TypeScript toolchain

Auto-formatting is enabled on save for all languages.

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json             # Plugin version lock file
└── lua/
    ├── config/
    │   ├── lazy.lua           # Lazy.nvim setup
    │   ├── options.lua        # Neovim options
    │   └── keymaps.lua        # Global keymaps
    └── plugins/
        ├── autopairs.lua      # Auto-pairs config
        ├── autotag.lua        # Auto-tag config
        ├── cmp.lua            # Completion config
        ├── colorscheme.lua    # Theme config
        ├── comment.lua        # Comment plugin config
        ├── fugitive.lua       # Git config
        ├── gitsigns.lua       # Git signs config
        ├── harpoon.lua        # Harpoon config
        ├── lsp.lua            # LSP config
        ├── lualine.lua        # Status line config
        ├── telescope.lua      # Fuzzy finder config
        └── treesitter.lua     # Syntax highlighting config
```

## Editor Settings

- **Line Numbers**: Enabled with relative numbers
- **Indentation**: Tabs (4 spaces width)
- **Search**: Case-insensitive with smart case
- **Scrolling**: 20 lines vertical offset, 8 columns horizontal offset
- **Clipboard**: Synced with system clipboard
- **Split Behavior**: New splits open below and to the right
- **Swap Files**: Disabled
- **Undo**: Persistent undo enabled
- **Background**: Transparent for all UI elements

## Customization

### Adding a New LSP Server

Edit `lua/plugins/lsp.lua` and add the server to the `ensure_installed` table and enable it:

```lua
ensure_installed = { "gopls", "pyright", "ts_ls", "lua_ls", "biome", "your_server" }
-- ...
vim.lsp.enable({ "gopls", "pyright", "ts_ls", "lua_ls", "biome", "your_server" })
```

### Changing the Color Scheme

Edit `lua/plugins/colorscheme.lua` and change the plugin or colorscheme name.

### Adding Custom Keymaps

Add your keymaps to `lua/config/keymaps.lua` using:

```lua
vim.keymap.set("mode", "keys", "action", { noremap = true, silent = true })
```

## License

Feel free to use and modify this configuration for your own needs.
