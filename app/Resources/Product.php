<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Product extends JsonResource
{
    public function toArray($request)
    {
        $solds = $this->transactionDetails;
        return [
            "id" => $this->id,
            "name" => $this->name,
            "slug" => $this->slug,
            "desc" => $this->desc,
            "stock" => $this->stock,
            "status" => $this->status,
            "price" => $this->price,
            "price_rp" => "Rp" . number_format($this->price, 0, ",", "."),
            "discount" => ($this->discount) ? $this->discount . '%' : null,
            "price_discount" => ($this->discount) ? "Rp" . number_format($this->price - ($this->price * $this->discount / 100), 0, ",", ".") : null,
            "sold" => count($solds),
            "rating" => (count($solds) > 0) ? 5 : 0,
            "category" => ($this->category) ? $this->category->name : null,
            'file' => ($this->img1) ? url('/api/v1/storage', $this->img1) : url('/api/v1/storage', 'default.png'),
            'files' => $this->files(),
        ];
    }

    protected function files()
    {
        $files = [];

        $limitFile = ['img1', 'img2', 'img3', 'img4', 'img5'];

        foreach ($limitFile as $value) {
            if ($this->{$value}) {
                $files [] = [
                    'name' => $value,
                    'path' => url('/api/v1/storage', $this->{$value}),
                ];
            }
        }

        return $files;
    }

}
