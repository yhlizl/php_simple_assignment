<?php
echo "========================================\n";
echo "  PHP cURL 檢查工具\n";
echo "========================================\n\n";

// 檢查 PHP 版本
echo "PHP 版本: " . phpversion() . "\n\n";

// 檢查 cURL 是否已安裝
if (function_exists('curl_init')) {
    echo "✅ cURL 已啟用\n\n";
    
    // 顯示 cURL 版本資訊
    $version = curl_version();
    echo "cURL 版本: " . $version['version'] . "\n";
    echo "SSL 版本: " . $version['ssl_version'] . "\n\n";
    
    echo "========================================\n";
    echo "  測試 OpenAI API 連線\n";
    echo "========================================\n\n";
    
    // 測試 API 連線
    $ch = curl_init('https://api.openai.com/v1/models');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer test-key'
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode == 401) {
        echo "✅ 可以連線到 OpenAI API（HTTP 401 = API Key 無效，但連線正常）\n";
    } else if ($httpCode == 200) {
        echo "✅ 可以連線到 OpenAI API（HTTP 200）\n";
    } else {
        echo "⚠️  連線狀態碼: HTTP $httpCode\n";
    }
    
} else {
    echo "❌ cURL 未啟用\n\n";
    echo "請按照以下步驟啟用 cURL：\n\n";
    echo "1. 找到 php.ini 檔案位置：\n";
    echo "   執行：php --ini\n\n";
    echo "2. 用記事本開啟 php.ini\n\n";
    echo "3. 找到這一行：\n";
    echo "   ;extension=curl\n\n";
    echo "4. 移除前面的分號改成：\n";
    echo "   extension=curl\n\n";
    echo "5. 儲存檔案並重新啟動 PHP 伺服器\n\n";
}

echo "\n========================================\n";
echo "  已載入的擴展\n";
echo "========================================\n\n";

$extensions = get_loaded_extensions();
sort($extensions);

$curl_found = false;
foreach ($extensions as $ext) {
    if (strtolower($ext) === 'curl') {
        echo "✅ $ext\n";
        $curl_found = true;
    }
}

if (!$curl_found) {
    echo "❌ curl 不在已載入的擴展中\n";
}

echo "\n========================================\n";
echo "  php.ini 位置\n";
echo "========================================\n\n";

$ini_path = php_ini_loaded_file();
if ($ini_path) {
    echo "已載入的 php.ini: $ini_path\n";
} else {
    echo "⚠️  沒有載入 php.ini 檔案\n";
    echo "請從 php.ini-development 複製一份並命名為 php.ini\n";
}

echo "\n========================================\n";

