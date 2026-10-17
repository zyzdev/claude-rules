# claude-rules

zyzdev 的 Claude Code 工作規則，做成一個外掛市集。

| 外掛 | 作用 |
|---|---|
| `execution-planning-rules` | 每個 session 開始時載入兩條規則：階段開始前先評估執行方式；列出選項或決定時用表格 |

規則全文在 [`plugins/execution-planning-rules/rules.md`](plugins/execution-planning-rules/rules.md)。

## 在新電腦安裝（每台電腦一次）

需要 Claude Code CLI，而且這台電腦要能存取這個私人 repo（`gh auth login`，或已設定 GitHub 的 SSH 金鑰）。

```bash
claude plugin marketplace add zyzdev/claude-rules
```

```bash
claude plugin install execution-planning-rules@zyzdev-rules
```

在 session 裡也可以輸入 `/plugin marketplace add zyzdev/claude-rules`，再輸入 `/plugin install execution-planning-rules@zyzdev-rules`。裝好之後，新開的 session 就會套用。

## 測試

裝好之後，在那台電腦確認兩件事。

**1. 外掛已啟用**

```bash
claude plugin list
```

應該看到 `execution-planning-rules@zyzdev-rules`，以及 `Status: ✔ enabled`。

**2. 新 session 有載入規則**

在桌面 app 新開一個 session，貼上下面這段。已經開著的 session 不算，外掛只在 session 開始、`/clear` 或 context 壓縮時載入。

```text
先不要做任何事，也不要讀檔或執行指令。只回答：你的 context 開頭有沒有一句話寫著「它們由 execution-planning-rules 外掛（github.com/zyzdev/claude-rules）在每個 session 開始時載入」？有的話原文引用那一句；沒有就只回答「沒有」。
```

| 它的回答 | 代表什麼 |
|---|---|
| 原文引用出那一句 | 外掛生效 |
| 「沒有」 | 外掛沒載入，或那個 session 是在安裝前開的；重開一個新 session 再試，還是沒有就看下面的常見問題 |

要問那一句、而不是單純問「有沒有讀到規則」，是因為那台電腦的 `~/.claude/CLAUDE.md` 若也寫了同樣的規則，單純問分不出是哪一邊載入的。

只用終端機的電腦，也可以直接執行，需要先登入 Claude Code：

```bash
claude -p "你的 context 開頭有沒有一句話寫著「它們由 execution-planning-rules 外掛（github.com/zyzdev/claude-rules）在每個 session 開始時載入」？有的話原文引用那一句；沒有就只回答「沒有」。"
```

**常見問題**

| 狀況 | 原因 | 處理 |
|---|---|---|
| `claude: command not found` | 那台電腦沒裝 Claude Code CLI | 先執行 `curl -fsSL https://claude.ai/install.sh \| bash` 安裝，再重開終端機 |
| `marketplace add` 出現權限錯誤或找不到 repo | 那台電腦沒有權限讀這個私人 repo | 執行 `gh auth login`，再執行 `gh auth setup-git`，然後重跑安裝指令 |
| `claude -p` 出現登入失敗 | 終端機版 Claude Code 沒登入或登入過期 | 在終端機執行 `claude`，輸入 `/login` 登入；或改用桌面 app 測試 |
| `claude plugin list` 顯示 disabled | 外掛被停用 | 執行 `claude plugin enable execution-planning-rules@zyzdev-rules` |

## 修改規則

1. 改 `rules.md`，並把 `plugins/execution-planning-rules/.claude-plugin/plugin.json` 的 `version` 加一。
2. commit 並 push。
3. 在每台電腦執行下面兩行，之後新開的 session 才會讀到新版。

```bash
claude plugin marketplace update zyzdev-rules
```

```bash
claude plugin update execution-planning-rules@zyzdev-rules
```

## 移除

```bash
claude plugin uninstall execution-planning-rules@zyzdev-rules
```

```bash
claude plugin marketplace remove zyzdev-rules
```

## 限制

- 雲端 session 不會載入，因為它們不讀電腦上的設定。
- 規則在 session 開始、`/clear` 之後和 context 壓縮之後載入。
