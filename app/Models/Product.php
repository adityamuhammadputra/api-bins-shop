<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Product extends BaseModel
{
    protected $guarded = [];
    protected $keyType = 'string';
    protected $with = ['category'];

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function scopeFiltered($query)
    {
        $query->when(request('q'), function ($query) {
            $query->where(function ($query) {
                $param = '%' . request('q') . '%';
                $query->where('name', 'like', $param);
            });
        });

        if (request('exclude')) {
            $query->when(request('exclude'), function ($query) {
                $query->where(function ($query) {
                    $query->whereNotIn('slug', explode(",",request('exclude')));
                });
            });
        }

        //for custom datatable
        if (request('search')) {
            $query->when(request('search')['value'], function ($query) {
                $param = '%' . request('search')['value'] . '%';
                $query->where('name', 'like', $param);
            });
        }

    }


}

