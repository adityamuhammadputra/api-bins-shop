<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ProductRating extends JsonResource
{
    public function toArray($request)
    {
        return [
            "rating" => $this->rating,
            "desc" => $this->desc,
            "user" => new User($this->user),
            "product" => new ProductMin($this->product),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
