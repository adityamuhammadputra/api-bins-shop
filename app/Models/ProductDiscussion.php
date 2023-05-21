<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductDiscussion extends BaseModel
{
    protected $keyType = 'string';
    protected $guarded = [];

    protected $with = ['user', 'children'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function children()
    {
        return $this->hasMany(self::class, 'parent')->orderBy('created_at', 'asc');
    }

}
