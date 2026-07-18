# 四象限待办清单 · 完整项目流程文档

> 本文档记录从"用户提出需求"到"应用上线长期服务"的完整流程,作为项目复盘和后续维护的参考。

---

## 一、项目概述

### 1.1 项目定位

**一个基于四象限法(Eisenhower Matrix)的待办事项管理 Web 应用**,纯前端实现,数据保存在浏览器 localStorage。

### 1.2 核心功能

- **四象限优先级管理**:重要·紧急 / 重要·不紧急 / 紧急·不重要 / 不重要·不紧急
- **视图切换**:列表视图 ↔ 四象限矩阵视图
- **筛选**:全部 / 未完成 / 已完成(两个视图同步)
- **截止时间 + 提醒**:设置年月日时分,自定义提前提醒时长(0/5/15/30 分钟,1/2 小时,1 天),系统通知 + UI 标签
- **编辑任务**:双击文字即可编辑,Enter 保存 / Esc 取消
- **排序**:每个任务配 ↑↓ 按钮,首末项自动禁用
- **优先级修改**:点击 ⚑ 旗标即可改优先级
- **拖动友好**:完整响应式(1200 / 900 / 600px 三档断点)
- **本地存储**:数据写入 `localStorage`,刷新不丢

### 1.3 技术栈

- 纯 HTML + CSS + JavaScript
- 无框架、无依赖、无后端
- 单文件应用(所有代码在 `index.html` 内,约 2079 行)
- 部署:Netlify(全球 CDN + 自动 HTTPS)
- 版本管理:GitHub
- 协作:Git + GitHub CLI(`gh`)

---

## 二、关键里程碑

| 阶段 | 时间 | 关键产出 |
|---|---|---|
| 需求提出 | 2026-07-18 13:41 | 用户要求做待办应用,提出 3 项功能需求 + 3 项界面要求 + 3 项技术要求 |
| MVP 完成 | 2026-07-18 13:42 | 第一版 `todo.html`(输入/勾选/删除/统计/localStorage) |
| 视觉优化 | 同日 | 调整占位符、按钮文案、标题摇摆动效、背景渐变、删除确认弹窗 |
| Bug 修复 | 同日 | 修复原生 `confirm` 被拦截问题,改为自建模态弹窗 |
| 拖拽功能 | 同日 | 添加任务拖拽排序(列表视图 + 跨象限拖拽) |
| 截止时间 | 同日 | 截止时间设置 + 浏览器通知提醒 |
| 拖拽回退 | 同日 | 用户要求移除拖拽,改用 ↑↓ 按钮(非拖拽方式) |
| 布局优化 | 16:40 | 容器 560px → 1200px,修复中文拆字 bug |
| 部署上线 | 16:43 | 推送 GitHub 仓库 + CloudStudio 沙箱部署 |
| Netlify 永久部署 | 17:08 | 走 Netlify UI 关联 GitHub,获取永久 URL |
| 沙箱注销 | 17:21 | 公开文档清理 CloudStudio 引用,等平台自动回收 |
| 一键部署脚本 | 17:28 | 提供 deploy.bat / deploy.sh / deploy.py 三个跨平台脚本 |
| 飞书文档 | 17:37 | 整理完整流程文档供归档 |

---

## 三、完整开发流程

### 3.1 本地开发

```
项目根目录:E:\Work Buddy Project\To Do list\
├── index.html              # 主入口(部署用,72KB)
├── todo.html               # 原始文件副本
├── netlify.toml            # 部署配置(安全头 + 缓存)
├── README.md               # 项目说明
├── NETLIFY_DEPLOY.md       # 部署说明
├── DEVELOPMENT.md          # 二次开发指南
├── deploy.bat              # Windows 一键部署
├── deploy.sh               # Mac/Linux 一键部署
├── deploy.py               # Python 跨平台一键部署
├── .gitignore              # Git 排除规则
└── .workbuddy/             # 内部工作数据(不进 Git)
    └── memory/             # 项目工作记忆
```

### 3.2 核心代码逻辑

**状态模型**(JS 端):

