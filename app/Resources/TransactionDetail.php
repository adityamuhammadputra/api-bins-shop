<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TransactionDetail extends JsonResource
{
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "invoice" => $this->invoice,
            "notes" => $this->notes,
            "name" => $this->product_name,
            "qty" => $this->qty,
            "price" => $this->price,
            "price_rp" => "Rp" . number_format($this->price, 0, ",", "."),
            "price_discount" => $this->price_discount,
            "price_discount_rp" => "Rp" . number_format($this->price_discount, 0, ",", "."),
            "discount" => $this->discount,
            "total" => $this->total,
            "total_rp" => "Rp" . number_format($this->total, 0, ",", "."),
            "user_id" => $this->user_id,
            "transaction_id" => $this->transaction_id,
            "product" => new ProductMin($this->product),
            // "product" => new Product($this->product),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
