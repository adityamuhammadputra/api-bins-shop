<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Transaction extends JsonResource
{
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "invoice" => $this->invoice,
            "status" => $this->assetStatus,
            "price" => $this->price,
            "price_rp" => "Rp" . number_format($this->price, 0, ",", "."),
            "qty" => $this->qty,
            "discount" => $this->discount,
            "total" => $this->total,
            "notes" => $this->notes,
            "user_id" => $this->user_id,
            "transaction_details" => TransactionDetail::collection($this->transactionDetails),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
