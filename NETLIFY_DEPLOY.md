# Netlify 部署说明

## 已自动完成的部分
- ✅ 仓库已推送到 GitHub:`https://github.com/MU-uu/todo-list`
- ✅ `netlify.toml` 已配置(发布目录、安全头、缓存策略)
- ✅ CloudStudio 沙箱已部署(临时)

## 还需要你做一次(约 2 分钟)
Netlify 一次性关联 GitHub 仓库,之后 `git push` 就会自动部署。

### 步骤

1. **打开 Netlify 注册页**:https://app.netlify.com/signup
   - 直接选 **"Sign up with GitHub"**,用你的 GitHub 账号登录

2. **导入项目**:登录后点 **"Add new site" → "Import an existing project"**
   - 选 **"Deploy with GitHub"**
   - 授权 Netlify 访问 GitHub
   - 搜索并选 **`MU-uu/todo-list`** 仓库

3. **配置构建设置**(Netlify 通常会**自动识别**,无需改):
   - **Base directory**:留空
   - **Build command**:留空(纯静态)
   - **Publish directory**:`.`(或留空,netlify.toml 里已写)
   - 点 **"Deploy site"**

4. **等待 30-60 秒**,部署完成后 Netlify 给一个 URL,比如:
   - `https://xxx-random-123.netlify.app`
   - 这个 URL **永久有效**,全球 CDN,自动 HTTPS

5. **(可选)改域名**:在 Netlify 后台点 "Site settings" → "Change site name",改成你想要的名字,比如 `mu-todo-list.netlify.app`

## 之后怎么更新?

直接在本地改 `index.html`,然后:
```bash
git add .
git commit -m "update"
git push
```

Netlify 会在 30 秒内自动重新部署,URL 不变。

## 注意事项
- Netlify 公开仓库免费版**无限流量、无限带宽、CDN 全球加速**
- 数据仍存浏览器 localStorage(在 Netlify 上看到的是空清单,你本地浏览器有自己的)
- 如果想要数据跨设备同步,需要后端,可后续加 Supabase/Firebase
