@echo off
chcp 65001 >nul
echo ========================================
echo   🚀 啟動 PHP 伺服器（簡易版）
echo ========================================
echo.
echo 📍 伺服器位址：http://localhost:8001
echo 📍 請在瀏覽器開啟：http://localhost:8001/index.html
echo.
echo ⚠️  注意：
echo    - 不要關閉此視窗
echo    - 按 Ctrl+C 可停止伺服器
echo.
echo ========================================
echo.

REM 使用 -d 參數直接啟用 curl 擴展
php -d extension=curl -S localhost:8001

pause

