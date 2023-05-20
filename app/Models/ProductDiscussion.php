<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductDiscussion extends BaseModel
{
    protected $keyType = 'string';
    protected $guarded = [];

    protected $with = ['user'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

}
