<?php

namespace App\Resources;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;

class TransactionWithStatus extends JsonResource
{
    public function toArray($request)
    {
        // $trans = new Transaction($this);
        // $trans['transaction_statuses'] = TransactionStatuses::collection($this->transactionStatuses);
        // return $trans;
        return [
            "id" => $this->id,
            "invoice" => $this->invoice,
            "status" => new TransactionStatus($this->assetStatus),
            "price" => $this->price,
            "price_rp" => toRupiah($this->price),
            "qty" => $this->qty,
            "discount" => $this->discount,
            "total" => $this->total,
            "total_rp" => toRupiah($this->total),
            "notes" => $this->notes,
            "user_id" => $this->user_id,
            "transaction_provider" => [
                'provider' => $this->provider,
                'order_id' => $this->order_id,
                'gross_amount' => $this->gross_amount,
                'received_amount' => $this->received_amount,
                // 'status_code' => $this->status_code,
                'transaction_id' => $this->transaction_id,
                'transaction_status' => $this->transaction_status,
                'transaction_time' => $this->transaction_time,
                'payment_type' => $this->payment_type,
                'payment_timeout' => $this->payment_timeout,
                'payment_diff' => (Carbon::now() < Carbon::parse($this->payment_timeout)) ? Carbon::parse($this->payment_timeout)->diffInRealMilliseconds(Carbon::now()) : 0,
                'payment_token' => $this->payment_token,
            ],
            "transaction_rating" => new ProductRating($this->ProductRating),
            "transaction_details" => TransactionDetail::collection($this->transactionDetails),
            "transaction_statuses" => TransactionStatuses::collection($this->transactionStatuses),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
