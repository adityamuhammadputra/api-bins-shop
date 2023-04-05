<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Cart extends JsonResource
{
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "qty" => $this->qty,
            "status" => $this->status,
            "notes" => $this->notes,
            "product" => new Product($this->product),
        ];
    }

}
