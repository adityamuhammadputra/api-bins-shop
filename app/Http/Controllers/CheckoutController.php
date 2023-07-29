<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Models\TransactionStatus;
use App\Resources\Transaction as ResourcesTransaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;


class CheckoutController extends BaseController
{
    public function store(Request $request)
    {
        $invoice = 'INV' . Carbon::now()->format('YmdHis');

        $itemDetails = [];

        if ($request->direct) { //for button "beli langsung"
            $itemDetails [] = [
                'id' => uuId(),
                'price' => (int)$request->product['price_final'],
                'quantity' => $request->qty,
                'name' => $request->product['name'],
            ];
        } else {
            foreach ($request->product as $key => $value) {
                if ((isset($value['status']) && $value['status'] == true)) {
                    // $totalDetail = (int)$value['product']['price_final'] * $value['qty'];
                    $itemDetails [] = [
                        'id' => uuId(),
                        'price' => (int)$value['product']['price_final'],
                        'quantity' => $value['qty'],
                        'name' => $value['product']['name'],
                    ];
                }
            }
        }

        $midtransClient = \Sawirricardo\Midtrans\Midtrans::make(
            "SB-Mid-server-HgNt5rGnmNKA-blTTc5qkpe1",
            "SB-Mid-client-yZVknAlmsT3Cr3K8",
            false,
            true,
            false
        );

        dd($midtransClient);
        $snapToken = $midtransClient->snap()->create(new \Sawirricardo\Midtrans\Dto\TransactionDto([
                'transaction_details' => [
                    'order_id' => $invoice,
                    'gross_amount' => $request->amount,
                ],
                "customer_details" => [
                    "first_name" => user()->name,
                    "phone" => user()->phone,
                    "billing_address"=> [
                        "address"=> user()->email ?? '-',
                    ],
                ],
                "item_details" => $itemDetails,
                "enabled_payments" => ['gopay', 'shopeepay', 'alfamart' ,'indomaret', 'bca_va', 'bri_va', 'bni_va', 'other_va', 'echannel', 'akulaku']
            ]));

        $response = [
            'token' => $snapToken->token,
            'url' => $snapToken->redirect_url,
        ];

        // userCreateLog("Klik button Order ($invoice)");
        return response()->json($response, 200);
    }

    public function show($orderId)
    {
        $midtransClient = \Sawirricardo\Midtrans\Midtrans::make(
            "SB-Mid-server-HgNt5rGnmNKA-blTTc5qkpe1",
            "SB-Mid-client-yZVknAlmsT3Cr3K8",
            false,
            true,
            false
        );

         $transactionStatus = $midtransClient->payment()->status($orderId);

         return response()->json($transactionStatus, 200);
    }
}
