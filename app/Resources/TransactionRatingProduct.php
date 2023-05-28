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
            "price_rp" => toRupiah($this->price),
            "qty" => $this->qty,
            "discount" => $this->discount,
            "total" => $this->total,
            "total_rp" => toRupiah($this->total),
            "notes" => $this->notes,
            "user_id" => $this->user_id,
            "transaction_rating" => ProductRating::collection($this->ProductRatings),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
