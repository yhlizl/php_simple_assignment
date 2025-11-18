@echo off
chcp 65001 >nul
echo ========================================
echo   🔧 cURL 快速修復工具
echo ========================================
echo.

REM 找到 PHP 執行檔位置
for /f "tokens=*" %%i in ('where php') do set PHP_PATH=%%i
echo ✅ PHP 位置: %PHP_PATH%
echo.

REM 取得 PHP 目錄
for %%i in ("%PHP_PATH%") do set PHP_DIR=%%~dpi
echo ✅ PHP 目錄: %PHP_DIR%
echo.

REM 檢查是否有 php.ini-development
if exist "%PHP_DIR%php.ini-development" (
    echo ✅ 找到 php.ini-development
    echo.
    
    REM 詢問是否要建立 php.ini
    choice /C YN /M "是否要從 php.ini-development 建立 php.ini 並啟用 cURL"
    if %ERRORLEVEL% EQU 1 (
        echo.
        echo 📝 建立 php.ini...
        
        REM 複製 php.ini-development 到 php.ini
        copy "%PHP_DIR%php.ini-development" "%PHP_DIR%php.ini"
        
        if exist "%PHP_DIR%php.ini" (
            echo ✅ php.ini 已建立
            echo.
            
            REM 使用 PowerShell 啟用 cURL
            echo 🔧 啟用 cURL 擴展...
            powershell -Command "(Get-Content '%PHP_DIR%php.ini') -replace ';extension=curl', 'extension=curl' | Set-Content '%PHP_DIR%php.ini'"
            
            echo ✅ cURL 已啟用
            echo.
            
            REM 驗證
            echo 🔍 驗證 cURL...
            php -m | findstr /i "curl"
            
            if %ERRORLEVEL% EQU 0 (
                echo.
                echo ========================================
                echo   ✅ 修復成功！
                echo ========================================
                echo.
                echo 現在可以啟動 PHP 伺服器了：
                echo.
                echo 方法一：使用腳本
                echo    雙擊 start_php.bat
                echo.
                echo 方法二：手動啟動
                echo    php -S localhost:8001
                echo.
                echo 然後開啟瀏覽器：
                echo    http://localhost:8001/index.html
                echo.
            ) else (
                echo.
                echo ⚠️  cURL 仍未啟用
                echo 請手動檢查 php.ini 檔案
                echo.
            )
        ) else (
            echo ❌ 建立 php.ini 失敗
            echo.
        )
    ) else (
        echo.
        echo 已取消
        echo.
    )
) else if exist "%PHP_DIR%php.ini-production" (
    echo ✅ 找到 php.ini-production
    echo.
    
    choice /C YN /M "是否要從 php.ini-production 建立 php.ini 並啟用 cURL"
    if %ERRORLEVEL% EQU 1 (
        echo.
        echo 📝 建立 php.ini...
        copy "%PHP_DIR%php.ini-production" "%PHP_DIR%php.ini"
        
        if exist "%PHP_DIR%php.ini" (
            echo ✅ php.ini 已建立
            echo.
            
            echo 🔧 啟用 cURL 擴展...
            powershell -Command "(Get-Content '%PHP_DIR%php.ini') -replace ';extension=curl', 'extension=curl' | Set-Content '%PHP_DIR%php.ini'"
            
            echo ✅ cURL 已啟用
            echo.
            
            echo 🔍 驗證 cURL...
            php -m | findstr /i "curl"
            
            if %ERRORLEVEL% EQU 0 (
                echo.
                echo ========================================
                echo   ✅ 修復成功！
                echo ========================================
                echo.
            ) else (
                echo.
                echo ⚠️  cURL 仍未啟用
                echo.
            )
        )
    )
) else (
    echo ❌ 找不到 php.ini-development 或 php.ini-production
    echo.
    echo 請手動建立 php.ini 檔案：
    echo.
    echo 1. 在 PHP 目錄建立 php.ini 檔案
    echo    位置：%PHP_DIR%php.ini
    echo.
    echo 2. 加入以下內容：
    echo    extension=curl
    echo.
)

echo ========================================
echo.
pause

