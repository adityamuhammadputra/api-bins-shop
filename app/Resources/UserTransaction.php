<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UserTransaction extends JsonResource
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
            "created_at" => $this->created_at,
            "provider" => $this->provider,
            // "transactions" => $this->transactionSuccess,
            "transaction_success_total" => count($this->transactionSuccess),
            "transaction_success_total_price" => toRupiah($this->transactionSuccess->sum('total')),
        ];
    }

}
