<?php
// my_prompt.php
header('Content-Type: application/json; charset=utf-8');

// 1. 讀取前端送來的 JSON
$raw = file_get_contents('php://input');
$input = json_decode($raw, true);

if (!$input || !isset($input['profile']) || trim($input['profile']) === '') {
    echo json_encode([
        'success' => false,
        'message' => '缺少 profile 內容'
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$profile = trim($input['profile']);

// 2. 設定 OpenAI API Key（請改成你自己的，建議放在環境變數或 config 檔）
$apiKey = 'your-openai-api-key-here';  // TODO: 換成你的金鑰

// 3. 組出要丟給 OpenAI 的訊息
$systemPrompt = <<<SYS
你是一位在台灣服務的特教老師，熟悉融合教育與早療、特教團隊合作。
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
}
SYS;

$userPrompt = "孩子能力現況如下：\n" . $profile;

// 4. 呼叫 OpenAI Chat Completions API
$url = 'https://api.openai.com/v1/chat/completions';

$payload = [
    'model' => 'gpt-4.1-mini', // 或 'gpt-4o-mini' ，依你帳號可用的模型調整
    'messages' => [
        ['role' => 'system', 'content' => $systemPrompt],
        ['role' => 'user', 'content' => $userPrompt]
    ],
    'temperature' => 0.4,
    'max_tokens' => 800,
];

$ch = curl_init($url);
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POST => true,
    CURLOPT_HTTPHEADER => [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $apiKey
    ],
    CURLOPT_POSTFIELDS => json_encode($payload, JSON_UNESCAPED_UNICODE),
]);

$result = curl_exec($ch);

if ($result === false) {
    echo json_encode([
        'success' => false,
        'message' => 'cURL 錯誤：' . curl_error($ch)
    ], JSON_UNESCAPED_UNICODE);
    curl_close($ch);
    exit;
}

$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($httpCode < 200 || $httpCode >= 300) {
    echo json_encode([
        'success' => false,
        'message' => 'OpenAI API 回傳錯誤 (HTTP ' . $httpCode . '): ' . $result
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// 5. 解析 OpenAI 回傳
$data = json_decode($result, true);
if (!$data || !isset($data['choices'][0]['message']['content'])) {
    echo json_encode([
        'success' => false,
        'message' => '無法解析 OpenAI 回應'
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$content = trim($data['choices'][0]['message']['content']);

// 有時模型會在 JSON 外多加換行或 markdown，這裡試著抓出第一個 { 到最後一個 } 之間的內容
$start = strpos($content, '{');
$end   = strrpos($content, '}');
if ($start !== false && $end !== false && $end >= $start) {
    $content = substr($content, $start, $end - $start + 1);
}

$jsonSuggestions = json_decode($content, true);

if ($jsonSuggestions === null) {
    echo json_encode([
        'success' => false,
        'message' => '模型回傳的 JSON 格式錯誤：' . $content
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// 6. 回傳給前端
echo json_encode([
    'success' => true,
    'suggestions' => $jsonSuggestions
], JSON_UNESCAPED_UNICODE);
