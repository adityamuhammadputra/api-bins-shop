<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Models\TransactionStatus;
use App\Resources\Transaction as ResourcesTransaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;


class TransactionController extends BaseController
{
    public function index(Request $request)
    {
        try {
            $data = Transaction::with('assetStatus', 'user', 'transactionDetails')
                        ->where('user_id', userId())
                        ->orderBy('created_at', 'desc')
                        ->get();

            $response = [
                'status' => 200,
                'message' => '',
                'data' => ResourcesTransaction::collection($data),
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
        try {

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
            $itemDetails = [];
            foreach ($request->product as $key => $value) {
                if (isset($value['status']) && $value['status'] == true) {

                    $totalDetail = (int)$value['product']['price'] * $value['qty'];
                    if ($request->discount) {
                        $totalDisc = (int)$value['product']['price'] * (int)$value['product']['discount'] / 100;
                        $totalDetail = $totalDetail - $totalDisc;
                    }

                    $itemDetails [] = [
                        'id' => uuId(),
                        'price' => (int)$value['product']['price'],
                        'quantity' => $value['qty'],
                        'name' => $value['product']['name'],
                    ];

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

            $response = [
                'status' => 200,
                'message' => 'Pesanan berhasil dibuat',
            ];
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

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

    public function saveData($request, $invoice)
    {

    }
}
