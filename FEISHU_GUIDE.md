# 四象限待办清单 · 零基础复刻指南

> **写给谁看**:完全没接触过代码、没用过 Git/GitHub/Netlify,但想从零开始复刻这个项目的人。
>
> **能学到什么**:跟着一步步操作,你会得到一个跟作者一模一样的、部署在公开 URL 上的 Web 应用,后续还能自己改代码更新。
>
> **预计耗时**:首次 60-90 分钟(主要是装软件和注册账号),熟练后 5-10 分钟可以完成一次代码更新。
>
> **作者提示**:文档里所有命令都可以直接复制粘贴到命令行运行。带 ⚠️ 的部分是常见坑,务必看清。

---

## 📑 目录

- [第一部分:从 0 到 1 复刻项目](#第一部分从-0-到-1-复刻项目)
  - [第 0 步:准备工作](#第-0-步准备工作)
  - [第 1 步:创建本地项目文件夹](#第-1-步创建本地项目文件夹)
  - [第 2 步:安装 Notepad++(代码编辑器)](#第-2-步安装-notepad代码编辑器)
  - [第 3 步:安装 Git(版本管理工具)](#第-3-步安装-git版本管理工具)
  - [第 4 步:安装 GitHub CLI](#第-4-步安装-github-cli)
  - [第 5 步:从作者的 GitHub 仓库下载代码](#第-5-步从作者的-github-仓库下载代码)
  - [第 6 步:注册 GitHub 账号](#第-6-步注册-github-账号)
  - [第 7 步:用 GitHub CLI 登录](#第-7-步用-github-cli-登录)
  - [第 8 步:把代码推送到你自己的 GitHub 仓库](#第-8-步把代码推送到你自己的-github-仓库)
  - [第 9 步:注册 Netlify 账号](#第-9-步注册-netlify-账号)
  - [第 10 步:在 Netlify 关联 GitHub](#第-10-步在-netlify-关联-github)
  - [第 11 步:配置项目并部署](#第-11-步配置项目并部署)
  - [第 12 步:验证部署成功](#第-12-步验证部署成功)
- [第二部分:维护和更新](#第二部分维护和更新)
  - [怎么改一行文字](#怎么改一行文字)
  - [怎么推送更新到网站](#怎么推送更新到网站)
  - [一键部署脚本(推荐)](#一键部署脚本推荐)
  - [常见错误和解决方法](#常见错误和解决方法)
- [第三部分:进阶二次开发](#第三部分进阶二次开发)
  - [代码结构说明](#代码结构说明)
  - [改代码的三种方式](#改代码的三种方式)
  - [调试技巧](#调试技巧)
  - [回退错误修改](#回退错误修改)
  - [添加新功能的思路](#添加新功能的思路)
- [第四部分:注意事项](#第四部分注意事项)
  - [数据安全](#数据安全)
  - [浏览器兼容性](#浏览器兼容性)
  - [备份策略](#备份策略)
  - [绝对不要做的事](#绝对不要做的事)
- [附录 A:完整文件清单](#附录-a完整文件清单)
- [附录 B:命令速查表](#附录-b命令速查表)
- [附录 C:关键 URL 速查](#附录-c关键-url-速查)

---

# 第一部分:从 0 到 1 复刻项目

## 第 0 步:准备工作

### 0.1 你需要的东西

| 类别 | 名称 | 用途 | 是否必须 | 费用 |
|---|---|---|---|---|
| 账号 | GitHub 账号 | 存放代码 | ✅ 必须 | 免费 |
| 账号 | Netlify 账号 | 部署网站 | ✅ 必须 | 免费 |
| 软件 | Windows 10/11 或 macOS | 操作系统 | ✅ 必须 | - |
| 软件 | Notepad++(Windows)或 VS Code | 编辑代码 | ✅ 必须 | 免费 |
| 软件 | Git | 版本管理 | ✅ 必须 | 免费 |
| 软件 | GitHub CLI(`gh`) | 命令行工具 | ✅ 必须 | 免费 |
| 网络 | 能访问 github.com 和 netlify.com | 推送/部署 | ✅ 必须 | - |
| 浏览器 | Chrome / Edge / Firefox | 查看效果 | ✅ 必须 | 免费 |

### 0.2 你不需要的东西

- ❌ **不需要** Node.js(本项目不用)
- ❌ **不需要** 数据库(数据存浏览器)
- ❌ **不需要** 服务器(Netlify 帮你托管)
- ❌ **不需要** 懂 HTML/CSS/JavaScript(直接复制作者写好的代码)
- ❌ **不需要** 花钱(全程免费)

### 0.3 心理准备

- 第一次操作可能要 60-90 分钟,别急
- 看到红色错误信息别慌,本文档每个常见错误都给了应对方法
- 任何一步卡住超过 5 分钟,直接跳到「常见错误和解决方法」章节

---

## 第 1 步:创建本地项目文件夹

### 操作

1. 按 `Win + E` 打开文件资源管理器
2. 左侧导航到 **D 盘**(其他盘也行,记住位置)
3. 在 D 盘空白处 **右键** → **新建** → **文件夹**
4. 文件夹名输入:`todo-list` ← 必须用这个英文名
5. 按 `Enter` 确认

### 你会看到

```
D:\
└── todo-list\        ← 新建的这个
```

### ⚠️ 注意事项

- 路径里**不能有中文或空格**,否则后续 Git 命令会报错
- 不要放在桌面,以后命令很长不方便
- 路径记一下,下一步要进去(例如 `D:\todo-list`)

---

## 第 2 步:安装 Notepad++(代码编辑器)

> Windows 自带的"记事本"编辑 HTML 会乱码(默认 ANSI 编码,不是 UTF-8)。Notepad++ 专为代码设计,免费。

### 操作

1. 打开浏览器,访问:**https://notepad-plus-plus.org/downloads/**
2. 找最新版本(版本号最大的),点 **"Notepad++ Installer"** 下载
3. 双击下载的 `.exe` 文件(例如 `npp.8.6.Installer.x64.exe`)
4. 安装向导弹出 → 选语言 **"中文(简体)"** → OK
5. 一路点 **"下一步"** → **"我接受"** → **"下一步"** → **"安装"**
6. 等待安装完成 → **"完成"**

### 验证

1. 按 `Win` 键,搜索 `Notepad++`
2. 看到图标就成功了

### Mac 用户

Mac 没 Notepad++,改用 **VS Code**(免费):https://code.visualstudio.com/

---

## 第 3 步:安装 Git(版本管理工具)

> Git 像是"时光机器",记录每次代码改动,改错了可以回滚。

### 操作(Windows)

1. 打开浏览器,访问:**https://git-scm.com/download/win**
2. 页面会自动开始下载 `Git-xxx-64-bit.exe`(如果没自动下载,点 "Click here to download manually")
3. 下载完成后,双击 `.exe` 文件
4. 安装向导 → 一路点 **"Next"** → **"Next"** → ... → **"Install"**
5. ⚠️ **关键步骤**:看到 "Adjusting your PATH environment" 页面时,选 **"Git from the command line and also from 3rd-party software"**(默认选项,不要改)
6. 继续点 **"Next"** → **"Finish"**

### 验证

1. 按 `Win + R`,输入 `cmd`,按回车 → 弹出黑色命令行窗口
2. 在窗口里输入:
   ```
   git --version
   ```
3. 按回车
4. 应该看到类似:
   ```
   git version 2.43.0.windows.1
   ```
5. 看到版本号就成功了

### ⚠️ 如果显示 "git 不是内部或外部命令"

说明安装时 PATH 没正确配置。解决方法:
1. 关闭所有 cmd 窗口
2. 重新打开 cmd
3. 再试一次
4. 还不行 → 卸载 Git,重装,**这次仔细看每一步选项**

### Mac 用户

打开终端(Terminal),输入:
```
xcode-select --install
```
按回车,等安装完成。Mac 自带 Git。

---

## 第 4 步:安装 GitHub CLI

> `gh` 是 GitHub 官方的命令行工具,用它可以在命令行直接创建仓库、推送代码,不用浏览器。

### 操作(Windows)

**方法 A:用 winget(推荐,Windows 10/11 自带)**

1. 按 `Win + R`,输入 `cmd`,按回车
2. 输入:
   ```
   winget install GitHub.cli
   ```
3. 按回车,等待安装完成
4. **关闭这个 cmd 窗口**(否则 PATH 不刷新)
5. 重新打开一个新的 cmd 窗口

**方法 B:用安装包(如果 winget 不可用)**

1. 访问:**https://cli.github.com/**
2. 点 **"Download for Windows"**
3. 下载 `.msi` 文件,双击安装
4. 一路 Next → Install → Finish

### 验证

1. 在 cmd 输入:
   ```
   gh --version
   ```
2. 按回车
3. 应该看到:
   ```
   gh version 2.40.0 (2024-01-01)
   https://github.com/cli/cli/releases
   ```

### ⚠️ 如果显示 "gh 不是内部或外部命令"

- 关闭所有 cmd 窗口,重新打开一个再试
- 还不行 → 用方法 B 重装

### Mac 用户

终端输入:
```
brew install gh
```

---

## 第 5 步:从作者的 GitHub 仓库下载代码

> 作者已经把代码放在公开 GitHub 仓库,你直接复制过来就行。

### 操作

1. 打开浏览器,访问作者的 GitHub 仓库:
   **https://github.com/MU-uu/todo-list**
2. 点页面右上角的绿色按钮 **"<> Code"**
3. 在弹出菜单中点 **"Download ZIP"**
4. 浏览器开始下载 `todo-list-main.zip`
5. 下载完成后,**右键**这个 zip 文件 → **"解压到 todo-list-main\"**
6. 进入解压后的文件夹 `todo-list-main`,你会看到:
   ```
   todo-list-main\
   ├── index.html           ← 主文件
   ├── todo.html            ← 副本
   ├── netlify.toml         ← 部署配置
   ├── README.md
   ├── NETLIFY_DEPLOY.md
   ├── DEVELOPMENT.md
   ├── deploy.bat           ← 一键部署脚本(Windows)
   ├── deploy.sh            ← 一键部署脚本(Mac/Linux)
   ├── deploy.py            ← 一键部署脚本(Python)
   └── .gitignore
   ```
7. **全选**这个文件夹里的所有文件(`Ctrl + A`)
8. **复制**(`Ctrl + C`)
9. 回到第 1 步创建的 `D:\todo-list\` 文件夹
10. **粘贴**(`Ctrl + V`)

### 你会看到

```
D:\
└── todo-list\
    ├── index.html
    ├── todo.html
    ├── netlify.toml
    ├── README.md
    ├── NETLIFY_DEPLOY.md
    ├── DEVELOPMENT.md
    ├── deploy.bat
    ├── deploy.sh
    ├── deploy.py
    └── .gitignore
```

### ⚠️ 注意事项

- 注意 `.gitignore` 是隐藏文件,需要在文件资源管理器顶部 → **"查看"** → 勾选 **"隐藏的项目"** 才能看见
- 如果 zip 解压后文件夹名是 `todo-list-main`,你复制里面的文件到 `D:\todo-list` 即可,**不要把整个 todo-list-main 文件夹放进去**

### 验证

1. 双击 `D:\todo-list\index.html`
2. 浏览器自动打开,看到一个待办清单页面(蓝色主题,标题"我的待办清单")
3. 输入"测试任务"按回车 → 弹出优先级选择 → 选一个 → 弹出截止询问 → 跳过 → 任务出现在列表

如果上述都正常,代码就下载成功了。

---

## 第 6 步:注册 GitHub 账号

> 如果你已经有 GitHub 账号,跳到[第 7 步](#第-7-步用-github-cli-登录)。

### 操作

1. 打开浏览器,访问:**https://github.com/signup**
2. 输入你的邮箱(常用邮箱,GitHub 会发验证邮件)
3. 设置密码(至少 15 个字符,或至少 8 字符含数字和小写字母)
4. 设置用户名(英文,例如 `your-name-todo`)
5. 回答 "Email preferences"(可以全不勾)
6. 完成人机验证(拼图)
7. 点 **"Create account"**
8. GitHub 发送验证邮件到你的邮箱
9. 打开邮箱,找 GitHub 邮件,点 **"Verify email address"** 按钮

### 你会看到

浏览器跳转到 GitHub 主页,显示 "Welcome to GitHub" 或类似欢迎信息。

### ⚠️ 注意事项

- 用户名一旦设定,**之后改起来麻烦**,建议想清楚(可以小写英文+数字+连字符)
- 邮箱要常用,因为 GitHub 推送通知、安全告警都发到这里
- 密码别忘,GitHub 没法找回密码,只能重置

---

## 第 7 步:用 GitHub CLI 登录

### 操作

1. 按 `Win + R`,输入 `cmd`,按回车
2. 输入:
   ```
   gh auth login
   ```
3. 按回车,会有一系列交互问题
4. **第 1 问**:"What account do you want to log into?" → 选 **"GitHub.com"** → 回车
5. **第 2 问**:"What is your preferred protocol for Git operations?" → 选 **"HTTPS"** → 回车
6. **第 3 问**:"Authenticate Git with your GitHub credentials?" → 选 **"Yes"** → 回车
7. **第 4 问**:"How would you like to authenticate GitHub CLI?" → 选 **"Login with a web browser"** → 回车
8. 终端显示一行验证码,例如:
   ```
   ! First copy your one-time code: XXXX-XXXX
   Press Enter to open github.com in your browser...
   ```
9. **记下这个验证码**(例如 `AB12-CD34`)
10. 按回车,浏览器自动打开 GitHub 登录页
11. 如果还没登录 GitHub,先登录
12. 在页面输入刚才的验证码 → 点 **"Continue"**
13. 授权页面 → 点 **"Authorize github"**
14. 浏览器显示 "Congratulations, you're all set!"

### 验证

回到 cmd 窗口,看到:
```
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as your-username
```

输入:
```
gh auth status
```
应该看到:
```
github.com
  ✓ Logged in to github.com account your-username (keyring)
  - Active account: true
  - Git operations protocol: https
  - Token: gho_************************************
  - Token scopes: 'gist', 'read:org', 'repo', 'workflow'
```

看到 `✓ Logged in` 就成功了。

### ⚠️ 常见错误

**错误 1**:"验证码不工作"
- 验证码有时效,2 分钟内必须输入
- 验证码不区分大小写,但中间的连字符 `-` 必须有

**错误 2**:"浏览器没自动打开"
- 复制终端显示的 URL,手动粘贴到浏览器

---

## 第 8 步:把代码推送到你自己的 GitHub 仓库

### 操作

1. 在 cmd 输入(把 `D:` 换成你的实际盘符):
   ```
   cd /d D:\todo-list
   ```
   按回车
2. 初始化 Git 仓库:
   ```
   git init -b main
   ```
   按回车 → 看到 `Initialized empty Git repository in D:/todo-list/.git/`
3. 添加所有文件到暂存区:
   ```
   git add .
   ```
   按回车(没输出是正常的)
4. 设置你的 Git 身份(把名字和邮箱换成你的):
   ```
   git config user.name "your-username"
   git config user.email "your-email@example.com"
   ```
5. 提交:
   ```
   git commit -m "Initial commit: 待办清单应用"
   ```
   按回车 → 看到类似 `[main (root-commit) xxxxxxx] Initial commit: ...`
6. 创建 GitHub 仓库并推送(把 `your-repo-name` 换成你想要的仓库名,例如 `my-todo`):
   ```
   gh repo create your-repo-name --public --description "我的待办清单应用" --source=. --remote=origin --push
   ```
   按回车
7. 浏览器可能弹一下,授权一下
8. 完成后看到:
   ```
   https://github.com/your-username/your-repo-name
   To https://github.com/your-username/your-repo-name.git
    * [new branch]      HEAD -> main
   ```

### 你会看到

浏览器打开 `https://github.com/your-username/your-repo-name`,看到你的代码已经在上面了!

### ⚠️ 常见错误

**错误 1**:"fatal: not a git repository"
- 你忘了 `cd /d D:\todo-list` 进项目目录
- 重新 cd 进去,再试

**错误 2**:"gh: command not found"
- 第 4 步 gh 没装好,重装

**错误 3**:"Repository creation failed: name already exists on this account"
- 你 GitHub 上已经有同名仓库了
- 换个名字,或者去 GitHub 网页删掉旧仓库

---

## 第 9 步:注册 Netlify 账号

### 操作

1. 打开浏览器,访问:**https://app.netlify.com/signup**
2. 点 **"Sign up with GitHub"**(用 GitHub 账号登录,不用单独注册)
3. 弹出授权页 → 点 **"Authorize Netlify"**
4. 完成基本信息填写(可能问你的角色、团队规模,随便选)
5. 进入 Netlify dashboard

### 你会看到

Netlify 主页,可能显示 "Welcome to Netlify" 或直接进入团队 dashboard。

---

## 第 10 步:在 Netlify 关联 GitHub

### 操作

1. 在 Netlify dashboard 主页,找 **"Add new site"** 或 **"Add new project"** 按钮(通常在右上角或中间)
2. 点它 → 选 **"Import an existing project"**
3. 看到一排 Git 平台选项(GitHub、GitLab、Bitbucket、Azure DevOps)
4. 点 **"GitHub"**
5. 弹出 GitHub 授权窗口,点 **"Authorize Netlify"**
6. 看到 "Configure Netlify on GitHub" 页面:
   - 选 **"Only select repositories"**(只授权指定仓库,更安全)
   - 在下拉菜单选你刚创建的仓库 `your-username/your-repo-name`
   - 点 **"Install"**
7. 回到 Netlify,自动显示你的仓库列表
8. 找到 `your-repo-name` → 点它

### ⚠️ 注意

新版本 Netlify 可能把"Add new site"叫"Add new project"——同一个东西,叫法不同。

---

## 第 11 步:配置项目并部署

### 操作

进入 "Let's deploy your project with..." 配置页:

1. **Team**:`your-username's team`(默认就行)
2. **Project name**:这是你未来的 URL 子域名,建议填一个**短、好记、跟项目相关**的名字,例如 `my-todo-list`
   - 这会决定你的访问 URL:`https://my-todo-list.netlify.app`
   - 名字撞了 Netlify 会让你加随机后缀
3. **Branch to deploy**:`main`(默认)
4. **Base directory**:(留空)
5. **Build command**:(留空)
6. **Publish directory**:`.`(默认,因为 netlify.toml 已经写了)
7. 检查一遍没问题,点底部蓝色按钮 **"Deploy your-repo-name"**

### 你会看到

页面跳转到 "Deploy log",开始显示构建日志:
```
1:23:45 PM: Build started
1:23:46 PM: Detected package.json changes...
1:23:47 PM: ...
```

等待 **30-60 秒**。

### 完成标志

看到顶部显示:
```
🎉 Your site is live!
https://my-todo-list.netlify.app
```

**复制这个 URL!** 这是你应用的永久访问地址。

### ⚠️ 常见错误

**错误 1**:"Deploy failed"
- 看 build log 红色错误信息
- 最常见原因:Publish directory 配置错(应该是 `.` 不是 `dist` 或 `build`)
- 解决:Netlify 后台 → Site settings → Build & deploy → 改 Publish directory → 触发重新部署

**错误 2**:"Domain already taken"
- 你填的 Project name 被别人用了
- 换个名字,例如加个数字 `my-todo-list-25198`

---

## 第 12 步:验证部署成功

### 操作

1. 浏览器打开你的 URL:`https://my-todo-list.netlify.app`
2. 应该看到跟本地双击 index.html 一样的页面:
   - 蓝色主题背景
   - 标题"我的待办清单"(旁边有 📋 图标轻轻摇摆)
   - 副标题"📜 凡事预则立"
   - 输入框(占位符:"今天要做什么?输入后按 Enter 添加")
3. 输入"测试任务"按回车
4. 弹出"先给任务定个优先级"弹窗 → 选"重要·紧急"
5. 弹出"设置截止时间?" → 点"跳过"
6. 任务出现在列表,左侧有红色边框(标识重要·紧急)
7. 切到右上角的矩阵视图(点 ▦ 图标) → 看到四象限布局,你的任务在右上角(重要·紧急)象限

### 跨设备测试

1. 用手机浏览器打开同一个 URL
2. 应该看到响应式布局自动适配(矩阵变单列)
3. 在手机上添加的任务,跟你电脑上添加的任务**互相看不到**——这是正常的(数据存各自浏览器)

### 🎉 恭喜!

你已经成功部署了一个 Web 应用,任何人通过 URL 都能访问。

---

# 第二部分:维护和更新

## 怎么改一行文字

### 场景:把副标题"凡事预则立"改成"今日事今日毕"

### 操作

1. 用 Notepad++ 打开 `D:\todo-list\index.html`
2. 按 `Ctrl + F` 搜索 `凡事预则立`
3. 找到这行:
   ```html
   <p>📜 凡事预则立</p>
   ```
4. 改成:
   ```html
   <p>📜 今日事今日毕</p>
   ```
5. 按 `Ctrl + S` 保存
6. 关闭 Notepad++

### 验证本地修改

双击 `D:\todo-list\index.html` → 看到副标题已变成"今日事今日毕"。

但**线上 URL 还是旧的**(因为还没推送),下一步推送。

---

## 怎么推送更新到网站

### 操作(命令行方式)

1. 按 `Win + R`,输入 `cmd`,按回车
2. 进入项目目录:
   ```
   cd /d D:\todo-list
   ```
3. 查看改了什么:
   ```
   git status
   ```
   看到 `modified: index.html`
4. 暂存改动:
   ```
   git add .
   ```
5. 提交(写个说明):
   ```
   git commit -m "改副标题为今日事今日毕"
   ```
6. 推送到 GitHub:
   ```
   git push
   ```
7. 等待 30 秒,Netlify 自动检测到 push → 自动重新部署

### 验证

刷新 `https://my-todo-list.netlify.app` → 副标题已变成"今日事今日毕"。

⚠️ 浏览器可能用缓存,按 `Ctrl + Shift + R` 强制刷新。

---

## 一键部署脚本(推荐)

> 每次手动敲 6 条命令很烦,我做了个脚本,**双击一下就完成**。

### 操作

1. 改完 `index.html` 后保存
2. 打开文件资源管理器,进入 `D:\todo-list\`
3. 找到 **`deploy.bat`** 文件
4. **双击它**
5. 弹出黑色 cmd 窗口,显示:
   ```
   ========================================
     Todo List - One-click Deploy
   ========================================

   Changes detected. Committing...

   Commit message (press Enter for default):
   ```
6. 输入改动说明(例如"改副标题"),回车
   - 不输入直接回车也行,会用默认消息
7. 脚本自动执行:
   ```
   $ git add .
   $ git commit -m "改副标题"
   $ git push https://your-username:***@github.com/...
   ```
8. 看到:
   ```
   ========================================
     Done! Netlify will deploy in 30s.
     URL: https://my-todo-list.netlify.app
   ========================================

   Press any key to continue . . .
   ```
9. 按任意键关闭窗口

### 脚本原理

`deploy.bat` 内部做了 5 件事:
1. 检查 git/gh 是否安装(没装会报错)
2. 检查代码有没有改动(没改动直接退出)
3. 问你 commit message
4. 执行 `git add . && git commit`
5. 用 `gh auth token` 拿 token 推送到 GitHub

推送后 Netlify 自动接管,30 秒内重新部署。

### ⚠️ 第一次用可能遇到的问题

**问题 1**:报"gh not logged in"
- 你需要先执行一次 `gh auth login`(见[第 7 步](#第-7-步用-github-cli-登录))

**问题 2**:报"fatal: not a git repository"
- 你的目录里没有 `.git`` 文件夹
- 解决:回到[第 8 步](#第-8-步把代码推送到你自己的-github-仓库)重新初始化

---

## 常见错误和解决方法

### 错误 1:推送时报"Permission denied (publickey)"

**原因**:Git 没有正确的凭据

**解决**:
```
gh auth login
```
重新登录一遍。然后:
```
git push
```

### 错误 2:Netlify 部署失败,显示"Build failed"

**原因**:可能是 netlify.toml 配置错或代码语法错

**解决**:
1. 进 Netlify 后台 → 你的站点 → "Deploys" 标签
2. 点最近一次失败的部署 → 看 "Deploy log"
3. 找红色错误信息
4. 把错误信息复制,贴给作者或 AI 助手帮你分析

### 错误 3:推送成功,但网站没更新

**原因**:Netlify 还没构建完,或者浏览器缓存

**解决**:
1. 等 30-60 秒
2. 浏览器按 `Ctrl + Shift + R` 强制刷新
3. 还不行 → 进 Netlify 后台看 Deploys 是否真的成功

### 错误 4:本地双击 index.html 打开是乱码

**原因**:文件编码错(应该是 UTF-8)

**解决**:
1. 用 Notepad++ 打开
2. 顶部菜单 → "编码" → "转为 UTF-8"(不是 UTF-8-BOM)
3. 保存

### 错误 5:deploy.bat 闪一下就消失

**原因**:报错太快,看不到错误

**解决**:
1. 在 `D:\todo-list\` 目录空白处,按住 Shift 右键 → "在此处打开 PowerShell 窗口"
2. 输入 `.\deploy.bat` 回车
3. 这次错误信息会留在窗口里

### 错误 6:git commit 报"Author identity unknown"

**原因**:Git 没配置用户名和邮箱

**解决**:
```
git config --global user.name "your-username"
git config --global user.email "your-email@example.com"
```
然后再 `git commit`。

### 错误 7:gh repo create 报"name already exists"

**原因**:你账号下已经有同名仓库

**解决**:
1. 浏览器打开 https://github.com/your-username?tab=repositories
2. 找到同名仓库 → 进去 → Settings → 拉到底 → "Delete this repository"
3. 重新跑 `gh repo create`

### 错误 8:Netlify 显示"Domain already taken"

**原因**:你想要的 site name 被别人用了

**解决**:
1. Netlify 后台 → Site settings → "Change site name"
2. 改成 `my-todo-list-25198`(加数字/字母后缀)

---

# 第三部分:进阶二次开发

## 代码结构说明

打开 `D:\todo-list\index.html`,你会看到 2079 行代码,但结构清晰:

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>待办事项</title>
    <style>
        /* 这里是所有 CSS 样式(约 1100 行) */
        /* 控制颜色、布局、动画、响应式 */
    </style>
</head>
<body>
    <!-- 这里是 HTML 结构(约 200 行) -->
    <!-- 标题、输入框、列表、矩阵视图、各种弹窗 -->

    <script>
        // 这里是所有 JavaScript 逻辑(约 700 行)
        // 添加任务、勾选、删除、编辑、提醒、保存
    </script>
</body>
</html>
```

### 三块功能速查

| 想改什么 | 改哪里 | 大概在哪一行 |
|---|---|---|
| 颜色、字体、大小 | `<style>` 块 | 13-1100 行 |
| 页面文字、按钮 | `<body>` 块 | 1100-1300 行 |
| 功能逻辑(添加/删除等) | `<script>` 块 | 1300-2079 行 |

---

## 改代码的三种方式

### 方式 A:用 WorkBuddy AI 助手(推荐复杂改动)

1. 打开 WorkBuddy,在项目目录开对话
2. 直接说:"帮我把添加任务的快捷键改成 Ctrl+Enter"
3. AI 帮你改 + 测试 + 推送

**适合**:复杂逻辑、大段代码、不知道从哪改

### 方式 B:手动编辑(适合简单改动)

1. 用 Notepad++ 打开 `index.html`
2. `Ctrl + F` 搜你要改的内容
3. 改完保存
4. 双击 `deploy.bat` 推送

**适合**:改文字、改颜色、改数字

### 方式 C:其他 AI 工具(ChatGPT / Cursor / Copilot)

1. 用其他 AI 帮你写好新的 HTML 代码
2. 复制全部代码
3. 粘贴覆盖 `index.html` 内容
4. 双击 `deploy.bat` 推送

**适合**:你已经有其他 AI 工具的订阅

---

## 调试技巧

### 1. 看浏览器控制台

按 `F12` 打开开发者工具 → "Console" 标签,看到错误信息(红色文字)。

### 2. 改完不显示?强制刷新

按 `Ctrl + Shift + R`(或 `Cmd + Shift + R`),跳过浏览器缓存。

### 3. 改完想撤回?

`Ctrl + Z` 撤销 Notepad++ 里的改动(只要还没保存)。
保存了 → 用 Git 回退(见[下文](#回退错误修改))。

### 4. 想看本地效果再推送

双击 `index.html` 在浏览器看效果,满意了再 push。

### 5. 想模拟手机

按 `F12` → 顶部点 "Toggle device toolbar"(📱 图标) → 选 iPhone 或 Android。

---

## 回退错误修改

### 场景:你改了一行代码,网站崩了,想回到上一个版本

### 操作

1. cmd 进入项目目录:
   ```
   cd /d D:\todo-list
   ```
2. 看历史提交:
   ```
   git log --oneline
   ```
   看到类似:
   ```
   abc1234 改副标题为今日事今日毕    ← 当前
   def5678 添加截止时间功能
   9abcdef Initial commit
   ```
3. 想回到上一个版本 `def5678`:
   ```
   git reset --hard def5678
   ```
4. 强制推送到 GitHub:
   ```
   git push --force
   ```
5. Netlify 30 秒内重新部署上一个版本

### ⚠️ 注意

`git reset --hard` 会**永久丢弃**当前版本之后的所有改动,谨慎使用。

---

## 添加新功能的思路

### 想加新功能?先问自己 3 个问题:

1. **用户做什么操作?**(点击哪里、输入什么)
2. **数据存哪里?**(localStorage 还是新加字段)
3. **界面怎么显示?**(列表里加一行?弹窗?)

### 一些常见功能的方向

| 功能 | 实现思路 |
|---|---|
| 深色模式 | CSS 加 `@media (prefers-color-scheme: dark)` 或加切换按钮 |
| 任务搜索 | 加个搜索框,JS 过滤 todos 数组 |
| 数据导出 | 加个按钮,JS 把 todos 转 JSON,触发下载 |
| 跨设备同步 | 加 Supabase/Firebase 后端 |
| PWA 离线 | 加 `manifest.json` + Service Worker |
| 番茄钟 | 加个计时器组件 |

### 找 AI 帮你实现

直接跟 WorkBuddy(或其他 AI)说:
> "帮我在 todo-list 项目里加一个 XXX 功能,要求 YYY,数据要存在 ZZZ。"

AI 会帮你改代码 + 测试 + 推送。

---

# 第四部分:注意事项

## 数据安全

### 1. 数据存在哪?

- **完全存在浏览器 localStorage 里**
- 不上传任何服务器
- 你的待办内容只有你能看到

### 2. 数据丢失的 3 种情况

| 情况 | 是否丢失 | 怎么避免 |
|---|---|---|
| 关闭浏览器 | ❌ 不丢 | - |
| 重启电脑 | ❌ 不丢 | - |
| 清空浏览器缓存 | ✅ 丢 | 提前导出 |
| 浏览器隐私模式 | ✅ 关窗口就丢 | 别用隐私模式 |
| 换浏览器(Chrome → Edge) | ✅ 丢 | 这是两套 localStorage |
| 换设备(电脑 → 手机) | ✅ 丢 | 这是两套 localStorage |
| 卸载浏览器 | ✅ 丢 | 提前导出 |

### 3. 数据备份建议

定期手动备份:
1. 浏览器按 `F12` → "Application" → "Local Storage" → 你的网站 URL
2. 看到 `todoListData` 这一项,值是一串 JSON
3. 右键 → "Copy value"
4. 粘贴到一个 `.txt` 文件保存

或者:让 AI 帮你做个"导出 JSON"按钮(一次性功能,以后点一下就备份)。

---

## 浏览器兼容性

### 支持的浏览器(测试过)

- ✅ Chrome 90+(推荐)
- ✅ Edge 90+
- ✅ Firefox 90+
- ✅ Safari 14+

### 不支持的浏览器

- ❌ IE 任何版本
- ❌ Chrome 88 以下

### 移动端

- ✅ iOS Safari 14+
- ✅ Android Chrome 90+
- ⚠️ 微信内置浏览器:功能可用但通知提醒可能不工作

---

## 备份策略

### 代码备份(自动)

代码已经在 GitHub 上,即使本地文件丢失,从 GitHub 克隆即可恢复。

### 数据备份(手动)

浏览器 localStorage 数据**不会**自动同步到任何地方,你需要:

**方法 A:导出 JSON 文件**(推荐,让 AI 帮你加这个功能)

**方法 B:浏览器手动备份**

1. F12 → Application → Local Storage → 你的 URL
2. 找 `todoListData` → 复制 value
3. 保存为 `todo-backup-2026-07-18.txt`

---

## 绝对不要做的事

### 1. ❌ 不要直接编辑 GitHub 网页上的代码

虽然 GitHub 网页可以编辑文件,但:
- 中文容易乱码
- 改完可能触发自动部署,出错时本地不一致
- **正确做法**:本地改 → 推送

### 2. ❌ 不要把 `.workbuddy/` 目录上传 GitHub

`.gitignore` 已经排除了这个目录,但如果你手动 `git add` 单个文件时要小心。

### 3. ❌ 不要在公共场所暴露你的 Netlify URL

如果你想私密使用,在 Netlify 后台 → Site settings → "Password protect" 加密码。

### 4. ❌ 不要随便 `git push --force`

会覆盖远端历史。除非你确定要回退,否则不要用。

### 5. ❌ 不要删除 `netlify.toml`

这个文件配置了安全头和缓存策略。删了网站还能跑,但:
- 安全性下降
- 浏览器缓存策略失效(用户看不到最新版本)

### 6. ❌ 不要改 `localStorage` 的 key 名

`todoListData` 这个 key 是写死在代码里的。改了之后,**老用户的所有数据都看不见了**(数据还在,只是读不到)。

### 7. ❌ 不要相信"我改完没测试,直接 push 应该没事"

永远先在本地双击 `index.html` 测试一遍再 push。Netlify 部署失败不致命,但会让访问者看到旧版本或错误页。

---

# 附录 A:完整文件清单

```
D:\todo-list\
├── index.html           # 主入口文件(部署用,72KB,2079 行)
├── todo.html            # 原文件副本(历史保留)
├── netlify.toml         # Netlify 部署配置(安全头 + 缓存)
├── README.md            # 项目说明(给访客看)
├── NETLIFY_DEPLOY.md    # Netlify 部署说明
├── DEVELOPMENT.md       # 二次开发指南
├── FEISHU_GUIDE.md      # 本文档(零基础复刻指南)
├── deploy.bat           # Windows 一键部署脚本
├── deploy.sh            # Mac/Linux 一键部署脚本
├── deploy.py            # Python 跨平台一键部署脚本
└── .gitignore           # Git 排除规则(排除 .workbuddy)
```

---

# 附录 B:命令速查表

| 想做什么 | 命令 |
|---|---|
| 进入项目目录 | `cd /d D:\todo-list` |
| 看改了什么 | `git status` |
| 看历史提交 | `git log --oneline` |
| 暂存所有改动 | `git add .` |
| 提交(带说明) | `git commit -m "说明"` |
| 推送到 GitHub | `git push` |
| 一键部署(推荐) | 双击 `deploy.bat` |
| GitHub 登录 | `gh auth login` |
| 创建仓库并推送 | `gh repo create name --public --source=. --push` |
| 回退到上个版本 | `git reset --hard <commit-id>` + `git push --force` |
| 看 Netlify 部署日志 | 浏览器打开 Netlify → 你的站点 → Deploys |

---

# 附录 C:关键 URL 速查

| 用途 | URL |
|---|---|
| 作者的应用(在线 demo) | https://mu-todo-list.netlify.app |
| 作者的 GitHub 仓库(下载代码) | https://github.com/MU-uu/todo-list |
| GitHub 注册 | https://github.com/signup |
| GitHub CLI 下载 | https://cli.github.com/ |
| Git 下载 | https://git-scm.com/download/win |
| Notepad++ 下载 | https://notepad-plus-plus.org/downloads/ |
| Netlify 注册 | https://app.netlify.com/signup |
| 你的应用 URL | https://[你的-project-name].netlify.app |
| 你的 GitHub 仓库 | https://github.com/[你的用户名]/[你的仓库名] |

---

# 结语

恭喜你读完整篇文档!🎉

如果你严格按本文档操作,你已经拥有:
- ✅ 一个部署在永久 URL 上的 Web 应用
- ✅ 一个 GitHub 仓库,管理代码版本
- ✅ 一套自动化部署流程(改代码 → 推送 → 30 秒自动上线)
- ✅ 一份完整的二次开发指南

接下来你可以:
- 把这个 URL 分享给朋友,展示你的"作品"
- 继续加功能(深色模式、数据导出、跨设备同步……)
- 把这套流程套用到其他静态网站项目(博客、简历、作品集)

**记住一个核心原则**:Netlify 只看 GitHub 仓库的 main 分支。**任何人、任何工具、任何地点改完代码,只要 push 到 main,30 秒后 URL 就是新版本。**

祝你编程愉快!💻
