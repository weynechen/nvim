# Neovim 配置文档

## 配置概览

这是一个基于 Neovim 0.11+ 的现代化配置，采用 VS Code/Cursor 风格的键位绑定，提供完整的开发环境支持。

- **主题**: Gruvbox (透明模式)
- **包管理器**: lazy.nvim
- **Leader 键**: Space (` `)

---

## 插件列表

### 1. 核心与主题
| 插件 | 功能描述 |
|------|---------|
| lazy.nvim | 插件管理器 |
| gruvbox.nvim | Gruvbox 主题（透明背景） |
| nvim-web-devicons | 文件图标 |

### 2. UI 增强
| 插件 | 功能描述 |
|------|---------|
| bufferline.nvim | VS Code 风格标签栏 |
| lualine.nvim | 美化的状态栏 |
| which-key.nvim | 快捷键提示（helix preset） |
| noice.nvim | 命令行、消息、弹窗美化 |
| nvim-notify | 漂亮的通知系统 |
| alpha-nvim | 启动画面（sleepy cat ASCII） |
| dressing.nvim | 美化的 input/select 界面 |
| indent-blankline.nvim | 缩进指示线 |
| rainbow-delimiters.nvim | 彩虹括号 |
| smear-cursor.nvim | 光标拖尾动画 |
| mini.animate | 平滑动画（窗口开关） |
| todo-comments.nvim | TODO 注释高亮 |
| nvim-colorizer.lua | 颜色代码预览 |
| twilight.nvim | 聚焦模式（变暗非活动代码） |

### 3. 编辑器功能
| 插件 | 功能描述 |
|------|---------|
| nvim-neo-tree/neo-tree.nvim | 文件浏览器（支持远程） |
| oil.nvim | 像 buffer 一样编辑文件系统 |
| toggleterm.nvim | 悬浮终端 |
| nvim-autopairs | 自动配对括号、引号 |
| Comment.nvim | 智能注释 |
| nvim-surround | 快速添加/删除包围符号 |
| gitsigns.nvim | Git 变更标记 |
| render-markdown.nvim | Markdown 渲染增强（含自定义 todo 状态） |

### 4. 导航与搜索
| 插件 | 功能描述 |
|------|---------|
| nvim-telescope/telescope.nvim | 模糊查找器（Ctrl+P 风格） |
| telescope-fzf-native.nvim | FZF 加速查找 |
| folke/flash.nvim | 快速跳转（类似 EasyMotion） |
| ThePrimeagen/harpoon | 快速文件切换 |

### 5. LSP 与代码补全
| 插件 | 功能描述 |
|------|---------|
| nvim-lspconfig | LSP 客户端配置 |
| mason.nvim | LSP 服务器、格式化器、Linter 管理器 |
| mason-lspconfig.nvim | Mason 和 LSPconfig 桥接 |
| mason-nvim-dap.nvim | Mason 和 DAP 桥接 |
| nvim-cmp | 代码补全引擎 |
| cmp-nvim-lsp | LSP 补全源 |
| cmp-buffer | buffer 补全源 |
| cmp-path | 路径补全源 |
| cmp-cmdline | 命令行补全 |
| LuaSnip | 代码片段引擎 |
| cmp_luasnip | LuaSnip 补全源 |
| friendly-snippets | 代码片段集合 |
| lspkind.nvim | VS Code 风格补全图标 |
| none-ls.nvim | 格式化和 Linter（null-ls 后继） |
| j-hui/fidget.nvim | LSP 进度指示器 |
| folke/trouble.nvim | 诊断、TODO、quickfix 漂亮列表 |

### 6. 调试 (DAP)
| 插件 | 功能描述 |
|------|---------|
| nvim-dap | DAP 核心客户端 |
| nvim-dap-ui | DAP UI 界面 |
| nvim-dap-virtual-text | 虚拟文本显示变量值 |
| nvim-nio | 异步 IO 库 |

### 7. Git 工具
| 插件 | 功能描述 |
|------|---------|
| lazygit.nvim | LazyGit 集成 |
| diffview.nvim | VS Code 风格 diff 视图 |
| octo.nvim | GitHub Issues/PRs 管理 |
| git-blame.nvim | Git blame 内联显示 |

### 8. AI 辅助
| 插件 | 功能描述 |
|------|---------|
| avante.nvim | AI 编码助手（Cursor 风格） |
| codecompanion.nvim | AI 聊天界面 |
| img-clip.nvim | 图片粘贴支持（用于 AI 对话） |

