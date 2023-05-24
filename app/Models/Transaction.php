<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Transaction extends BaseModel
{
    protected $keyType = 'string';
    protected $guarded = [];

    protected $with = ['assetStatus', 'transactionDetails'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function assetStatus(): BelongsTo
    {
        return $this->belongsTo(AssetStatus::class, 'status_id', 'id');
    }

    public function transactionDetails(): HasMany
    {
        return $this->hasMany(TransactionDetail::class);
    }

    public function transactionStatuses(): HasMany
    {
        return $this->hasMany(TransactionStatus::class)->orderBy('created_at', 'desc');
    }

    public function transactionRating(): HasMany
    {
        return $this->hasMany(ProductRating::class);
    }

    public function ProductRating(): HasOne
    {
        return $this->hasOne(ProductRating::class);
    }

    public function ProductRatings(): hasMany
    {
        return $this->hasMany(ProductRating::class);
    }


    public function scopeFiltered($query)
    {
        if (request('status')) {
            $query->whereIn('status_id', explode(",", request('status')));
        }

        if (request('rating')) {
            $hasRating = request('rating');
            if ($hasRating == 1) {
                $query->whereHas('transactionRating');
            } else {
                $query->doesntHave('transactionRating');
            }
        }
    }
}
