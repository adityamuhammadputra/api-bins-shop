<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Models\ProductRating;
use App\Models\ProductRatings;
use App\Models\TransactionStatus;
use App\Resources\Transaction as ResourcesTransaction;
use App\Resources\TransactionRatingProduct;
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

            $data = Transaction::filtered()
                        ->with('assetStatus', 'user', 'transactionDetails', 'ProductRating')
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

            // dd($inputTrans);


            Transaction::create($inputTrans);

            TransactionStatus::create([
                'id' => uuId(),
                'user_id' => userId(),
                'transaction_id' => $inputTrans['id'],
                'status_id' => 1,
            ]);

            $inputTransDetail = [];

            if ($request->direct) { //for button "beli langsung"
                $totalDetail = (int)$request->product['price'];
                if (isset($request->product['discount'])) {
                    $totalDisc = (int)$request->product['price'] * (int)$request->product['discount'] / 100;
                    $totalDetail = $totalDetail - $totalDisc;
                }

                $inputTransDetail[] = [
                    'id' => uuId(),
                    'user_id' => userId(),
                    'transaction_id' => $inputTrans['id'],
                    'invoice' => $invoice,
                    'product_id' => $request->product['id'],
                    'product_name' => $request->product['name'],
                    'price' => (int)$request->product['price'],
                    'price_discount' => (int)$request->product['price_final'],
                    'discount' => (int)$request->product['discount'],
                    'qty' => $request->qty,
                    'total' => $totalDetail * $request->qty,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];

                $product = Product::find($request->product['id']);
                $product->sold = isset($product->sold ) ? $product->sold + $request->qty : $request->qty;
                $product->stock = $product->stock - $request->qty;
                $product->save();
            } else {

                // return $request->product;
                foreach ($request->product as $key => $value) {
                    if (isset($value['status']) && $value['status'] == true) {

                        $totalDetail = (int)$value['product']['price'];
                        if (isset($value['product']['discount'])) {
                            $totalDisc = (int)$value['product']['price'] * (int)$value['product']['discount'] / 100;
                            $totalDetail = ($totalDetail - $totalDisc);
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
                            'price_discount' => (int)$value['product']['price_final'],
                            'qty' => $value['qty'],
                            'discount' => (int)$value['product']['discount'],
                            'total' => $totalDetail * $value['qty'],
                            'created_at' => Carbon::now(),
                            'updated_at' => Carbon::now(),
                        ];

                        $product = Product::find($value['product']['id']);
                        $product->sold = isset($product->sold ) ? $product->sold + $value['qty'] : $value['qty'];
                        $product->stock = $product->stock - $value['qty'];
                        $product->save();
                    }
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
        try {
            $serverKey = 'SB-Mid-server-HgNt5rGnmNKA-blTTc5qkpe1';
            $hassed = hash('sha512', $request->order_id . $request->status_code . $request->gross_amount . $serverKey);
            if ($hassed == $request->signature_key) {
                if (in_array($request->transaction_status, ['capture', 'settlement'])) {
                    $order = Transaction::where('order_id', $request->order_id);
                    $order->update([
                        'status_id' => 2,
                        'transaction_status' => 'paid',
                    ]);

                    $transaction = Transaction::where('order_id', $request->order_id)->first();
                    TransactionStatus::create([
                        'id' => uuId(),
                        'user_id' => $transaction->user_id,
                        'transaction_id' => $transaction->id,
                        'status_id' => 2,
                    ]);
                }
            }

            $response = [
                'status' => 200,
                'message' => 'Pesanan dibayar',
            ];
        } catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, 200);

    }

    public function ratingStore(Request $request)
    {
        try{
            foreach ($request->order['transaction_details'] as $value) {
                $data = [
                    'id' => uuId(),
                    'user_id' => userId(),
                    'transaction_id' => $request->transaction_id,
                    'product_id' => $value['product']['id'],
                    'rating' => $request->value,
                    'desc' => $request->desc,
                ];
                ProductRating::create($data);
            }

            $response = [
                'status' => 200,
                'message' => 'Terimakasih, ulasan anda sangat berarti :)',
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

    public function ratingGet(Request $request)
    {
        try {
            $data = Transaction::with('user', 'ProductRatings', 'ProductRatings.product')
                        ->where('user_id', userId())
                        ->where('status_id', 4)
                        ->orderBy('created_at', 'desc')
                        ->get();

            $response = [
                'status' => 200,
                'message' => '',
                'data' => TransactionRatingProduct::collection($data),
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
}