### 9. 笔记与知识管理
| 插件 | 功能描述 |
|------|---------|
| obsidian.nvim | Obsidian vault 集成 |
| kanban.nvim | 看板插件 |

### 10. 语言特定支持
| 插件 | 语言 | 功能描述 |
|------|------|---------|
| rustaceanvim | Rust | 完整 Rust 开发支持 |
| crates.nvim | Rust | Cargo.toml 依赖管理 |
| go.nvim | Go | Go 工具链集成 |
| typescript-tools.nvim | TS/JS | TypeScript 工具（比 tsserver 快） |
| clangd_extensions.nvim | C/C++ | clangd 扩展 |
| cmake-tools.nvim | C/C++ | CMake 工具 |

### 11. 生产力工具
| 插件 | 功能描述 |
|------|---------|
| nvim-spectre | 跨文件搜索替换 |
| persistence.nvim | 会话管理 |
| undotree | 撤销树可视化 |
| nvim-bqf | 更好的 quickfix 列表 |
| folke/snacks.nvim | 一组 QoL 插件（zen 模式、scratch、gitbrowse 等） |

### 12. 远程开发
| 插件 | 功能描述 |
|------|---------|
| distant.nvim | 远程开发支持（SSH） |

### 13. 娱乐
| 插件 | 功能描述 |
|------|---------|
| duck.nvim | 屏幕上的鸭子 |
| drop.nvim | 下落字符屏保 |
| cellular-automaton.nvim | 元胞自动机（生命游戏、代码雨） |
| zone.nvim | 屏保工具 |

---

## 快捷键

### 文件操作 (Ctrl+)
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+S` | 保存文件 |
| `Ctrl+Q` | 退出 |
| `Ctrl+N` | 新建文件 |
| `Ctrl+W` | 关闭 buffer |

### 导航 (Ctrl+)
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+P` | 快速打开文件 (Telescope) |
| `Ctrl+Shift+P` | 命令面板 |
| `Ctrl+Shift+F` | 在文件中搜索 |
| `Ctrl+Shift+E` | 文件浏览器 (Oil) |
| `Ctrl+B` | 切换侧边栏 (Neo-tree) |
| `Ctrl+\`` | 切换终端 |
| `Ctrl+G` | 跳转到符号 |

### 编辑 (Ctrl+)
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+F` | 在文件中查找 |
| `Ctrl+H` | 查找替换 |
| `Ctrl+Z` | 撤销 |
| `Ctrl+Shift+Z` | 重做 |
| `Ctrl+/` | 切换注释 |
| `Ctrl+A` | 全选 |
| `Ctrl+D` | 选择单词 |

### 行操作 (Alt+)
| 快捷键 | 功能 |
|--------|------|
| `Alt+↑/↓` | 移动行上/下 |
| `Alt+Shift+↑/↓` | 复制行上/下 |

### 窗口导航
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+H` | 左窗口 |
| `Ctrl+J` | 下窗口 |
| `Ctrl+K` | 上窗口 |
| `Ctrl+L` | 右窗口 |

### 分屏 (Ctrl+\)
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+\` | 垂直分屏 |
| `Ctrl+Shift+\` | 水平分屏 |

### Tab/Buffer 导航
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+Tab` | 下一个 buffer |
| `Ctrl+Shift+Tab` | 上一个 buffer |
| `Ctrl+1-5` | 跳转到第 1-5 个 buffer |

