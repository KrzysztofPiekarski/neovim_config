# 🚀 Neovim IDE Configuration

**Professional Neovim IDE configuration** with advanced features, modern UI, and full programming support.

## ✨ **Main Features**

- 🎨 **Modern UI** - Tokyo Night theme, Lualine, Bufferline, Alpha dashboard
- 🔧 **LSP (Language Server Protocol)** - Intelligent suggestions and diagnostics
- 📁 **File Management** - NvimTree, Telescope fuzzy finder
- 🎯 **Code Navigation** - Go to definition, references, implementations
- 🚀 **Performance** - Lazy loading, performance optimizations
- 🎭 **Git Integration** - Gitsigns, fugitive
- 📝 **Code Editing** - Autopairs, surround, comment, autotag

## 🏗️ **Project Structure**

```
lua/krispi/
├── core/                    # Basic configuration
│   ├── init.lua           # Initialization
│   ├── options.lua        # Neovim options
│   ├── keymaps.lua        # Global keymaps
│   └── leader-mappings.lua # Leader keymaps
├── plugins/                # Plugin configuration
│   ├── init.lua           # Lazy.nvim setup
│   ├── ui.lua             # UI plugins (Noice, Gitsigns, etc.)
│   ├── colorscheme.lua    # Color themes
│   ├── lualine.lua        # Statusline
│   ├── bufferline.lua     # Tabline/buffers
│   ├── alpha.lua          # Dashboard
│   ├── nvim-tree.lua      # File explorer
│   ├── telescope.lua      # Fuzzy finder
│   ├── nvim-cmp.lua       # Completion
│   ├── treesitter.lua     # Syntax highlighting
│   ├── lsp/               # LSP configuration
│   │   ├── mason.lua      # Package manager
│   │   └── lspconfig.lua  # LSP servers
│   └── ...                # Other plugins
```

## 🎨 **UI/UX Features**

### **Colorscheme & Themes**
- **Tokyo Night** - Main theme with custom highlights
- **Alternative themes** - Catppuccin, Nord, Gruvbox
- **Custom highlight groups** - Consistent colors for all elements

### **Statusline & Tabline**
- **Lualine** - Modern statusline with:
  - File icons and git status
  - LSP status and diagnostics
  - Custom theme and colors
- **Bufferline** - Buffer management with:
  - Tab indicators and separators
  - Git integration and diagnostics
  - Custom styling

### **Dashboard & Navigation**
- **Alpha** - Custom dashboard with:
  - Neovim logo ASCII art
  - Quick actions (New file, Find, Neotree)
  - Plugin count and system info
- **NvimTree** - File explorer with:
  - Git integration and diagnostics
  - Custom keymaps and actions
  - File icons and sorting

### **Enhanced UI Components**
- **Noice** - Better cmdline and notifications
- **Gitsigns** - Git status in gutter
- **Indent-blankline** - Indent guides
- **Barbecue** - Winbar with breadcrumbs
- **Cursorline** - Highlight current line/word

## 🔧 **LSP & Development Tools**

### **Language Servers**
- **Lua** - `lua-language-server` ✅
- **Python** - `pyright` + `ruff-lsp` ✅
- **C/C++** - `clangd` ✅
- **JavaScript/TypeScript** - `eslint-lsp` ✅
- **JSON** - `json-lsp` ✅
- **YAML** - `yaml-language-server` ✅
- **Tailwind CSS** - `tailwindcss-language-server` ✅

### **Code Quality Tools**
- **Ruff** - Fast Python linter/formatter
- **ESLint** - JavaScript/TypeScript linting
- **Stylua** - Lua formatter
- **Clang-format** - C/C++ formatter
- **Prettier** - Code formatter

### **LSP Features**
- **Auto-completion** - Intelligent suggestions
- **Diagnostics** - Real-time errors and warnings
- **Code actions** - Refactoring and fixes
- **Go to definition** - Code navigation
- **Hover documentation** - Documentation under cursor

## ⌨️ **Keymaps**

### **Leader Key (`<space>`)**
- **File operations** - `<leader>f` (find, grep, recent)
- **Buffer management** - `<leader>b` (buffers, close, next)
- **LSP actions** - `<leader>ca` (code actions), `<leader>rn` (rename)
- **Git operations** - `<leader>g` (git status, blame, diff)
- **Telescope** - `<leader>ff` (find files), `<leader>fg` (live grep)

