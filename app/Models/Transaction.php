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
        return $this->belongsTo(User::class, 'user_id', 'id');
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
            if (is_array(request('status'))) {
                $assetStatus = AssetStatus::pluck('id');
                $in = [];
                foreach(request('status') as $key => $val) {
                    array_push($in, $assetStatus[$val]);
                }
                $data = $in;
            } else {
                $data = explode(",", request('status'));
            }
            $query->whereIn('status_id', $data);
        }

        if (request('q')) {
            $query->when(request('q'), function ($query) {
                $param = '%' . request('q') . '%';
                $query->where(function($query) use($param){
                    $query->where('invoice', 'like', $param)
                    ->orWhereHas('user', function($query) use($param){
                        $query->where('name', 'like', $param);
                    })
                    ->orWhereHas('transactionDetails', function($query) use($param){
                        $query->where('product_name', 'like', $param);
                    });
                });

            });
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
