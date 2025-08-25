# 🚀 Neovim IDE Configuration

**Profesjonalna konfiguracja Neovim jako IDE** z zaawansowanymi funkcjami, nowoczesnym UI i pełnym wsparciem dla programowania.

## ✨ **Główne funkcje**

- 🎨 **Nowoczesny UI** - Tokyo Night theme, Lualine, Bufferline, Alpha dashboard
- 🔧 **LSP (Language Server Protocol)** - Inteligentne podpowiedzi i diagnostyka
- 📁 **File Management** - NvimTree, Telescope fuzzy finder
- 🎯 **Code Navigation** - Go to definition, references, implementations
- 🚀 **Performance** - Lazy loading, optymalizacje wydajności
- 🎭 **Git Integration** - Gitsigns, fugitive
- 📝 **Code Editing** - Autopairs, surround, comment, autotag

## 🏗️ **Struktura projektu**

```
lua/krispi/
├── core/                    # Podstawowa konfiguracja
│   ├── init.lua           # Inicjalizacja
│   ├── options.lua        # Opcje Neovim
│   ├── keymaps.lua        # Globalne keymapy
│   └── leader-mappings.lua # Leader keymapy
├── plugins/                # Konfiguracja pluginów
│   ├── init.lua           # Lazy.nvim setup
│   ├── ui.lua             # UI plugins (Noice, Gitsigns, etc.)
│   ├── colorscheme.lua    # Motywy kolorystyczne
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
│   └── ...                # Inne pluginy
```

## 🎨 **UI/UX Features**

### **Colorscheme & Themes**
- **Tokyo Night** - Główny motyw z custom highlights
- **Alternatywne motywy** - Catppuccin, Nord, Gruvbox
- **Custom highlight groups** - Spójne kolory dla wszystkich elementów

### **Statusline & Tabline**
- **Lualine** - Nowoczesny statusline z:
  - File icons i git status
  - LSP status i diagnostics
  - Custom theme i kolory
- **Bufferline** - Zarządzanie buforami z:
  - Tab indicators i separators
  - Git integration i diagnostics
  - Custom styling

### **Dashboard & Navigation**
- **Alpha** - Custom dashboard z:
  - Neovim logo ASCII art
  - Szybkie akcje (New file, Find, Neotree)
  - Plugin count i system info
- **NvimTree** - File explorer z:
  - Git integration i diagnostics
  - Custom keymaps i actions
  - File icons i sorting

### **Enhanced UI Components**
- **Noice** - Lepsze cmdline i notifications
- **Gitsigns** - Git status w gutter
- **Indent-blankline** - Indent guides
- **Barbecue** - Winbar z breadcrumbs
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
- **Auto-completion** - Inteligentne podpowiedzi
- **Diagnostics** - Błędy i ostrzeżenia w czasie rzeczywistym
- **Code actions** - Refactoring i poprawki
- **Go to definition** - Nawigacja po kodzie
- **Hover documentation** - Dokumentacja pod kursorem

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
- **Event-based** - Plugins ładują się gdy są potrzebne
- **Priority system** - Ważne pluginy ładują się pierwsze
- **Dependencies** - Prawidłowa kolejność ładowania

### **Neovim Options**
- **Global statusline** - `laststatus = 3`
- **Cursor highlighting** - `cursorline = true`
- **Performance** - `updatetime = 300`, `timeoutlen = 1000`

## 🔧 **Recent Fixes & Improvements**

### **LSP & Diagnostics** ✅
- **Naprawione błędy Mason** - usunięte nieistniejące pakiety
- **Poprawione nazwy pakietów** - `eslint-lsp`, `ruff-lsp`
- **Usunięte duplikaty** - gitsigns w jednym miejscu
- **Stabilna konfiguracja** - bez błędów i konfliktów

### **UI & Visual** ✅
- **Alpha dashboard** - tło i kolory naprawione
- **Lualine** - uproszczona konfiguracja, debug prints
- **Bufferline** - usunięte problematyczne opcje
- **Colorscheme** - custom highlights dla Alpha

### **Plugin Conflicts** ✅
- **Usunięte problematyczne pluginy** - lspsaga, nvim-treesitter-textobjects
- **Uproszczone konfiguracje** - bez deprecated opcji
- **Prawidłowa kolejność ładowania** - Mason przed LSP

## 📋 **Installation & Setup**

### **Requirements**
- **Neovim** 0.9.0+
- **Git** - do instalacji pluginów
- **Node.js** - dla niektórych LSP serwerów
- **Python** - dla Python development

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
   - Mason zainstaluje LSP serwery
   - Plugins załadują się automatycznie
   - Alpha dashboard się pojawi

### **First Time Setup**
- **Mason** automatycznie zainstaluje potrzebne narzędzia
- **LSP serwery** będą dostępne po pierwszym uruchomieniu
- **Keymaps** będą aktywne od razu

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
- **LSP not working** - Sprawdź `:LspInfo`, `:checkhealth`
- **Plugins not loading** - Sprawdź `:Lazy status`
- **Performance issues** - Sprawdź `:profile start`

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
- **Bug reports** - Opisz problem szczegółowo
- **Feature requests** - Wyjaśnij potrzebę
- **Performance issues** - Dołącz profile

## 📄 **License**

MIT License - zobacz [LICENSE](LICENSE) file.

## 🙏 **Acknowledgments**

- **Neovim community** - za świetne narzędzie
- **Plugin authors** - za wspaniałe pluginy
- **Contributors** - za pomoc w rozwoju

---

**Made with ❤️ for the Neovim community**

*Last updated: 22.08.2025*