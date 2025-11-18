@echo off
chcp 65001 >nul
echo ========================================
echo   🔧 SSL 證書自動修復工具
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

REM 設定證書檔案路徑
set CERT_FILE=%PHP_DIR%cacert.pem
echo 📍 證書檔案位置: %CERT_FILE%
echo.

REM 檢查證書是否已存在
if exist "%CERT_FILE%" (
    echo ✅ 證書檔案已存在
    echo.
) else (
    echo 📥 下載 CA 證書檔案...
    echo.
    
    REM 使用 PowerShell 下載證書
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://curl.se/ca/cacert.pem' -OutFile '%CERT_FILE%'}"
    
    if exist "%CERT_FILE%" (
        echo ✅ 證書下載成功
        echo.
    ) else (
        echo ❌ 證書下載失敗
        echo.
        echo 請手動下載：
        echo 1. 前往：https://curl.se/ca/cacert.pem
        echo 2. 另存新檔到：%CERT_FILE%
        echo.
        pause
        exit /b 1
    )
)

REM 檢查 php.ini
set PHP_INI=%PHP_DIR%php.ini

if exist "%PHP_INI%" (
    echo ✅ 找到 php.ini: %PHP_INI%
    echo.
    
    REM 檢查是否已設定證書
    findstr /C:"curl.cainfo" "%PHP_INI%" >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        echo ℹ️  php.ini 中已有 curl.cainfo 設定
        echo.
        choice /C YN /M "是否要更新設定"
        if %ERRORLEVEL% EQU 2 goto :skip_update
    )
    
    echo 🔧 更新 php.ini...
    echo.
    
    REM 備份 php.ini
    copy "%PHP_INI%" "%PHP_INI%.backup" >nul
    echo ✅ 已備份 php.ini 到 php.ini.backup
    echo.
    
    REM 移除舊的設定（如果有）
    powershell -Command "(Get-Content '%PHP_INI%') | Where-Object {$_ -notmatch 'curl.cainfo' -and $_ -notmatch 'openssl.cafile'} | Set-Content '%PHP_INI%.tmp'"
    move /Y "%PHP_INI%.tmp" "%PHP_INI%" >nul
    
    REM 加入新的設定
    echo. >> "%PHP_INI%"
    echo ; SSL Certificate Settings >> "%PHP_INI%"
    echo curl.cainfo = "%CERT_FILE:\=/%" >> "%PHP_INI%"
    echo openssl.cafile = "%CERT_FILE:\=/%" >> "%PHP_INI%"
    
    echo ✅ php.ini 已更新
    echo.
    
) else (
    echo ⚠️  找不到 php.ini，建立新的...
    echo.
    
    REM 建立新的 php.ini
    echo ; PHP Configuration > "%PHP_INI%"
    echo. >> "%PHP_INI%"
    echo ; Enable cURL >> "%PHP_INI%"
    echo extension=curl >> "%PHP_INI%"
    echo. >> "%PHP_INI%"
    echo ; SSL Certificate Settings >> "%PHP_INI%"
    echo curl.cainfo = "%CERT_FILE:\=/%" >> "%PHP_INI%"
    echo openssl.cafile = "%CERT_FILE:\=/%" >> "%PHP_INI%"
    
    echo ✅ php.ini 已建立
    echo.
)

:skip_update

echo ========================================
echo   ✅ 修復完成！
echo ========================================
echo.
echo 設定內容：
echo   證書檔案: %CERT_FILE%
echo   php.ini: %PHP_INI%
echo.
echo 下一步：
echo   1. 重新啟動 PHP 伺服器
echo   2. 執行：start_php_simple.bat
echo   3. 測試功能
echo.
echo ========================================
echo.

choice /C YN /M "是否要立即啟動 PHP 伺服器"
if %ERRORLEVEL% EQU 1 (
    echo.
    echo 🚀 啟動 PHP 伺服器...
    echo.
    echo 📍 請在瀏覽器開啟：http://localhost:8001/index.html
    echo.
    php -d extension=curl -S localhost:8001
) else (
    echo.
    echo 請手動執行 start_php_simple.bat 啟動伺服器
    echo.
)

pause

