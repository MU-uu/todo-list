# 二次开发指南

修改代码后,完整工作流:**本地改 → GitHub push → Netlify 自动部署**。

## 1️⃣ 本地编辑代码

**用什么编辑器都行**(VS Code / WebStorm / 记事本都行):

- 主文件:`E:\Work Buddy Project\To Do list\index.html`
- 备份文件:`todo.html`(跟 index.html 内容完全一致,**两个文件都要同步改**——或者改完只 push index.html,本地留个 todo.html 副本作历史)
- 部署配置:`netlify.toml`(改配置,比如加新缓存规则)
- 文档:`README.md` / `NETLIFY_DEPLOY.md` / `DEVELOPMENT.md`

**最简编辑流程**:
1. 打开 `index.html` 在编辑器
2. 改 CSS / JS / HTML
3. 保存

## 2️⃣ 本地预览(看效果)

### 方式 A:直接双击(最快)
- 双击 `index.html`,浏览器自动打开 `file:///E:/.../index.html`
- localStorage 数据与生产 URL **独立**(你看到的可能是空清单)
- 适用:快速看 UI 改动

### 方式 B:本地静态服务器(更接近生产)
在项目目录打开 PowerShell / Git Bash:
```bash
cd "E:/Work Buddy Project/To Do list"
python -m http.server 8000
# 然后浏览器打开 http://localhost:8000
```
或用 Node:
```bash
npx -y serve
```
或 VS Code 装 **Live Server** 插件,右键 `index.html` → "Open with Live Server"

## 3️⃣ 提交到 GitHub

```bash
cd "E:/Work Buddy Project/To Do list"
git add .
git -c user.name="MU-uu" -c user.email="MU-uu@users.noreply.github.com" commit -m "简述你改了什么"
```

然后推送(用 gh 的 token,因为 git 没存 https 凭据):

```bash
TOKEN=$(gh auth token)
git push https://MU-uu:${TOKEN}@github.com/MU-uu/todo-list.git main
```

> **可选:配 SSH 凭据省掉 token**
> 一次性操作,以后 `git push` 不用再带 token:
> ```bash
> git remote set-url origin git@github.com:MU-uu/todo-list.git
> ```
> 需要先有 SSH key(GitHub 文档搜 "SSH key"),然后 `git push` 就直接走 SSH。

## 4️⃣ Netlify 自动部署

- Netlify 监听 `main` 分支,push 后 **30 秒内自动重新部署**
- 公开 URL `https://mu-todo-list.netlify.app` **永远不变**
- 想看构建日志:登录 Netlify → 选 `mu-todo-list` 项目 → "Deploys" 标签

## 5️⃣ 验证部署成功

```bash
curl -s -o /dev/null -w "HTTP %{http_code}\n" https://mu-todo-list.netlify.app/
```

返回 `HTTP 200` = 部署成功。也可以浏览器打开看。

## ⚠️ 重要注意事项

| 注意点 | 说明 |
|---|---|
| **数据隔离** | `file:///E:/.../index.html` 和 `https://mu-todo-list.netlify.app` 是**两套独立的 localStorage**,互不干扰 |
| **清空测试数据** | 浏览器开发者工具 → Application → Storage → Clear site data,或在控制台跑 `localStorage.clear()` |
| **强制刷新** | 改了代码浏览器可能用缓存,按 `Ctrl+Shift+R` / `Cmd+Shift+R` 强制刷新 |
| **HTML 转义** | 任务文本已用 `escapeHtml()` 防 XSS,可以放心填任意字符 |
| **图标颜色** | 避免在按钮内用彩色 emoji(如 ➕),Windows 不会跟随 `color` 变白,改用 ASCII 字符或 inline SVG |
| **中文换行** | 任务项文字 `min-width: 0` + `overflow-wrap: anywhere`,不要改回 `word-break: break-word`,否则会一字一行 |

## 🆘 常见问题

**Q: 改了 index.html 推上去了,Netlify 没更新?**
A: 去 Netlify 后台 → Deploys 看是不是构建失败(红色)。常见原因:`netlify.toml` 语法错。

**Q: 推送报 "Permission denied"?**
A: 用 `gh auth login` 重新登录,或检查 `gh auth status`。

**Q: 想撤回某次提交?**
A: 
```bash
# 撤回最近一次 commit(保留改动)
git reset --soft HEAD~1
# 推送到远端(会触发 Netlify 自动部署旧版本)
TOKEN=$(gh auth token) && git push https://MU-uu:${TOKEN}@github.com/MU-uu/todo-list.git main --force
```

**Q: 想给代码加注释 / 模块化拆分?**
A: 单文件已经 ~72KB,继续增长会难维护。可以拆:
- `style.css`(从 `<style>` 块抽出)
- `app.js`(从 `<script>` 块抽出)
- `index.html` 只留结构
然后 `index.html` 里改成 `<link rel="stylesheet" href="style.css">` 和 `<script src="app.js">`。

**Q: 想加新功能没思路?**
A: 一些常见方向:
- PWA(支持"添加到主屏幕",离线可用)
- 数据导出/导入(JSON 文件)
- 任务搜索/标签
- 跨设备同步(Supabase / Firebase)
- 深色模式
- 番茄钟

## 📁 项目文件速查

