<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TransactionStatus extends JsonResource
{
    public function toArray($request)
    {
        $color = 'warning';
        if (in_array($this->id, [10, 11]))
            $color = 'danger';

        if (in_array($this->id, [2, 3]))
            $color = 'info';

        if (in_array($this->id, [4]))
            $color = 'success';

        return [
            "id" => $this->id,
            "name" => $this->name,
            "desc" => $this->desc,
            "color" => $color,
        ];
    }

}