```javascript
// 任务对象
{
  id: Date.now() + Math.random().toString(36).slice(2, 8),
  text: "任务内容",
  completed: false,                        // 是否完成
  priority: "urgent-important" | null,     // 四象限优先级
  createdAt: Date.now(),                   // 创建时间
  dueTime: "2026-07-20T14:00" | null,      // 截止时间(ISO)
  remindBefore: 30,                        // 提前提醒分钟数
  notified: false                          // 是否已提醒
}

// 全局状态
let todos = [];                            // 所有任务
let currentFilter = 'all';                 // 全部/未完成/已完成
let currentView = 'list';                  // 列表/矩阵
let selectedPriority = '';                 // 临时优先级
let pendingDueTime = null;                 // 临时截止
let pendingRemindBefore = 0;               // 临时提醒
let reminderTimers = new Map();            // 提醒定时器
```

**关键函数**:

| 函数 | 职责 |
|---|---|
| `addTodo()` | 主入口:校验 → 弹优先级 → 弹截止询问 → commit |
| `commitAddTodo()` | 实际写入:创建对象 → 保存 → render → 重置 |
| `renderList()` / `renderMatrix()` | 两个视图的渲染 |
| `toggleTodo(id)` | 切换完成态 |
| `deleteTodo(id)` | 删除(带确认弹窗) |
| `startEdit(item)` | 启动编辑(双击触发) |
| `showPriorityPicker({editTaskId})` | 优先级选择弹窗(添加/修改两用) |
| `showDuePicker(taskId, opts)` | 截止时间弹窗 |
| `scheduleReminders()` | 调度所有提醒 |
| `moveTodoInList(filtered, idx, dir)` | 排序核心逻辑 |
| `saveAndRender()` | localStorage 写入 + 重新渲染 |

### 3.3 设计决策记录

**为什么用 localStorage 而不上后端?**
- 用户最初要求"刷新页面不丢失",localStorage 最简单
- 单用户使用,无跨设备同步需求
- 后续可加 Supabase/Firebase 做云同步(架构已留好接口)

**为什么用四象限法?**
- 用户后续要求,科学的时间管理框架
- 视觉上比纯列表更直观,优先级一眼可见
- 矩阵视图的 4 个颜色块直接对应 Eisenhower Matrix 经典布局

**为什么去掉拖拽?**
- 用户多次反馈"拖拽位置不准确"、"指示线跟手不同步"
- 改用 ↑↓ 按钮:简单、可控、移动端友好
- 经验教训:做交互前先用文字/截图描述方案,避免迭代 3 次还要回退

**为什么容器宽度从 560px 扩到 1200px?**
- 中文任务文字被 `word-break: break-word` 逐字拆开("市/场/份/额/吃/饭"竖排)
- 根因:flex 默认 `min-width: auto` 不允许压缩 + 容器太窄
- 修复:`min-width: 0` + `overflow-wrap: anywhere` + 容器扩到 1200px

**为什么用 Netlify 而不用 CloudStudio?**
- CloudStudio 沙箱:临时、平台自动回收
- Netlify:永久、CDN、自动 HTTPS、git push 自动部署
- CloudStudio 适合 demo,Netlify 适合 production

---

## 四、部署架构

### 4.1 整体流程

```
[本地修改]
    ↓
[git commit]
    ↓
[git push to GitHub: MU-uu/todo-list]
    ↓
[Netlify 检测到 main 分支变化]
    ↓
[自动构建:读取 netlify.toml 配置]
    ↓
[部署到全球 CDN 边缘节点]
    ↓
[公开 URL: https://mu-todo-list.netlify.app]
    ↓
[用户访问,得到最新版本]
```

**关键点:Netlify 部署只跟 GitHub 仓库挂钩,跟谁/在哪/用什么工具改代码完全无关。**

### 4.2 netlify.toml 配置

```toml
[build]
  publish = "."

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "no-referrer-when-downgrade"
    Cache-Control = "public, max-age=300"

[[headers]]
  for = "/index.html"
  [headers.values]
    Cache-Control = "no-cache"
```

### 4.3 关键 URL

| 资源 | URL |
|---|---|
| 在线应用(主) | https://mu-todo-list.netlify.app |
| GitHub 仓库 | https://github.com/MU-uu/todo-list |
| CloudStudio 沙箱(临时) | https://81c2613057d44e4abda4eee66d998ab3.app.codebuddy.work |
| 开发文档 | https://mu-todo-list.netlify.app/DEVELOPMENT.md |

---

## 五、二次开发指南

### 5.1 三种改代码路径

| 路径 | 工具 | 适合 |
|---|---|---|
| A | WorkBuddy AI 助手 | 复杂逻辑、大段代码 |
| B | 手动编辑 + 一键脚本 | 简单修改(改文字、改颜色) |
| C | 其他 AI(ChatGPT/Cursor/Copilot) | 跨工具协作 |

