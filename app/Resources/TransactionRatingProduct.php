<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TransactionRatingProduct extends JsonResource
{
    public function toArray($request)
    {
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
            "transaction_rating" => ProductRating::collection($this->ProductRatings),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
