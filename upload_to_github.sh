#!/bin/bash

echo "========================================="
echo "  上傳到 GitHub Repository"
echo "========================================="
echo ""

# 檢查是否已經是 git repository
if [ -d ".git" ]; then
    echo "✅ 已經是 Git repository"
else
    echo "📦 初始化 Git repository..."
    git init
fi

echo ""
echo "📝 添加所有檔案..."
git add .

echo ""
echo "📊 檢查狀態..."
git status

echo ""
echo "💾 提交變更..."
git commit -m "Initial commit: 教育輔導建議小工具 - Python & PHP 雙版本"

echo ""
echo "🔗 設定遠端 repository..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/yhlizl/php_simple_assignment.git

echo ""
echo "🌿 設定主分支..."
git branch -M main

echo ""
echo "🚀 推送到 GitHub..."
git push -u origin main --force

echo ""
echo "========================================="
echo "✅ 上傳完成！"
echo "🔗 https://github.com/yhlizl/php_simple_assignment"
echo "========================================="

