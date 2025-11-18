/**
 * 教育輔導建議小工具 - 配置檔案
 * 
 * 使用說明：
 * 1. Python 版本：設定 BACKEND = 'python'
 * 2. PHP 版本：設定 BACKEND = 'php'
 */

const CONFIG = {
  // 後端類型：'python' 或 'php'
  BACKEND: 'python',
  
  // API 端點配置
  API_ENDPOINTS: {
    python: 'http://localhost:8787/api/generate',
    php: 'my_prompt.php'
  },
  
  // 取得當前使用的 API 端點
  getApiEndpoint() {
    return this.API_ENDPOINTS[this.BACKEND];
  },
  
  // 取得後端資訊
  getBackendInfo() {
    if (this.BACKEND === 'python') {
      return {
        name: 'Python Flask',
        port: 8787,
        url: 'http://localhost:8787',
        startCommand: 'start_python.bat (Windows) 或 python3 app.py'
      };
    } else {
      return {
        name: 'PHP',
        port: 8000,
        url: 'http://localhost:8000',
        startCommand: 'start_php.bat (Windows) 或 php -S localhost:8000'
      };
    }
  }
};

// 在控制台顯示當前配置
console.log('🔧 後端配置:', CONFIG.BACKEND);
console.log('📍 API 端點:', CONFIG.getApiEndpoint());
console.log('ℹ️  後端資訊:', CONFIG.getBackendInfo());

