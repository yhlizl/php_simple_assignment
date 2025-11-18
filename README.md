# 教育輔導建議小工具

專門給**特教老師**使用的網頁應用程式，可以根據孩子的能力現況，使用 AI 自動產生六大發展向度的教育輔導建議。

## 🎯 主要功能

1. **輸入孩子能力現況** - 老師可以貼上或輸入孩子在六大發展向度的能力描述
2. **AI 自動產生建議** - 使用 OpenAI API 根據能力現況，自動產生給家長和普班老師的具體建議
3. **手動編輯調整** - 可以手動修改 AI 產生的建議內容
4. **匯出整理** - 將所有內容整理成報告格式，方便複製到 Word 或 IEP 文件

## 📋 六大發展向度

- **粗大動作** - 姿勢控制、平衡、球類、跑跳
- **精細動作** - 手部小肌肉、書寫、仿畫
- **認知** - 概念、數概念、問題解決
- **語言** - 理解、表達、構音
- **社會情緒** - 人際互動、情緒調節、規範
- **生活自理** - 如廁、盥洗、整理物品

---

## 🚀 Windows 使用說明

本工具提供兩種後端選擇：**Python (推薦)** 或 **PHP**

---

## 方法一：使用 Python 後端（推薦）⭐

### 前置需求

- **Python 3.8 或以上版本**
  - 下載：https://www.python.org/downloads/
  - 安裝時請勾選「Add Python to PATH」

- **OpenAI API Key**
  - 註冊：https://platform.openai.com/

### 快速啟動（推薦）

#### 1. 檢查環境

雙擊執行 `check_setup.bat`，檢查是否已安裝所有必要元件

#### 2. 設定 API Key

用記事本開啟 `app.py`，找到第 16 行，將 API Key 替換成你的：
```python
API_KEY = os.getenv('OPENAI_API_KEY', 'your-api-key-here')
```

#### 3. 啟動伺服器

雙擊執行 `start_python.bat`

#### 4. 開啟瀏覽器

在瀏覽器輸入網址：`http://localhost:8787`

#### 5. 停止伺服器

在命令提示字元視窗按 `Ctrl + C`

---

### 手動安裝步驟（進階）

#### 1. 安裝 Python 依賴套件

開啟「命令提示字元」(CMD) 或 「PowerShell」，切換到專案資料夾：

```cmd
cd C:\path\to\your\project
```

安裝依賴套件：

```cmd
pip install -r requirements.txt
```

#### 2. 設定 OpenAI API Key

**方法 A：直接修改程式碼（簡單）**

1. 用記事本或任何文字編輯器開啟 `app.py`
2. 找到第 16 行：
   ```python
   API_KEY = os.getenv('OPENAI_API_KEY', 'sk-proj-...')
   ```
3. 將 `'sk-proj-...'` 替換成你的 OpenAI API Key

**方法 B：使用環境變數（安全）**

在命令提示字元執行：
```cmd
set OPENAI_API_KEY=your-openai-api-key-here
```

#### 3. 啟動伺服器

在命令提示字元執行：

```cmd
python app.py
```

看到以下訊息表示成功：
```
🚀 教育輔導建議小工具後端啟動中...
📍 請在瀏覽器開啟: http://localhost:8787
```

#### 4. 開啟瀏覽器

在瀏覽器輸入網址：
```
http://localhost:8787
```

#### 5. 停止伺服器

在命令提示字元按 `Ctrl + C`

---

## 方法二：使用 PHP 後端

### 前置需求

- **PHP 7.4 或以上版本**
  - 下載：https://windows.php.net/download/
  - 或安裝 XAMPP：https://www.apachefriends.org/

- **OpenAI API Key**

### 快速啟動（推薦）

#### 1. 安裝 PHP

推薦安裝 XAMPP（包含 PHP）：https://www.apachefriends.org/

#### 2. 設定 API Key

用記事本開啟 `my_prompt.php`，找到第 20 行，將 API Key 替換成你的：
```php
$apiKey = 'your-api-key-here';
```

#### 3. 修改前端 API 路徑

用記事本開啟 `index.html`，找到第 606 行，改成：
```javascript
const res = await fetch('my_prompt.php', {
```

#### 4. 啟動伺服器

雙擊執行 `start_php.bat`

#### 5. 開啟瀏覽器

在瀏覽器輸入網址：`http://localhost:8000/index.html`

#### 6. 停止伺服器

在命令提示字元視窗按 `Ctrl + C`

---

### 手動安裝步驟（進階）

#### 1. 安裝 PHP

**選項 A：使用 XAMPP（推薦給初學者）**

