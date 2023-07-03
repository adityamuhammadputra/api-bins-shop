<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class User extends JsonResource
{
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "name" => $this->name,
            "email" => $this->email,
            "phone" => $this->phone,
            "avatar" => $this->avatar,
            "admin" => ($this->admin) ? true : false,
            "last_seen" => $this->last_seen,
            "created_at" => $this->created_at,
            "provider" => $this->provider,
        ];
    }

}
