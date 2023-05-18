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

    public function transactionRating(): HasOne
    {
        return $this->hasOne(TransactionRating::class);
    }
}
