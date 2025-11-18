@echo off
chcp 65001 >nul
echo.
echo =========================================
echo   上傳到 GitHub Repository
echo =========================================
echo.

REM 檢查 git 是否安裝
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 錯誤：找不到 Git
    echo.
    echo 請先安裝 Git for Windows
    echo 下載網址：https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo ✅ Git 已安裝
git --version
echo.

REM 檢查是否已經是 git repository
if exist ".git" (
    echo ✅ 已經是 Git repository
) else (
    echo 📦 初始化 Git repository...
    git init
)

echo.
echo 📝 添加所有檔案...
git add .

echo.
echo 📊 檢查狀態...
git status

echo.
echo 💾 提交變更...
git commit -m "Initial commit: 教育輔導建議小工具 - Python & PHP 雙版本"

echo.
echo 🔗 設定遠端 repository...
git remote remove origin 2>nul
git remote add origin https://github.com/yhlizl/php_simple_assignment.git

echo.
echo 🌿 設定主分支...
git branch -M main

echo.
echo 🚀 推送到 GitHub...
echo ⚠️  如果需要登入，請輸入你的 GitHub 帳號密碼
echo.
git push -u origin main --force

echo.
echo =========================================
echo ✅ 上傳完成！
echo 🔗 https://github.com/yhlizl/php_simple_assignment
echo =========================================
echo.

pause

