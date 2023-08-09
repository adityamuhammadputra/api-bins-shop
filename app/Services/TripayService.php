<?php

namespace App\Services;

use Carbon\Carbon;

class TripayService {

    function signature()
    {
        $privateKey   = config('tripay.private_key');
        $merchantCode = config('tripay.kode');
        $merchantRef  = 'INV55567';
        $amount       = 1500000;

        return hash_hmac('sha256', $merchantCode.$merchantRef.$amount, $privateKey);
    }

    function index()
    {
        $apiKey       = config('tripay.api_key');

        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_FRESH_CONNECT  => true,
            CURLOPT_URL            => 'https://tripay.co.id/'.config('tripay.endpoint').'/merchant/payment-channel',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HEADER         => false,
            CURLOPT_HTTPHEADER     => ['Authorization: Bearer '.$apiKey],
            CURLOPT_FAILONERROR    => false,
            CURLOPT_IPRESOLVE      => CURL_IPRESOLVE_V4
        ));

        $response = curl_exec($curl);
        $error = curl_error($curl);

        curl_close($curl);

        // echo empty($error) ? $response : $error;

        return ($response) ?  $response : $error;
    }


    function store($request, $invoice)
    {
        $user = user();

        $apiKey       = config('tripay.api_key');
        $privateKey   = config('tripay.private_key');
        $merchantCode = config('tripay.kode');
        $merchantRef  = $invoice;
        $amount       = $request->amount;

        $paymentType = $request->transaction['code'] ?? 'BRIVA';

        $itemDetails = [];

        if ($request->direct) { //for button "beli langsung"
            $itemDetails [] = [
                // 'id' => uuId(),
                'name' => $request->product['name'],
                'price' => (int)$request->product['price_final'],
                'quantity' => $request->qty,
            ];
        } else {
            foreach ($request->product as $key => $value) {
                if ((isset($value['status']) && $value['status'] == true)) {
                    // $totalDetail = (int)$value['product']['price_final'] * $value['qty'];
                    $itemDetails [] = [
                        // 'id' => uuId(),
                        'name' => $value['product']['name'],
                        'price' => (int)$value['product']['price_final'],
                        'quantity' => $value['qty'],
                    ];
                }
            }
        }

        $data = [
            'method'         => $paymentType,
            'merchant_ref'   => $merchantRef,
            'amount'         => $amount,
            'customer_name'  => $user->name,
            'customer_email' => $user->email ?? '',
            'customer_phone' => $$user->phone ?? '',
            'order_items' => $itemDetails,
            // 'order_items'    => [
            //     [
            //         'name'        => 'Nama Produk 1',
            //         'price'       => 500000,
            //         'quantity'    => 1,
            //         // 'product_url' => 'https://tokokamu.com/product/nama-produk-1',
            //         // 'image_url'   => 'https://tokokamu.com/product/nama-produk-1.jpg',
            //     ],
            //     [
            //         'name'        => 'Nama Produk 2',
            //         'price'       => 500000,
            //         'quantity'    => 1,
            //         // 'product_url' => 'https://tokokamu.com/product/nama-produk-2',
            //         // 'image_url'   => 'https://tokokamu.com/product/nama-produk-2.jpg',
            //     ]
            // ],
            // // 'return_url'   => 'https://domainanda.com/redirect',
            'expired_time' => (time() + (24 * 60 * 60)), // 24 jam
            'signature'    => hash_hmac('sha256', $merchantCode.$merchantRef.$amount, $privateKey)
        ];

        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_FRESH_CONNECT  => true,
            CURLOPT_URL            => 'https://tripay.co.id/'.config('tripay.endpoint').'/transaction/create',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HEADER         => false,
            CURLOPT_HTTPHEADER     => ['Authorization: Bearer '.$apiKey],
            CURLOPT_FAILONERROR    => false,
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => http_build_query($data),
            CURLOPT_IPRESOLVE      => CURL_IPRESOLVE_V4
        ]);

        $response = curl_exec($curl);
        $error = curl_error($curl);

        curl_close($curl);

        // echo empty($error) ? $response : $error;
        return ($response) ?  json_decode($response, true) : $error;


    }

    function show($payload)
    {

        $apiKey = config('tripay.api_key');

        $payload = ['reference'	=> $payload];

        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_FRESH_CONNECT  => true,
            CURLOPT_URL            => 'https://tripay.co.id/'.config('tripay.endpoint').'/transaction/detail?'.http_build_query($payload),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HEADER         => false,
            CURLOPT_HTTPHEADER     => ['Authorization: Bearer '.$apiKey],
            CURLOPT_FAILONERROR    => false,
            CURLOPT_IPRESOLVE      => CURL_IPRESOLVE_V4
        ]);

        $response = curl_exec($curl);
        $error = curl_error($curl);

        curl_close($curl);

        return ($response) ?  $response : $error;

    }
}
