<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TransactionStatuses extends JsonResource
{
    public function toArray($request)
    {
        return [
            "name" => $this->assetStatus->name,
            "desc" => $this->assetStatus->desc,
            "date" => dateTimeOutput2($this->created_at),
        ];
    }
}
