<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Models\TransactionStatus;
use App\Resources\Transaction as ResourcesTransaction;
use App\Resources\TransactionWithStatus;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;


class TransactionController extends BaseController
{
    public function index(Request $request)
    {
        try {
            $hasTimeOut = Transaction::where('payment_timeout', '<', Carbon::now())
                            ->where('user_id', userId())
                            ->where('status_id', 1);

            if (count($hasTimeOut->get()) > 0) {
                foreach($hasTimeOut->get() as $val) {
                    TransactionStatus::create([
                        'id' => uuId(),
                        'user_id' => userId(),
                        'transaction_id' => $val->id,
                        'status_id' => 11,
                    ]);
                }
            }

            $hasTimeOut->update([
                'status_id' => 11,
            ]);

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
            $invoice = $request->midtrans['order_id'];
            $paymentType = $request->midtrans['payment_type'];

            $paymentTimeout = Carbon::parse($request->midtrans['transaction_time'])
                                    ->addHours(23)
                                    ->addMinutes(59)
                                    ->format('Y-m-d H:i:s');
            if (in_array($paymentType, ['qris'])) {
                $paymentTimeout = Carbon::parse($request->midtrans['transaction_time'])
                                    ->addMinutes(29)
                                    ->format('Y-m-d H:i:s');
            }

            $inputTrans = [
                'id' => uuId(),
                'user_id' => userId(),
                'status_id' => 1,
                'invoice' => $invoice,
                'qty' => $request->qty,
                'price' => $request->amount,
                'discount' => ($request->discount) ? $request->discount : 0,
                'total' => ($request->discount) ? $request->amount - $request->amount * $request->discount / 100 : $request->amount,
                'order_id' => $invoice,
                'gross_amount' => $request->midtrans['gross_amount'],
                'status_code' => $request->midtrans['status_code'],
                'transaction_id' => $request->midtrans['transaction_id'],
                'transaction_status' => $request->midtrans['transaction_status'],
                'transaction_time' => $request->midtrans['transaction_time'],
                'payment_type' => $paymentType,
                'payment_timeout' => $paymentTimeout,
                'payment_token' => $request->snapData,
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

    public function show($order)
    {
        $data = Transaction::with('transactionStatuses', 'transactionStatuses.assetStatus')
                ->where('id', $order)
                ->firstOrFail();

        return new TransactionWithStatus($data);
    }

    public function update(Request $request, Transaction $order)
    {

        $type = $request->type;
        if ($type == 'cancel') {
            $status = 12; $msg= 'Pesanan berhasil dibatalkan';
        }
        if ($type == 'done') {
            $status = 4; $msg= 'Pesanan berhasil diselesaikan';
        }
        if ($type == 'refund') {
            $status = 9; $msg= 'Refund berhasil diajukan';
        }

        try{
            $order->status_id = $status;
            $order->save();

            TransactionStatus::create([
                'id' => uuId(),
                'user_id' => userId(),
                'transaction_id' => $order->id,
                'status_id' => $status,
            ]);

            $response = [
                'status' => 200,
                'message' => $msg,
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

    public function callback(Request $request)
    {
        $serverKey = 'SB-Mid-server-HgNt5rGnmNKA-blTTc5qkpe1';
        $hassed = hash('sha512', $request->order_id . $request->status_code . $request->gross_amount . $serverKey);
        if ($hassed == $request->signature_key) {
            if (in_array($request->transaction_status, ['capture', 'settlement'])) {
                $order = Transaction::where('order_id', $request->order_id);
                $order->update([
                    'status_id' => 2,
                    'transaction_status' => 'paid',
                ]);

                TransactionStatus::create([
                    'id' => uuId(),
                    'user_id' => userId(),
                    'transaction_id' => Transaction::where('order_id', $request->order_id)->first()->id,
                    'status_id' => 2,
                ]);
            }
        }


    }
}
