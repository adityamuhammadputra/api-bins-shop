<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TransactionStatuses extends JsonResource
{
    public function toArray($request)
    {
        $color = 'warning';
        if (in_array($this->id, [10, 11]))
            $color = 'danger';

        if (in_array($this->id, [2, 3, 4]))
            $color = 'info';

        if (in_array($this->id, [5]))
            $color = 'success';

        return [
            "id" => $this->id,
            "name" => $this->name,
            "desc" => $this->desc,
            "color" => $color,
        ];
    }

}
