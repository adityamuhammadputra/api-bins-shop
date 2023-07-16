<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductDiscussion extends BaseModel
{
    protected $keyType = 'string';
    protected $guarded = [];

    protected $with = ['user', 'children', 'product'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    public function children()
    {
        return $this->hasMany(self::class, 'parent')
                ->orderBy('created_at', 'asc')
                ->whereHas('user');
    }

    public function scopeFiltered($query)
    {
        if (request('status')) {
            if (request('status') == 1) {
                $query->whereHas('children');
            } else {
                $query->doesntHave('children');
            }
        }

        if (request('replay')) {
            if (request('replay') == 1) {
                $query->whereHas('children', function($query){
                    $query->where('user_id', userId());
                });
            } else {
                $query->doesntHave('children')
                    ->orWhereHas('children', function($query){
                        $query->where('user_id', '!=', userId());
                    });
                //     ->orWhereRaw("(user_id != $userId and parent is null)");
            }
        }




        $query->whereNotNull('product_id');
    }

}
