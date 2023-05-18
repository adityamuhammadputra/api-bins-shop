<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TransactionRating extends JsonResource
{
    public function toArray($request)
    {
        return [
            "rating" => $this->rating,
            "desc" => $this->desc,
        ];
    }

}