1. 下載並安裝 XAMPP
2. 安裝完成後，PHP 會自動安裝在 `C:\xampp\php\`

**選項 B：獨立安裝 PHP**

1. 下載 PHP ZIP 檔案
2. 解壓縮到 `C:\php\`
3. 將 `C:\php\` 加入系統環境變數 PATH

#### 2. 設定 OpenAI API Key

1. 用記事本開啟 `my_prompt.php`
2. 找到第 20 行：
   ```php
   $apiKey = 'sk-proj-...';
   ```
3. 將 `'sk-proj-...'` 替換成你的 OpenAI API Key

#### 3. 修改前端 API 路徑

1. 用記事本開啟 `index.html`
2. 找到第 606 行：
   ```javascript
   const res = await fetch('http://localhost:8787/api/generate', {
   ```
3. 改成：
   ```javascript
   const res = await fetch('my_prompt.php', {
   ```

#### 4. 啟動 PHP 內建伺服器

開啟命令提示字元，切換到專案資料夾：

```cmd
cd C:\path\to\your\project
```

啟動伺服器：

```cmd
php -S localhost:8000
```

#### 5. 開啟瀏覽器

在瀏覽器輸入網址：
```
http://localhost:8000/index.html
```

#### 6. 停止伺服器

在命令提示字元按 `Ctrl + C`

---

## 📝 使用流程

1. 在「孩子能力現況」欄位輸入或貼上孩子的能力描述
2. 點擊「🤖 用 AI 產生建議」按鈕
3. AI 會自動填入六大向度的建議（分別給家長和普班老師）
4. 可以手動調整任何建議內容
5. 點擊「✨ 生成整理結果」將所有內容整理成報告格式
6. 點擊「📋 複製整理結果」複製到剪貼簿，貼到 Word 或其他文件

---

## 🔧 常見問題 (FAQ)

### Q1: 如何確認 Python 是否安裝成功？

開啟命令提示字元，輸入：
```cmd
python --version
```
如果顯示版本號（例如 `Python 3.11.0`），表示安裝成功。

### Q2: 如何確認 PHP 是否安裝成功？

開啟命令提示字元，輸入：
```cmd
php -v
```
如果顯示版本號（例如 `PHP 8.2.0`），表示安裝成功。

### Q3: 出現「pip 不是內部或外部命令」錯誤

這表示 Python 沒有正確加入 PATH。解決方法：
1. 重新安裝 Python，記得勾選「Add Python to PATH」
2. 或手動將 Python 安裝路徑加入系統環境變數

### Q4: 出現「ModuleNotFoundError: No module named 'flask'」錯誤

表示沒有安裝依賴套件，請執行：
```cmd
pip install -r requirements.txt
```

### Q5: AI 產生建議時出現錯誤

請檢查：
1. OpenAI API Key 是否正確設定
2. 網路連線是否正常
3. OpenAI 帳號是否有足夠額度

### Q6: 瀏覽器無法開啟網頁

請確認：
1. 伺服器是否正常啟動（命令提示字元沒有錯誤訊息）
2. 網址是否正確（Python: `http://localhost:8787`，PHP: `http://localhost:8000/index.html`）
3. 防火牆是否阻擋連線

### Q7: 如何在其他電腦上使用？

1. 將整個專案資料夾複製到其他電腦
2. 在該電腦上重複安裝步驟
3. 或者將 `app.py` 中的 `host='0.0.0.0'` 改為區域網路 IP，讓其他電腦連線

### Q8: XAMPP 安裝不起來怎麼辦？

**最佳解決方案：改用 Python 版本！**

Python 版本更簡單，不需要 XAMPP：
1. 安裝 Python（https://www.python.org/downloads/）
2. 雙擊 `start_python.bat`
3. 完成！

**其他替代方案：**
- 獨立安裝 PHP（不需要 XAMPP）
- 使用 WampServer 或 Laragon（XAMPP 替代品）

詳細說明請參考：`XAMPP替代方案.txt`

---

## 📁 檔案說明

### Python 版本
- **app.py** - Python Flask 後端伺服器（Port 8787）
- **requirements.txt** - Python 依賴套件清單
- **start_python.bat** - Windows 啟動腳本（Python）
- **start.sh** - Linux/Mac 啟動腳本

### PHP 版本
- **my_prompt.php** - PHP 後端 API
- **start_php.bat** - Windows 啟動腳本（PHP）

### 共用檔案
- **index.html** - 前端網頁介面
- **check_setup.bat** - Windows 環境檢查工具
- **快速開始.txt** - 快速開始指南
- **.env.example** - 環境變數範例檔案
- **測試一.json** / **測試二.json** - JSON 格式範例檔案
- **README.md** - 本說明文件

---

## 🔧 技術架構

### Python 版本（推薦）
- **前端**: HTML + CSS + JavaScript (Vanilla JS)
- **後端**: Python Flask
- **AI 模型**: OpenAI GPT-4o-mini
- **Port**: 8787

### PHP 版本
- **前端**: HTML + CSS + JavaScript (Vanilla JS)
- **後端**: PHP (內建伺服器)
- **AI 模型**: OpenAI GPT-4o-mini
- **Port**: 8000

---

## ⚠️ 注意事項

1. **API Key 安全性**
   - 不要將含有 API Key 的檔案上傳到公開的 GitHub 或其他平台
   - 建議使用環境變數設定 API Key

2. **模型選擇**
   - Python 版本：可在 `app.py` 第 73 行修改模型
   - PHP 版本：可在 `my_prompt.php` 第 53 行修改模型
   - 可用模型：`gpt-4o-mini`, `gpt-4o`, `gpt-4-turbo` 等

3. **費用**
   - 每次呼叫 AI 會消耗 OpenAI API 額度
   - 建議在 OpenAI 帳號設定用量限制

4. **網路需求**
   - 需要穩定的網路連線才能呼叫 OpenAI API
   - 如果網路不穩定，可能會導致請求失敗

---

## 📞 技術支援

如有問題，請檢查：
1. 本 README 的常見問題章節
2. 命令提示字元的錯誤訊息
3. 瀏覽器的開發者工具 Console (按 F12)

---

## 📄 授權

此專案僅供教育用途使用。

