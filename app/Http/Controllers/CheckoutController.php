<?php

namespace App\Http\Controllers;

use App\Models\Chart;
use App\Resources\Cart;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;


class CheckoutController extends BaseController
{

    public function index(Request $request)
    {
        try {
            $data = Chart::with('product')
                    ->where('user_id', $request->header('g'))
                    ->get();

            $response = [
                'status' => 200,
                'message' => '',
                'data' => Cart::collection($data),
            ];
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function store(Request $request)
    {
        $midtransClient = \Sawirricardo\Midtrans\Midtrans::make(
            "SB-Mid-server-HgNt5rGnmNKA-blTTc5qkpe1",
            "SB-Mid-client-yZVknAlmsT3Cr3K8",
            false,
            false,
            false
        );
        $snapToken = $midtransClient->snap()->create(new \Sawirricardo\Midtrans\Dto\TransactionDto([
                'transaction_details' => [
                    'order_id' => 'INV' . Carbon::now()->format('YmdHis'),
                    'gross_amount' => $request->amount,
                ],
                "customer_details" => [
                    "first_name" => "Syahrul",
                    "last_name" => "pratama",
                    "email" => "Syahrul.pra@gmail.com",
                    "phone" => "08xxxxxxxx"
                ],
                "enabled_payments" => ['gopay', 'shopeepay', 'alfamart' ,'indomaret', 'bca_va', 'bri_va', 'bni_va']
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
            "SB-Mid-server-HgNt5rGnmNKA-blTTc5qkpe1",
            "SB-Mid-client-yZVknAlmsT3Cr3K8",
            false,
            false,
            false
        );

         $transactionStatus = $midtransClient->payment()->status($orderId);

         return response()->json($transactionStatus, 200);
    }
}