### LSP 功能
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gi` | 跳转到实现 |
| `gr` | 跳转到引用 |
| `K` | 悬浮文档 |
| `Ctrl+K` | 签名帮助 |
| `F2` | 重命名符号 |
| `Space+rn` | 重命名符号 |
| `Space+ca` | 代码操作 |
| `Space+cf` | 格式化代码 |
| `Space+rp` | 重启 Pyright |
| `[d` / `]d` | 上/下诊断 |

### 调试 (DAP)
| 快捷键 | 功能 |
|--------|------|
| `F5` | 继续/启动调试 |
| `F10` | 单步跳过 |
| `F11` | 单步进入 |
| `F12` | 单步跳出 |
| `Space+db` | 切换断点 |
| `Space+dB` | 条件断点 |
| `Space+dl` | 日志断点 |
| `Space+dr` | 打开 REPL |
| `Space+du` | 切换 DAP UI |
| `Space+dc` | 运行到光标 |
| `Space+dq` | 终止调试 |

### Git (Space+g)
| 快捷键 | 功能 |
|--------|------|
| `Space+gg` | LazyGit |
| `Space+gf` | 文件历史 |
| `Space+gd` | Diff 视图 |
| `Space+gh` | 文件历史 (Diffview) |
| `Space+gH` | 分支历史 |
| `Space+gq` | 关闭 diff |
| `Space+gb` | 切换 Git blame |
| `Space+gpr` | 列出 PRs |
| `Space+gpc` | 创建 PR |
| `Space+gis` | 列出 issues |
| `Space+gic` | 创建 issue |

### Obsidian (Space+o)
| 快捷键 | 功能 |
|--------|------|
| `Space+on` | 新建笔记 |
| `Space+oo` | 在 Obsidian 中打开 |
| `Space+os` | 搜索笔记 |
| `Space+oq` | 快速切换 |
| `Space+ot` | 今天的笔记 |
| `Space+oy` | 昨天的笔记 |
| `Space+ob` | 反向链接 |
| `Space+ol` | 链接列表 |
| `Space+od` | 切换复选框 |
| `Space+ov` | 打开 vault |
| `Space+op` | 个人计划 |
| `Space+owp` | 工作计划 |

### Kanban (Space+o)
| 快捷键 | 功能 |
|--------|------|
| `Space+ok` | 打开 Kanban |
| `Space+owk` | 工作 Kanban |
| `Space+opk` | 个人 Kanban |

### TODO 管理 (Space+t)
| 快捷键 | 功能 |
|--------|------|
| `Space+tt` | 循环 Todo 状态 |
| `Space+td` | 标记为延期 [d] |
| `Space+tb` | 标记为阻塞 [b] |
| `Space+t!` | 标记为优先级 [!] |
| `Space+t?` | 标记为疑问 [?] |

**循环状态**: `[ ]` → `[@]` → `[s]` → `[x]` → `[ ]`

### 语言特定

#### TypeScript/JavaScript (Space+j)
| 快捷键 | 功能 |
|--------|------|
| `Space+jo` | 整理 imports |
| `Space+js` | 排序 imports |
| `Space+jr` | 删除未使用 imports |
| `Space+jf` | 修复所有问题 |
| `Space+ja` | 添加缺失 imports |
| `Space+jd` | 跳转到源定义 |
| `Space+jR` | 重命名文件 |

#### Rust (Space+r)
| 快捷键 | 功能 |
|--------|------|
| `Space+rd` | Debuggables |
| `Space+rr` | Runnables |
| `Space+rt` | Testables |
| `Space+re` | 展开宏 |
| `Space+rc` | 打开 Cargo.toml |
| `Space+rp` | 父模块 |
| `Space+rj` | 合并行 |
| `Space+rh` | 悬浮操作 |

#### Go (Space+g)
| 快捷键 | 功能 |
|--------|------|
| `Space+gr` | 运行 |
| `Space+gt` | 测试 |
| `Space+gtf` | 测试函数 |
| `Space+gc` | 覆盖率 |
| `Space+gi` | Go imports |
| `Space+ge` | Go if err |
| `Space+gs` | 填充结构体 |
| `Space+ga` | 添加标签 |

#### C/C++ (Space+l)
| 快捷键 | 功能 |
|--------|------|
| `Space+lh` | 切换头/源文件 |
| `Space+lt` | 类型层次结构 |
| `Space+lm` | 内存使用 |
| `Space+la` | 显示 AST |

### AI (Space+a)
| 快捷键 | 功能 |
|--------|------|
| `Space+ai` | 切换 AI 聊天 |
| `Space+aa` | AI 操作 |
| `Space+ac` (visual) | 添加到 AI 聊天 |
| `Alt+L` | 接受建议 (Avante) |
| `Alt+]` / `Alt+[` | 下/上建议 |

### 生产力工具

#### Harpoon (Space+h)
| 快捷键 | 功能 |
|--------|------|
| `Space+ha` | 添加文件 |
| `Space+hh` | Harpoon 菜单 |
| `Space+h1-4` | 跳转到第 1-4 个文件 |
| `Space+hp/hn` | 上/下一个文件 |

#### Spectre (Space+s)
| 快捷键 | 功能 |
|--------|------|
| `Space+sr` | 搜索替换 |
| `Space+sw` | 搜索单词 |
| `Space+sf` | 在文件中搜索 |

#### Session (Space+q)
| 快捷键 | 功能 |
|--------|------|
| `Space+qs` | 恢复会话 |
| `Space+ql` | 恢复上次会话 |
| `Space+qd` | 不保存会话 |

#### Snacks
| 快捷键 | 功能 |
|--------|------|
| `Space+z` | Zen 模式 |
| `Space+Z` | Zoom |
| `Space+.` | Scratch buffer |
| `Space+S` | 选择 scratch |
| `Space+n` | 通知历史 |
| `Space+bd` | 删除 buffer |
| `Space+cR` | 重命名文件 |
| `Space+gB` | Git browse |
| `]]` / `[[` | 下/上引用 |

#### 其他
| 快捷键 | 功能 |
|--------|------|
| `Space+u` | 撤销树 |
| `Space+tw` | 切换 Twilight |
| `Space+fml` | 代码雨 |
| `Space+fmg` | 生命游戏 |
| `Space+fz` | 屏保 |

### 远程开发 (Space+D)
| 快捷键 | 功能 |
|--------|------|
| `Space+Dc` | Distant Connect |
| `Space+Dl` | Distant Launch |
| `Space+Do` | Distant Open |
| `Space+Ds` | Distant Shell |
| `Space+Dw` | Distant Workspace |
| `Space+Db` | Distant Browse (neo-tree) |

### 娱乐 (Space+d)
| 快捷键 | 功能 |
|--------|------|
| `Space+dd` | 孵化鸭子 |
| `Space+dk` | 烹饪鸭子 |
| `Space+da` | 烹饪所有鸭子 |
| `Space+dc` | 孵化猫 |

### Trouble (Space+x)
| 快捷键 | 功能 |
|--------|------|
| `Space+xx` | 诊断 (工作区) |
| `Space+xX` | 诊断 (buffer) |
| `Space+xt` | Todos (工作区) |
| `Space+xT` | Todos (buffer) |
| `Space+xs` | 符号 |
| `Space+xl` | Location list |
| `Space+xq` | Quickfix list |

### 代码补全
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+Space` | 触发补全 |
| `Ctrl+J` / `Ctrl+K` | 下/上选择 |
| `Ctrl+B` / `Ctrl+F` | 上/下滚动文档 |
| `Ctrl+E` | 中止 |
| `Tab` | 选择/展开代码片段 |
| `Shift+Tab` | 上一个选择/跳出片段 |

### 其他实用快捷键
| 快捷键 | 功能 |
|--------|------|
| `Esc` | 清除搜索高亮 |
| `s` | Flash 跳转 |
| `S` | Flash Treesitter |
| `r` (operator) | 远程 Flash |
| `Ctrl+Shift+L` | 更改所有出现 |

---

## 自定义配置

### 选项 (options.lua)
- **缩进**: 2 空格，自动缩进
- **行号**: 相对行号
- **搜索**: 忽略大小写，智能匹配
- **鼠标**: 全部启用
- **剪贴板**: 使用系统剪贴板
- **撤销文件**: 启用
- **更新频率**: 250ms
- **超时**: 300ms

### 特殊功能

#### Markdown 自定义 Todo 状态
配置了多种自定义 Todo 状态，带有不同颜色和图标：
- `[ ]` 未完成 (蓝色)
- `[@]` 进行中 (橙色)
- `[s]` 已开始 (蓝色)
- `[x]` 已完成 (绿色)
- `[d]` 延期 (灰色)
- `[b]` 阻塞 (红色)
- `[!]` 优先级 (黄色)
- `[?]` 疑问 (紫色)

#### 远程开发
配置了 `celeste-eu-cluster` 服务器，支持 SSH 远程开发。

#### Git 代理
配置了 SOCKS5 代理（`socks5://127.0.0.1:10803`）用于 git 操作。

---

## 支持的语言

- **Lua**: lua_ls
- **TypeScript/JavaScript**: ts_ls, typescript-tools
- **Python**: pyright (自动检测 .venv)
- **Rust**: rust-analyzer (rustaceanvim)
- **Go**: gopls (go.nvim)
- **C/C++**: clangd (clangd_extensions)
- **HTML/CSS**: html, cssls, tailwindcss
- **JSON/YAML**: jsonls, yamlls
- **Markdown**: marksman, render-markdown

---

## 安装

```bash
# 克隆配置
git clone <your-repo> ~/.config/nvim

# 运行安装脚本
cd ~/.config/nvim
bash install.sh
```

## 更新插件

```vim
:Lazy
```

---

**配置维护者**: Azzie
**最后更新**: 2025
**Neovim 版本要求**: 0.11+