### 5.2 一键部署脚本使用

**Windows(本项目主用):**

```bash
# 双击项目根目录的 deploy.bat
# 或命令行:
deploy.bat
```

脚本自动:
1. 检测 git/gh 是否安装
2. 检测代码改动
3. 询问 commit message
4. `git add . && git commit`
5. 用 gh token 推送
6. Netlify 30 秒内自动部署

### 5.3 在新电脑首次配置

```bash
# 1. 装好 git + GitHub CLI
winget install GitHub.cli        # Windows
brew install gh                  # Mac
sudo apt install gh              # Linux

# 2. 登录 GitHub
gh auth login

# 3. 克隆仓库
git clone https://github.com/MU-uu/todo-list.git
cd todo-list

# 4. 双击 deploy.bat 测试
```

---

## 六、避坑清单(经验总结)

### 6.1 CSS 陷阱

- **`word-break: break-word` 对中文会逐字拆行** → 用 `min-width: 0` + `overflow-wrap: anywhere`
- **flex item 默认 `min-width: auto` 不允许收缩** → 显式 `min-width: 0` 才能 wrap
- **彩色 emoji 不受 CSS color 控制** → 按钮内用 ASCII 字符或 inline SVG

### 6.2 浏览器陷阱

- **原生 `confirm/alert/prompt` 在受限环境被静默拦截** → 改用自建 modal
- **HTML5 native drag 在 iOS Safari 不支持** → 移动端拖拽体验差
- **`hidden` 元素仍可被 `querySelector` 命中** → 多视图应用传 DOM 引用而非 ID
- **`dragover` 触发频率太低(100-200ms)** → 用 `document.mousemove` 实时跟手

### 6.3 部署陷阱

- **CloudStudio 沙箱 verified=false** → 正常,沙盒环境不需要验证
- **gh token scope 需含 `repo`** → 才能创建仓库和推送
- **git 没存凭据时 push 失败** → 用 `TOKEN=$(gh auth token) && git push https://MU-uu:${TOKEN}@...`
- **单向上传工具没 destroy 接口** → 想停掉就等平台自动回收

### 6.4 交互设计陷阱

- **拖拽定位语义不一致** → "找最近 item" 和 "插在某 item 之后" 必须用同一套逻辑
- **多视图数据范围应该统一** → 列表/矩阵筛选语义一致,别造"为啥矩阵里看到的比列表多"的疑问
- **弹窗链要明确每一步的"保存"语义** → 一个弹窗被多处调用时,行为要可参数化

---

## 七、技术亮点

### 7.1 单文件应用
- 72KB 一个 HTML 包含完整应用
- 部署只需这一个文件
- 任何静态托管服务都支持

### 7.2 零依赖
- 不引任何外部 JS/CSS 库
- 纯原生 API(localStorage / Notification / setTimeout)
- 加载速度快(< 100ms)

### 7.3 数据安全
- 数据完全本地化,不离开用户浏览器
- 跨设备隔离:file:// 协议和 https:// 协议各有独立 localStorage
- 部署平台永远看不到用户数据

### 7.4 自动化 CI/CD
- 推送 → 部署:全自动,30 秒
- 失败时 Netlify 会邮件通知
- URL 永久不变

---

## 八、后续可能扩展方向

- **PWA**:支持"添加到主屏幕",离线可用
- **数据同步**:Supabase / Firebase 跨设备同步
- **数据导入导出**:JSON 文件,方便备份
- **任务搜索/标签**
- **深色模式**
- **番茄钟**
- **多人协作**(需要后端)

---

## 九、参考资料

- **Netlify 文档**:https://docs.netlify.com/
- **GitHub CLI 文档**:https://cli.github.com/manual/
- **Eisenhower Matrix**:https://en.wikipedia.org/wiki/Time_management#The_Eisenhower_method
- **localStorage API**:https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
- **Notification API**:https://developer.mozilla.org/en-US/docs/Web/API/Notification

---

## 附录:关键 commit 记录

| Commit | 说明 |
|---|---|
| `3c6619e` | Initial commit:四象限待办清单应用 |
| `25a1f67` | 添加 Netlify 部署配置 |
| `853e0ab` | 清理文档:移除 CloudStudio 沙箱引用 |
| `2091bad` | 添加 DEVELOPMENT.md:二次开发完整工作流 |
| `d43073a` | 添加协作开发指南 + 一键部署脚本 |
