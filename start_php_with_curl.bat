@echo off
chcp 65001 >nul
echo ========================================
echo   🚀 啟動 PHP 伺服器（自動啟用 cURL）
echo ========================================
echo.

REM 檢查 PHP 是否已安裝
where php >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 找不到 PHP！
    echo.
    echo 請先安裝 PHP：
    echo 1. 前往：https://windows.php.net/download/
    echo 2. 下載 Thread Safe 版本
    echo 3. 解壓縮並加入 PATH
    echo.
    pause
    exit /b 1
)

echo ✅ PHP 已安裝
php --version
echo.

REM 檢查 cURL 是否已啟用
echo 🔍 檢查 cURL 擴展...
php -m | findstr /i "curl" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo ✅ cURL 已啟用
    echo.
    goto :start_server
)

echo ⚠️  cURL 未啟用
echo.

REM 嘗試找到 php.ini
echo 🔍 尋找 php.ini...
for /f "tokens=*" %%i in ('php --ini ^| findstr "Loaded Configuration File"') do set INI_LINE=%%i
echo %INI_LINE%
echo.

REM 提示用戶
echo ========================================
echo   ⚠️  需要啟用 cURL
echo ========================================
echo.
echo 請按照以下步驟操作：
echo.
echo 1. 執行以下命令查看 php.ini 位置：
echo    php --ini
echo.
echo 2. 用記事本開啟 php.ini
echo.
echo 3. 找到這一行（按 Ctrl+F 搜尋）：
echo    ;extension=curl
echo.
echo 4. 移除前面的分號改成：
echo    extension=curl
echo.
echo 5. 儲存檔案
echo.
echo 6. 重新執行此腳本
echo.
echo ========================================
echo   或使用 Python 後端（更簡單）
echo ========================================
echo.
echo 1. 執行：start_python.bat
echo 2. 開啟：http://localhost:8787
echo.
echo ========================================
echo.

REM 詢問是否要開啟測試工具
choice /C YN /M "是否要執行 cURL 測試工具"
if %ERRORLEVEL% EQU 1 (
    echo.
    echo 執行測試工具...
    php test_curl.php
    echo.
)

pause
exit /b 1

:start_server
echo ========================================
echo   🚀 啟動 PHP 伺服器
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

REM 啟動伺服器
php -S localhost:8001

pause