### **LSP Keymaps**
- **Navigation** - `gd` (definition), `gD` (declaration), `gi` (implementation)
- **References** - `gR` (references), `K` (hover), `<C-k>` (signature help)
- **Diagnostics** - `[d`/`]d` (prev/next), `<leader>d` (line diagnostics)

### **File Explorer**
- **Toggle** - `<leader>ee` (NvimTree)
- **Find file** - `<leader>ef` (find in explorer)
- **Navigation** - `l` (open), `h` (close), `v` (vertical split)

## 🚀 **Performance Optimizations**

### **Lazy Loading**
- **Event-based** - Plugins load when needed
- **Priority system** - Important plugins load first
- **Dependencies** - Proper loading order

### **Neovim Options**
- **Global statusline** - `laststatus = 3`
- **Cursor highlighting** - `cursorline = true`
- **Performance** - `updatetime = 300`, `timeoutlen = 1000`

## 🔧 **Recent Fixes & Improvements**

### **LSP & Diagnostics** ✅
- **Fixed Mason errors** - removed non-existent packages
- **Corrected package names** - `eslint-lsp`, `ruff-lsp`
- **Removed duplicates** - gitsigns in one place
- **Stable configuration** - no errors or conflicts

### **UI & Visual** ✅
- **Alpha dashboard** - background and colors fixed
- **Lualine** - simplified configuration, debug prints
- **Bufferline** - removed problematic options
- **Colorscheme** - custom highlights for Alpha

### **Plugin Conflicts** ✅
- **Removed problematic plugins** - lspsaga, nvim-treesitter-textobjects
- **Simplified configurations** - no deprecated options
- **Proper loading order** - Mason before LSP

## 📋 **Installation & Setup**

### **Requirements**
- **Neovim** 0.9.0+
- **Git** - for plugin installation
- **Node.js** - for some LSP servers
- **Python** - for Python development

### **Quick Start**
1. **Clone repository**:
```bash
   git clone <repo-url> ~/.config/nvim
```

2. **Install dependencies**:
```bash
   # Python packages
   pip install ruff mypy
   
   # Node.js packages (optional)
   npm install -g prettier eslint
   ```

3. **Launch Neovim**:
```bash
   nvim
   ```

4. **Wait for setup**:
   - Mason will install LSP servers
   - Plugins will load automatically
   - Alpha dashboard will appear

### **First Time Setup**
- **Mason** will automatically install needed tools
- **LSP servers** will be available after first launch
- **Keymaps** will be active immediately

## 🎯 **Usage Examples**

### **File Navigation**
```vim
<leader>ff          " Find files
<leader>fg          " Live grep
<leader>ee          " Toggle file explorer
<leader>fb          " Find in buffers
```

### **Code Development**
```vim
gd                  " Go to definition
K                   " Show documentation
<leader>ca          " Code actions
<leader>rn          " Rename symbol
```

### **Git Operations**
```vim
<leader>gs          " Git status
<leader>gb          " Git blame
<leader>gd          " Git diff
```

## 🔍 **Troubleshooting**

### **Common Issues**
- **LSP not working** - Check `:LspInfo`, `:checkhealth`
- **Plugins not loading** - Check `:Lazy status`
- **Performance issues** - Check `:profile start`

### **Debug Commands**
```vim
:checkhealth        " System health check
:LspInfo            " LSP server status
:Lazy status        " Plugin status
:Mason              " Package manager
```

### **Reset Configuration**
```bash
# Remove all plugins
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/share/nvim/mason

# Restart Neovim
nvim
```

## 📚 **Documentation & Resources**

### **Plugin Documentation**
- **Lazy.nvim** - Plugin manager
- **Mason** - Package manager
- **LSP** - Language Server Protocol
- **Treesitter** - Syntax highlighting

### **Neovim Resources**
- **Official docs** - `:help`
- **LSP docs** - `:help lsp`
- **Keymaps** - `:help keymap`

## 🤝 **Contributing**

### **Development**
- **Fork repository**
- **Create feature branch**
- **Test changes**
- **Submit pull request**

### **Issues**
- **Bug reports** - Describe problem in detail
- **Feature requests** - Explain the need
- **Performance issues** - Include profiles

## 📄 **License**

MIT License - see [LICENSE](LICENSE) file.

## 🙏 **Acknowledgments**

- **Neovim community** - for the great tool
- **Plugin authors** - for wonderful plugins
- **Contributors** - for help in development

---

**Made with ❤️ for the Neovim community**

*Last updated: 22.08.2025*