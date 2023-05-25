<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ProductMin extends JsonResource
{
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "name" => $this->name,
            "slug" => $this->slug,
            "desc" => $this->desc,
            "price" => $this->price,
            "price_rp" => "Rp" . number_format($this->price, 0, ",", "."),
            "discount" => ($this->discount) ? $this->discount . '%' : null,
            "price_discount" => ($this->discount) ? "Rp" . number_format($this->price - ($this->price * $this->discount / 100), 0, ",", ".") : null,
            // "price_discount_rp" => "Rp" . number_format($this->price_discount, 0, ",", "."),
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
