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
