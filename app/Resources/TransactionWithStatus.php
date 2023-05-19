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
            "price_rp" => "Rp" . number_format($this->price, 0, ",", "."),
            "qty" => $this->qty,
            "discount" => $this->discount,
            "total" => $this->total,
            "total_rp" => "Rp" . number_format($this->total, 0, ",", "."),
            "notes" => $this->notes,
            "user_id" => $this->user_id,
            "transaction_midtrans" => [
                'order_id' => $this->order_id,
                'gross_amount' => $this->gross_amount,
                'status_code' => $this->status_code,
                'transaction_status' => $this->transaction_status,
                'transaction_time' => $this->transaction_time,
                'payment_type' => $this->payment_type,
                'payment_timeout' => $this->payment_timeout,
                'payment_diff' => (Carbon::now() < Carbon::parse($this->payment_timeout)) ? Carbon::parse($this->payment_timeout)->diffInRealMilliseconds(Carbon::now()) : 0,
                'payment_token' => $this->payment_token,
            ],
            "transaction_rating" => new TransactionRating($this->transactionRating),
            "transaction_details" => TransactionDetail::collection($this->transactionDetails),
            "transaction_statuses" => TransactionStatuses::collection($this->transactionStatuses),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
