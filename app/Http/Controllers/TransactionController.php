<?php

namespace App\Http\Controllers;

use App\Models\AssetStatus;
use App\Models\Chart;
use App\Models\Product;
use App\Models\Transaction;
use App\Models\TransactionDetail;
use App\Models\ProductRating;
use App\Models\ProductRatings;
use App\Models\TransactionStatus;
use App\Models\User;
use App\Resources\Transaction as ResourcesTransaction;
use App\Resources\TransactionRatingProduct;
use App\Resources\TransactionWithStatus;
use App\Services\TripayService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Response;

class TransactionController extends BaseController
{

    private $tripayService;

    public function __construct(TripayService $tripay)
    {
        $this->tripayService = $tripay;
    }

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


                    $assetStatus = AssetStatus::find(11);
                    $dataEmail = (object) [
                        'subject' => "#$val->invoice, $assetStatus->name",
                        'to' => user()->email,
                        'invoice' => $val->invoice,
                        'user' => user()->name,
                        'price' => toRupiah($val->total),
                        'status_name' => $assetStatus->name,
                        'status_desc' => $assetStatus->desc_email,
                        'link' => "order/$val->id",
                    ];
                    sendMail($dataEmail);
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

    public function paymentList()
    {
        return $this->tripayService->index();
    }

    public function store(Request $request)
    {
        // try {
            $invoice = 'INV'. userId() . Carbon::now()->format('YmdHis');
            $user = user();
            $payment = $this->tripayService->store($request, $invoice);
            $paymentType = $request->transaction['name'];

            if ($payment['success'] == false) {
                $response = [
                    'status' => 503,
                    'message' => $payment['message']
                ];
                return response()->json($response, 503);
            }

            $paymentTimeout = Carbon::parse(Carbon::now())
                                    ->addHours(23)
                                    ->addMinutes(59)
                                    ->format('Y-m-d H:i:s');
            if (str_contains($paymentType, 'QRIS')) {
                $paymentTimeout = Carbon::now()
                                    ->addMinutes(59)
                                    ->format('Y-m-d H:i:s');
            }

            $id = uuId();
            $total = ($request->discount) ? $request->amount - $request->amount * $request->discount / 100 : $request->amount;
            $inputTrans = [
                'id' => $id,
                'user_id' => $user->id,
                'status_id' => 1,
                'invoice' => $invoice,
                'qty' => $request->qty,
                'price' => $request->amount,
                'discount' => ($request->discount) ? $request->discount : 0,
                'total' => $total,
                'provider' => 'tripay',
                'order_id' => $invoice,
                'gross_amount' => $payment['data']['amount'],
                'received_amount' => $payment['data']['amount_received'],
                // 'status_code' => $request->transaction['status_code'],
                'transaction_id' => $payment['data']['reference'],
                'transaction_status' => $payment['data']['status'],
                'transaction_time' => Carbon::now(),
                'payment_type' => $paymentType,
                'payment_timeout' => $paymentTimeout,
                // 'payment_token' => $request->snapData,
            ];

            $inputTransDetail = [];

            if ($request->direct) { //for button "beli langsung"
                $totalDetail = toInt($request->product['price']);
                if (isset($request->product['discount'])) {
                    $totalDisc = toInt($request->product['price']) * toInt($request->product['discount']) / 100;
                    $totalDetail = $totalDetail - $totalDisc;
                }

                $inputTransDetail[] = [
                    'id' => uuId(),
                    'user_id' => $user->id,
                    'transaction_id' => $inputTrans['id'],
                    'invoice' => $invoice,
                    'product_id' => $request->product['id'],
                    'product_name' => $request->product['name'],
                    'price' => toInt($request->product['price']),
                    'price_discount' => toInt($request->product['price_final']),
                    'discount' => toInt($request->product['discount']),
                    'qty' => $request->qty,
                    'total' => $totalDetail * $request->qty,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];

                $product = Product::find($request->product['id']);
                $product->sold = isset($product->sold ) ? $product->sold + $request->qty : $request->qty;
                $product->stock = $product->stock - $request->qty;
                $product->save();

                Chart::where('user_id', $user->id)
                            ->where('product_id', $request->product['id'])
                            ->delete();
            } else {
                // return $request->product;
                foreach ($request->product as $key => $value) {
                    if (isset($value['status']) && $value['status'] == true) {

                        $totalDetail = toInt($value['product']['price']);
                        if (isset($value['product']['discount'])) {
                            $totalDisc = toInt($value['product']['price']) * toInt($value['product']['discount']) / 100;
                            $totalDetail = ($totalDetail - $totalDisc);
                        }

                        $inputTransDetail[] = [
                            'id' => uuId(),
                            'user_id' => $user->id,
                            'transaction_id' => $inputTrans['id'],
                            'invoice' => $invoice,
                            'product_id' => $value['product']['id'],
                            'product_name' => $value['product']['name'],
                            'notes' => $value['notes'],
                            'price' => toInt($value['product']['price']),
                            'price_discount' => toInt($value['product']['price_final']),
                            'qty' => $value['qty'],
                            'discount' => toInt($value['product']['discount']),
                            'total' => $totalDetail * $value['qty'],
                            'created_at' => Carbon::now(),
                            'updated_at' => Carbon::now(),
                        ];

                        $product = Product::find($value['product']['id']);
                        $product->sold = isset($product->sold ) ? $product->sold + $value['qty'] : $value['qty'];
                        $product->stock = $product->stock - $value['qty'];
                        $product->save();

                        Chart::where('user_id', $user->id)
                            ->where('product_id', $value['product']['id'])
                            ->delete();
                    }
                }
            }

            Transaction::create($inputTrans);

            TransactionStatus::create([
                'id' => uuId(),
                'user_id' => $user->id,
                'transaction_id' => $inputTrans['id'],
                'status_id' => 1,
            ]);

            if (count($inputTransDetail) > 0) {
                TransactionDetail::insert($inputTransDetail);
            }


            $assetStatus = AssetStatus::find(1);
            $dataEmail = (object) [
                'subject' => "#$invoice, $assetStatus->name",
                'to' => $user->email ?? null,
                'invoice' => $invoice,
                'user' => $user->name,
                'product' => $inputTransDetail,
                'price' => toRupiah($total),
                'payment_timeout' => dateTimeOutput2($paymentTimeout),
                'status_name' => $assetStatus->name,
                'status_desc' => $assetStatus->desc_email,
                'link' => "order/$id",
            ];
            userCreateLog("Order Create $invoice");
            sendMail($dataEmail);
            return $payment;
        // }
        // catch (\Exception $e) {
        //     $response = [
        //         'status' => 503,
        //         'message' => $e->getMessage()
        //     ];
        // }

        // return response()->json($response, 500);
    }

