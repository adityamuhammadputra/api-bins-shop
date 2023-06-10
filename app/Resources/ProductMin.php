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
            "desc" => nl2br($this->desc),
            "category_id" => $this->category_id,
            // "price" => $this->price,
            "price" => number_format($this->price, 0, ",", "."),
            "minorder" => $this->minorder,
            "stock" => $this->stock,
            "weight" => $this->weight,
            "status" => $this->status,
            "price_rp" => toRupiah($this->price),
            "price_final_rp" => ($this->discount) ? toRupiah($this->price - ($this->price * $this->discount / 100)) : toRupiah($this->price),
            "discount" => ($this->discount) ? $this->discount . '%' : null,
            "price_discount" => ($this->discount) ? toRupiah($this->price - ($this->price * $this->discount / 100)) : null,
            "sold" => ($this->sold) ? $this->sold : 0,
            // "price_discount_rp" => toRupiah($this->price_discount),
            'file' => ($this->img1) ? url('/api/v1/storage', $this->img1) : url('/api/v1/storage', 'default.png'),
            'files' => $this->files(),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
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
