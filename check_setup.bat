@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   環境檢查工具
echo ========================================
echo.

set ERROR_COUNT=0

REM 檢查 Python
echo [1/4] 檢查 Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python 未安裝
    echo    下載：https://www.python.org/downloads/
    set /a ERROR_COUNT+=1
) else (
    echo ✅ Python 已安裝
    python --version
)
echo.

REM 檢查 PHP
echo [2/4] 檢查 PHP...
php -v >nul 2>&1
if errorlevel 1 (
    echo ⚠️  PHP 未安裝（如果使用 Python 版本可忽略）
    echo    下載：https://www.apachefriends.org/
) else (
    echo ✅ PHP 已安裝
    php -v | findstr /C:"PHP"
)
echo.

REM 檢查 Python 依賴套件
echo [3/4] 檢查 Python 依賴套件...
python -c "import flask" >nul 2>&1
if errorlevel 1 (
    echo ❌ Flask 未安裝
    echo    執行：pip install -r requirements.txt
    set /a ERROR_COUNT+=1
) else (
    echo ✅ Flask 已安裝
)

python -c "import flask_cors" >nul 2>&1
if errorlevel 1 (
    echo ❌ flask-cors 未安裝
    echo    執行：pip install -r requirements.txt
    set /a ERROR_COUNT+=1
) else (
    echo ✅ flask-cors 已安裝
)

python -c "import openai" >nul 2>&1
if errorlevel 1 (
    echo ❌ openai 未安裝
    echo    執行：pip install -r requirements.txt
    set /a ERROR_COUNT+=1
) else (
    echo ✅ openai 已安裝
)
echo.

REM 檢查 API Key
echo [4/4] 檢查 OpenAI API Key...
if "%OPENAI_API_KEY%"=="" (
    echo ⚠️  環境變數未設定（可在程式碼中設定）
    echo    執行：set OPENAI_API_KEY=your-api-key
) else (
    echo ✅ 環境變數已設定
)
echo.

REM 總結
echo ========================================
echo   檢查完成
echo ========================================
echo.

if %ERROR_COUNT% EQU 0 (
    echo ✅ 所有必要元件都已就緒！
    echo.
    echo 請執行以下檔案啟動伺服器：
    echo   - Python 版本：start_python.bat
    echo   - PHP 版本：start_php.bat
) else (
    echo ❌ 發現 %ERROR_COUNT% 個問題，請先解決後再啟動
)
echo.
echo ========================================
echo.

pause

