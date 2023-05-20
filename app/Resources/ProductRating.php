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
            "user" => $this->user,
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
        ];
    }

}
