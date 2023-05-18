<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends BaseModel
{
    protected $guarded = [];
    protected $keyType = 'string';
    protected $with = ['category'];

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function transactionDetails(): HasMany
    {
        return $this->hasMany(TransactionDetail::class);
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
                    $query->whereNotIn('slug', explode(",", request('exclude')));
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

    public function scopeSort($query)
    {
        if (request('sort')) {
            if (request('sort') == 1) {
                $query->orderBy('sold', 'desc');
                // $query->withCount('transactionDetails')->orderBy('transaction_details_count', 'desc');
            }
            if (request('sort') == 2) {
                $query->orderBy('created_at', 'desc');
            }
            if (request('sort') == 3) {
                $query->orderBy('price', 'asc');
            }
            if (request('sort') == 4) {
                $query->orderBy('price', 'desc');
            }
        }
    }

}

