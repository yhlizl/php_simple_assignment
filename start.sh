#!/bin/bash

echo "🚀 教育輔導建議小工具 - 啟動中..."
echo ""

# 檢查是否已安裝依賴
if ! python3 -c "import flask" 2>/dev/null; then
    echo "📦 正在安裝依賴套件..."
    pip3 install -r requirements.txt
    echo ""
fi

# 檢查環境變數
if [ -z "$OPENAI_API_KEY" ]; then
    echo "⚠️  警告: 未設定 OPENAI_API_KEY 環境變數"
    echo "   請執行: export OPENAI_API_KEY='your-api-key'"
    echo "   或直接修改 app.py 中的 API_KEY"
    echo ""
fi

# 啟動伺服器
echo "🌐 啟動伺服器於 http://localhost:8787"
echo "   按 Ctrl+C 停止伺服器"
echo ""

python3 app.py

