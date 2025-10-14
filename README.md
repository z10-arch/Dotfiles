# https://github.com/air-verse/air -> Package used

## Multi-Cursor Plugin

VSCode-like multiple cursors for Neovim using [vim-visual-multi](https://github.com/mg979/vim-visual-multi).

### Installation

Plugin auto-loads from `lua/plugins/multicursor.lua`. Sync with:
```vim
:Lazy sync
```

### Quick Start

| Key | Action |
|-----|--------|
| `Ctrl+D` | Select next matching word |
| `Ctrl+Shift+L` | Select all matching words |
| `Ctrl+Click` | Add cursor at position |
| `Ctrl+Up/Down` | Add cursor above/below |

After selecting cursors, use normal Vim commands:
- `i` / `a` - Insert / Append
- `ciw` - Change word
- `dd` / `dw` - Delete
- `ESC` - Exit multi-cursor mode

### Examples

**Rename variable:**
```
1. Cursor on variable name
2. Ctrl+Shift+L (select all occurrences)
3. ciw (change word)
4. Type new name
5. ESC
```

**Edit multiple lines:**
```
1. Ctrl+Down to add cursors
2. I to insert at start
3. Type text
4. ESC
```

**Skip unwanted matches:**
- Press `q` to skip current match
- Press `Q` to remove cursor

For full documentation: `:help visual-multi`