```
E:\Work Buddy Project\To Do list\
├── index.html           # 主入口(部署用)
├── todo.html            # 历史副本(改完保持同步)
├── netlify.toml         # 部署配置(安全头 + 缓存)
├── README.md            # 项目说明(给访客看)
├── NETLIFY_DEPLOY.md    # 部署说明(已部署,作历史)
├── DEVELOPMENT.md       # 本文档(开发工作流)
├── .gitignore           # Git 忽略规则(排除 .workbuddy)
└── .workbuddy/          # 内部工作数据(不进 Git)
    └── memory/          # 项目记忆
```

## 6️⃣ 协作开发:不用 WorkBuddy 也能改

**核心原则:Netlify 部署只看 GitHub 仓库的 main 分支,跟谁改、在哪改、用什么工具改完全无关。** 只要代码 push 到 `https://github.com/MU-uu/todo-list.git`,Netlify 30 秒内就自动部署。

### 场景 A:在 WorkBuddy 本项目的新对话窗口改
- 操作完全跟当前一样
- AI 默认就在 `E:/Work Buddy Project\To Do list` 目录工作
- 让 AI 改完直接帮你 commit + push 即可

### 场景 B:在 WorkBuddy 别的项目里开窗口改这个项目
- AI 默认会 cd 到它所在的项目目录,**不一定**是本项目目录
- **关键**:在第一句明确告诉它"项目目录是 `E:/Work Buddy Project\To Do list`,所有操作在那里"
- 或者:"先 `cd "E:/Work Buddy Project/To Do list"`,再帮我改 xxx"

### 场景 C:完全不用 AI,手动改
1. 用任何编辑器(记事本 / VS Code / Sublime Text)打开 `E:/Work Buddy Project\To Do list\index.html`
2. 编辑保存
3. 双击项目根目录的 **`deploy.bat`** 文件(我做了,见下) → 自动完成 git add + commit + push
4. 等 30 秒,Netlify 自动部署

### 场景 D:用其他 AI 工具(Cursor / Copilot / ChatGPT / Claude.ai 网页)
1. 让 AI 给你**完整的代码**(不要让它直接改你的文件,因为它改的位置可能不在 `E:/Work Buddy Project\To Do list`)
2. 手动复制粘贴到 `E:/Work Buddy Project\To Do list\index.html`(覆盖保存)
3. 双击 **`deploy.bat`** → 自动 commit + push
4. Netlify 自动部署

### 场景 E:让别的 AI 直接改文件
- Cursor / Copilot / Continue 等本地插件:把项目根目录作为"工作区"打开,直接说"帮我改 xxx"
- 改完用 `deploy.bat` 一键推送
- 不需要额外配置

### 场景 F:你/同事在他人的电脑上改
1. 把整个 `E:/Work Buddy Project\To Do list` 目录压缩成 zip,发给别人
2. 别人解压后:**首次需要初始化 git 凭据**(见下方)
3. 改完双击 `deploy.bat`(脚本里会自动检测 token 是否可用)

## 🆕 7️⃣ 一键部署脚本

为了避免每次都要敲 git 命令,项目根目录放了 3 个脚本,挑你平台用的:

### Windows:deploy.bat
- **用法**:改完 `index.html`,**双击 `deploy.bat`**
- 会弹一个黑色 cmd 窗口,自动运行:
  ```
  git add .
  git commit -m "..."
  git push (用 gh token)
  ```
- 完成后窗口停留,你能看到成功/失败信息
- 按任意键关闭窗口

### Mac/Linux:deploy.sh
- **用法**:终端 `bash deploy.sh` 或 `chmod +x deploy.sh && ./deploy.sh`

### 任何平台:deploy.py(Python 跨平台)
- **用法**:`python deploy.py`
- 需要 Python 3.6+(Windows 一般有)

## 🔐 8️⃣ 在新电脑上首次配置

换电脑 / 同事协作 / 克隆仓库到新位置,首次要做:

```bash
# 1. 装好 git + GitHub CLI(gh)
# Windows: winget install GitHub.cli
# Mac: brew install gh
# Linux: apt install gh

# 2. 登录 GitHub(会打开浏览器)
gh auth login
# 选 HTTPS,选你的 GitHub 账号 MU-uu

# 3. 克隆仓库
git clone https://github.com/MU-uu/todo-list.git
cd todo-list

# 4. 复制文件到 E:/Work Buddy Project\To Do list(可选)
# 或者直接在这个目录工作

# 5. 测试部署脚本
deploy.bat   # Windows
# 或
./deploy.sh  # Mac/Linux
```

之后所有推送都不用再输入凭据(gh 帮你管理)。

## 📌 核心要点总结

| 关键事实 | 说明 |
|---|---|
| Netlify 监听什么? | GitHub 仓库 `MU-uu/todo-list` 的 `main` 分支 |
| 谁来 push? | **任何人**——你、同事、CI/CD、其他 AI |
| push 一次部署一次? | 是,30 秒内自动重新部署 |
| push 后 URL 变不变? | 不变,永远是 `https://mu-todo-list.netlify.app` |
| 没 push 之前能看到吗? | 本地 `index.html` 直接看,或用 `python -m http.server` |
| 别人改完 push 了我能知道吗? | GitHub 仓库 → Insights → Commit history 看提交 |

**所以:你完全可以在任何地方、任何方式改代码,只要最后一步是 `git push` 到 GitHub,Netlify 就自动接管剩下所有事。**
