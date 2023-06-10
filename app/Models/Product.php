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

    public function productRatings(): HasMany
    {
        return $this->hasMany(ProductRating::class)->orderBy('created_at', 'desc');
    }

    public function productDiscussios(): HasMany
    {
        return $this->hasMany(ProductDiscussion::class)->whereNull('parent')->orderBy('created_at', 'desc');
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

        if (request('status')) {
            if (is_array(request('status'))) {
                $query->whereIn('status', request('status'));
            }
        } else {
            $query->where('status', 1);
        }

        $query->whereNull('deleted_at');
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
        } else {
            $query->orderBy('updated_at', 'desc');
        }
    }

}

