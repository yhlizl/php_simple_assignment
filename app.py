#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
教育輔導建議小工具 - Python 後端
使用 Flask + OpenAI API
"""

from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import os
import json
import re
from openai import OpenAI

app = Flask(__name__)
CORS(app)  # 允許跨域請求

# 設定 OpenAI API Key（建議使用環境變數）
# 請將 'your-openai-api-key-here' 替換成你的 OpenAI API Key
API_KEY = os.getenv('OPENAI_API_KEY', 'your-openai-api-key-here')
client = OpenAI(api_key=API_KEY)

# System Prompt
SYSTEM_PROMPT = """你是一位在台灣服務的特教老師，熟悉融合教育與早療、特教團隊合作。
請根據「孩子能力現況」段落，分別為六大發展向度：
粗大動作、精細動作、認知、語言、社會情緒、生活自理，
各寫出兩組建議：
- 一組是「給家長的建議」（parent）
- 一組是「給普班老師的建議」（teacher）

***非常重要：***
1. 用「繁體中文」書寫。
2. 每個建議可以是一段話，但要具體、可操作，避免太空泛。
3. 不要重複描述能力現況，而是轉換成教養/教學策略。
4. 一定要輸出「純 JSON」，格式如下，不能加任何說明文字、標題或註解：

{
  "粗大動作": { "parent": "給家長的建議內容", "teacher": "給普班老師的建議內容" },
  "精細動作": { "parent": "...", "teacher": "..." },
  "認知":     { "parent": "...", "teacher": "..." },
  "語言":     { "parent": "...", "teacher": "..." },
  "社會情緒": { "parent": "...", "teacher": "..." },
  "生活自理": { "parent": "...", "teacher": "..." }
}"""


@app.route('/')
def index():
    """提供首頁"""
    return send_from_directory('.', 'index.html')


@app.route('/<path:path>')
def static_files(path):
    """提供靜態檔案"""
    return send_from_directory('.', path)


@app.route('/api/generate', methods=['POST'])
def generate_suggestions():
    """AI 產生建議的 API 端點"""
    try:
        # 1. 讀取前端送來的 JSON
        data = request.get_json()
        
        if not data or 'profile' not in data or not data['profile'].strip():
            return jsonify({
                'success': False,
                'message': '缺少 profile 內容'
            }), 400
        
        profile = data['profile'].strip()
        
        # 2. 組出要丟給 OpenAI 的訊息
        user_prompt = f"孩子能力現況如下：\n{profile}"
        
        # 3. 呼叫 OpenAI Chat Completions API
        response = client.chat.completions.create(
            model='gpt-4o-mini',  # 或 'gpt-4o-mini'
            messages=[
                {'role': 'system', 'content': SYSTEM_PROMPT},
                {'role': 'user', 'content': user_prompt}
            ],
            temperature=0.4,
            max_tokens=800
        )
        
        # 4. 解析 OpenAI 回傳
        content = response.choices[0].message.content.strip()
        
        # 有時模型會在 JSON 外多加換行或 markdown，這裡試著抓出第一個 { 到最後一個 } 之間的內容
        match = re.search(r'\{.*\}', content, re.DOTALL)
        if match:
            content = match.group(0)
        
        # 5. 解析 JSON
        try:
            suggestions = json.loads(content)
        except json.JSONDecodeError as e:
            return jsonify({
                'success': False,
                'message': f'模型回傳的 JSON 格式錯誤：{content}'
            }), 500
        
        # 6. 回傳給前端
        return jsonify({
            'success': True,
            'suggestions': suggestions
        })
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'伺服器錯誤：{str(e)}'
        }), 500


if __name__ == '__main__':
    print('🚀 教育輔導建議小工具後端啟動中...')
    print('📍 請在瀏覽器開啟: http://localhost:8787')
    print('⚠️  請確認已設定 OPENAI_API_KEY 環境變數')
    app.run(host='0.0.0.0', port=8787, debug=True)

