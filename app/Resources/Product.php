<?php

namespace App\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Product extends JsonResource
{
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "name" => $this->name,
            "slug" => $this->slug,
            "desc" => nl2br($this->desc),
            // "desc_br" => nl2br($this->desc),
            "stock" => $this->stock,
            "status" => $this->status,
            // "price" => $this->price,
            "price" => number_format($this->price, 0, ",", "."),
            "price_rp" => toRupiah($this->price),
            "discount" => ($this->discount) ? $this->discount . '%' : null,
            "price_discount" => ($this->discount) ? toRupiah($this->price - ($this->price * $this->discount / 100)) : null,
            "price_final" => ($this->discount) ? $this->price - ($this->price * $this->discount / 100) : $this->price,
            "price_final_rp" => ($this->discount) ? toRupiah($this->price - ($this->price * $this->discount / 100)) : toRupiah($this->price),
            "sold" => ($this->sold) ? $this->sold : 0,
            "ratings" => ProductRating::collection($this->productRatings),
            "rating_avg" => round($this->productRatings->avg('rating'), 2),
            "rating_count" => $this->productRatings->count(),
            "discussions" => ProductDiscussion::collection($this->productDiscussios),
            "category_id" => $this->category_id,
            "category" => ($this->category) ? $this->category->name : null,
            'file' => ($this->img1) ? url('/api/v1/storage', $this->img1) : url('/api/v1/storage', 'default.png'),
            'files' => $this->files(),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'weight' => $this->weight,
            'minorder' => $this->minorder,
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
