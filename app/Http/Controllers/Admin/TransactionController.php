<?php

namespace App\Http\Controllers\Admin;

use App\Models\AssetStatus;
use App\Models\Transaction;
use App\Models\TransactionStatus;
use App\Resources\Transaction as ResourcesTransaction;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;


class TransactionController extends BaseController
{
    public function index(Request $request)
    {
        try {
            $data = Transaction::filtered()
                        ->with('assetStatus', 'user', 'transactionDetails', 'ProductRating')
                        ->orderBy('created_at', 'desc')
                        ->paginate(50);

            return ResourcesTransaction::collection($data);
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function status()
    {
        try {
            return AssetStatus::pluck('name', 'id');
        } catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);

    }

    public function update(Request $request, Transaction $transaction)
    {
        $status = $request->status;
        if ($status == 3)
            $msg= 'Pembayaran berhasil validasi';
        if ($status == 4)
            $msg= 'Pesanan berhasil diselesaikan';

        try{
            $transaction->status_id = $status;
            $transaction->save();
            TransactionStatus::create([
                'id' => uuId(),
                'user_id' => $transaction->user_id,
                'transaction_id' => $transaction->id,
                'status_id' => $status,
            ]);

            $assetStatus = AssetStatus::find($status);
            $dataEmail = (object) [
                'subject' => "#$transaction->invoice, $assetStatus->name",
                'to' => $transaction->user->email,
                'invoice' => $transaction->invoice,
                'user' => $transaction->user->name,
                'price' => toRupiah($transaction->total),
                'status_name' => $assetStatus->name,
                'status_desc' => $assetStatus->desc_email,
                'link' => "order/$transaction->id",
            ];
            sendMail($dataEmail);

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

}
