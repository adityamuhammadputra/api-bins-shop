<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Models\TransactionStatus;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

class XOrderController extends BaseController
{
    public function index(Request $request)
    {
        $response = [
            'status' => 503,
            // 'message' => $e->getMessage()
        ];
        return response()->json($response, $response['status']);
    }

    public function store(Request $request)
    {
        $invoice = 'INV' . Carbon::now()->format('YmdHis');

        $inputTrans = [
            'id' => uuId(),
            'user_id' => userId(),
            'status_id' => 1,
            'invoice' => $invoice,
            'qty' => $request->qty,
            'price' => $request->amount,
            'discount' => ($request->discount) ? $request->discount : 0,
            'total' => ($request->discount) ? $request->amount - $request->amount * $request->discount / 100 : $request->amount,
        ];

        Transaction::create($inputTrans);

        TransactionStatus::create([
            'id' => uuId(),
            'user_id' => userId(),
            'transaction_id' => $inputTrans['id'],
            'status_id' => 1,
        ]);

        $inputTransDetail = [];
        foreach ($request->product as $key => $value) {
            if (isset($value['status']) && $value['status'] == true) {

                $totalDetail = (int)$value['product']['price'] * $value['qty'];
                if ($request->discount) {
                    $totalDisc = (int)$value['product']['price'] * (int)$value['product']['discount'] / 100;
                    $totalDetail = $totalDetail - $totalDisc;
                }

                $inputTransDetail[] = [
                    'id' => uuId(),
                    'user_id' => userId(),
                    'transaction_id' => $inputTrans['id'],
                    'invoice' => $invoice,
                    'product_id' => $value['product']['id'],
                    'product_name' => $value['product']['name'],
                    'notes' => $value['notes'],
                    'price' => (int)$value['product']['price'],
                    'qty' => $value['qty'],
                    'discount' => (int)$value['product']['discount'],
                    'total' => $totalDetail,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];
            }
        }

        if (count($inputTransDetail) > 0) {
            TransactionDetail::insert($inputTransDetail);
        }

        $midtransClient = \Sawirricardo\Midtrans\Midtrans::make(
            config('midtrans.sandbox_server_key'),
            config('midtrans.sandbox_client_key'),
            false,
            false,
            false
        );
        $snapToken = $midtransClient->snap()->create(new \Sawirricardo\Midtrans\Dto\TransactionDto([
                'transaction_details' => [
                    'order_id' => $invoice,
                    'gross_amount' => $request->amount,
                ],
                "customer_details" => [
                    "first_name" => user()->name,
                    "email" => user()->email,
                    "phone" => user()->phone
                ],
                "enabled_payments" => ['gopay', 'shopeepay', 'alfamart' ,'indomaret', 'bca_va', 'bri_va', 'bni_va', 'dana', 'ovo']
            ]));

        $response = [
            'token' => $snapToken->token,
            'url' => $snapToken->redirect_url,
        ];
        return response()->json($response, 200);
    }

    public function show($orderId)
    {
        $midtransClient = \Sawirricardo\Midtrans\Midtrans::make(
            config('midtrans.sandbox_server_key'),
            config('midtrans.sandbox_client_key'),
            false,
            false,
            false
        );

         $transactionStatus = $midtransClient->payment()->status($orderId);

         return response()->json($transactionStatus, 200);
    }
}
