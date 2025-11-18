@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   教育輔導建議小工具 - PHP 版本
echo ========================================
echo.

REM 檢查 PHP 是否安裝
php -v >nul 2>&1
if errorlevel 1 (
    echo ❌ 錯誤：找不到 PHP
    echo.
    echo 請先安裝 PHP 7.4 或以上版本
    echo.
    echo 選項 1：安裝 XAMPP（推薦）
    echo 下載網址：https://www.apachefriends.org/
    echo.
    echo 選項 2：獨立安裝 PHP
    echo 下載網址：https://windows.php.net/download/
    echo.
    pause
    exit /b 1
)

echo ✅ PHP 已安裝
php -v
echo.

echo ⚠️  請確認已在 my_prompt.php 中設定 OpenAI API Key
echo.

echo 🚀 啟動伺服器...
echo.
echo 📍 請在瀏覽器開啟：http://localhost:8001/index.html
echo.
echo ⚠️  按 Ctrl+C 可停止伺服器
echo.
echo ========================================
echo.

REM 啟動 PHP 內建伺服器
php -S localhost:8001

pause

