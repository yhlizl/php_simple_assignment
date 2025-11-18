@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   教育輔導建議小工具 - Python 版本
echo ========================================
echo.

REM 檢查 Python 是否安裝
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 錯誤：找不到 Python
    echo.
    echo 請先安裝 Python 3.8 或以上版本
    echo 下載網址：https://www.python.org/downloads/
    echo.
    echo 安裝時請記得勾選「Add Python to PATH」
    echo.
    pause
    exit /b 1
)

echo ✅ Python 已安裝
python --version
echo.

REM 檢查是否已安裝依賴套件
python -c "import flask" >nul 2>&1
if errorlevel 1 (
    echo 📦 正在安裝依賴套件...
    echo.
    pip install -r requirements.txt
    if errorlevel 1 (
        echo.
        echo ❌ 安裝依賴套件失敗
        echo.
        pause
        exit /b 1
    )
    echo.
    echo ✅ 依賴套件安裝完成
    echo.
)

REM 檢查環境變數
if "%OPENAI_API_KEY%"=="" (
    echo ⚠️  警告：未設定 OPENAI_API_KEY 環境變數
    echo.
    echo 請確認已在 app.py 中設定 API Key
    echo 或執行以下命令設定環境變數：
    echo set OPENAI_API_KEY=your-api-key-here
    echo.
)

echo 🚀 啟動伺服器...
echo.
echo 📍 請在瀏覽器開啟：http://localhost:8787
echo.
echo ⚠️  按 Ctrl+C 可停止伺服器
echo.
echo ========================================
echo.

REM 啟動 Python 伺服器
python app.py

pause

