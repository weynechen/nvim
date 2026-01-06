
### what's in here

```
lsp + completion      telescope + neo-tree      rust/go/ts/c++
lazygit + diffview    ai (avante/codecompanion) remote dev (distant)
obsidian integration      discord presence
animations            smear cursor              a duck
```

---

### install

```sh
git clone git@github.com:weynechen/nvim.git ~/.config/nvim
nvim
```

lazy.nvim bootstraps itself. just open nvim and wait.

---

### requirements

| required | optional |
|----------|----------|
| neovim 0.11+ | lazygit |
| nerd font | distant cli |
| ripgrep, fd | |

---

### proxy
`init.lua` contains a proxy config for git operations. if you don't need it, remove lines 1-3.

---

### keybinds

leader is `space`. press it and wait for which-key.

| key | action |
|-----|--------|
| `ctrl+p` | find files |
| `ctrl+b` | toggle tree |
| `ctrl+`` | terminal |
| `space g` | git |
| `space D` | remote dev |
| `space o` | obsidian |

full list in `lua/config/keymaps.lua`

---

### structure

```
lua/
├── config/          options, keymaps
├── plugins/         lazy.nvim specs
├── neo-tree/        custom sources (distant)
```

---

