<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ProductDiscussion extends JsonResource
{
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "parent" => $this->parent,
            "desc" => $this->desc,
            "user" => $this->user,
            "product" => new ProductMin($this->product),
            "created_at" => $this->created_at,
            "updated_at" => $this->updated_at,
            "replay" => $this->children,
        ];
    }

}