    public function show(Request $request, $order)
    {
        if ($request->payload) {
            $response = json_decode($this->tripayService->show($request->payload));
            $response->data->icon_url = iconUrl($response->data->payment_method);
            return $response;
        }
        $data = Transaction::with('transactionStatuses', 'transactionStatuses.assetStatus')
                    ->where('id', $order)
                    ->firstOrFail();

        if ($data->payment_timeout < Carbon::now() && $data->status_id == 1) {
            $data->status_id = 11;
            $data->save();
            TransactionStatus::create([
                'id' => uuId(),
                'user_id' => userId(),
                'transaction_id' => $data->id,
                'status_id' => 11,
            ]);

            $assetStatus = AssetStatus::find(11);
            $dataEmail = (object) [
                'subject' => "#$data->invoice, $assetStatus->name",
                'to' => user()->email,
                'invoice' => $data->invoice,
                'user' => user()->name,
                'price' => toRupiah($data->total),
                'status_name' => $assetStatus->name,
                'status_desc' => $assetStatus->desc_email,
                'link' => "order/$data->id",
            ];
            sendMail($dataEmail);
        }

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

            $assetStatus = AssetStatus::find($status);
            $transaction = Transaction::find($order->id);
            $dataEmail = (object) [
                'subject' => "#$transaction->invoice, $assetStatus->name",
                'to' => user()->email,
                'invoice' => $transaction->invoice,
                'user' => user()->name,
                'price' => toRupiah($transaction->total),
                'status_name' => $assetStatus->name,
                'status_desc' => $assetStatus->desc_email,
                'link' => "order/$order->id",
            ];
            sendMail($dataEmail);
            userCreateLog("Order Update $transaction->invoice");

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

    public function callbackTripay(Request $request)
    {
        $privateKey   = config('tripay.private_key');

        $callbackSignature = $request->server('HTTP_X_CALLBACK_SIGNATURE');
        $json = $request->getContent();
        $signature = hash_hmac('sha256', $json, $privateKey);

        if ($signature !== (string) $callbackSignature) {
            return Response::json([
                'success' => false,
                'message' => 'Invalid signature',
            ]);
        }

        if ('payment_status' !== (string) $request->server('HTTP_X_CALLBACK_EVENT')) {
            return Response::json([
                'success' => false,
                'message' => 'Unrecognized callback event, no action was taken',
            ]);
        }

        $data = json_decode($json);

        if (JSON_ERROR_NONE !== json_last_error()) {
            return Response::json([
                'success' => false,
                'message' => 'Invalid data sent by tripay',
            ]);
        }

        $invoiceId = $data->merchant_ref;
        $tripayReference = $data->reference;
        $status = strtoupper((string) $data->status);

        if ($data->is_closed_payment === 1) {
            $transaction = Transaction::where('order_id', $invoiceId)
                ->where('transaction_status', 'UNPAID')
                ->first();

            if (! $transaction) {
                return Response::json([
                    'success' => false,
                    'message' => 'No invoice found or already paid: ' . $invoiceId,
                ]);
            }

            if ($status == 'PAID') {
                $transaction->update(['status_id' => 2, 'transaction_status' => 'PAID']);
                TransactionStatus::create([
                    'id' => uuId(),
                    'user_id' => $transaction->user_id,
                    'transaction_id' => $transaction->id,
                    'status_id' => 2,
                ]);

                $assetStatus = AssetStatus::find(2);
                $user = User::where('id', $transaction->user_id)->first();
                $this->sendEmailCallback($transaction, $assetStatus, $user);

                userCreateLog("Order Pay $transaction->invoice - $user->name");

            } else if(in_array($status, ['EXPIRED', 'FAILED'])) {
                $transaction->update(['status_id' => 11, 'transaction_status' => 'FAILED']);
                TransactionStatus::create([
                    'id' => uuId(),
                    'user_id' => $transaction->user_id,
                    'transaction_id' => $transaction->id,
                    'status_id' => 11,
                ]);

                $assetStatus = AssetStatus::find(11);
                $user = User::where('id', $transaction->user_id)->first();
                $this->sendEmailCallback($transaction, $assetStatus, $user);
                userCreateLog("Order Pay $transaction->invoice - $user->name");
            } else {
                return Response::json([
                    'success' => false,
                    'message' => 'Unrecognized payment status',
                ]);
            }
            return Response::json(['success' => true]);
        }
    }

    function sendEmailCallback($transaction, $assetStatus, $user)
    {
        $dataEmail = (object) [
            'subject' => "#$transaction->invoice, $assetStatus->name",
            'to' => $user->email,
            'invoice' => $transaction->invoice,
            'user' => $user->name,
            'price' => toRupiah($transaction->total),
            'status_name' => $assetStatus->name,
            'status_desc' => $assetStatus->desc_email,
            'link' => "order/$transaction->id",
        ];
        sendMail($dataEmail);
    }

    public function signature()
    {
        return json_encode($this->tripayService->signature());
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

    // public function ratingGet(Request $request)
    // {
    //     try {
    //         $data = Transaction::with('user', 'ProductRatings', 'ProductRatings.product')
    //                     ->where('user_id', userId())
    //                     ->where('status_id', 4)
    //                     ->orderBy('created_at', 'desc')
    //                     ->get();

    //         $response = [
    //             'status' => 200,
    //             'message' => '',
    //             'data' => TransactionRatingProduct::collection($data),
    //         ];
    //     }
    //     catch (\Exception $e) {
    //         $response = [
    //             'status' => 503,
    //             'message' => $e->getMessage()
    //         ];
    //     }

    //     return response()->json($response, $response['status']);
    // }
}
