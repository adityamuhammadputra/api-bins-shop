<?php

return [
    'kode' => env('TRIPAY_KODE'),
    'api_key' => env('TRIPAY_API_KEY'),
    'private_key' => env('TRIPAY_PRIVATE_KEY'),
    'endpoint' => (env('TRIPAY_PRODUCTION') == true) ? 'api' : 'api-sandbox',
];
