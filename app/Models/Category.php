<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends BaseModel
{
    protected $guarded = [];

    public function products(): HasMany
    {
        // return $this->hasMany(Comment::class, 'foreign_key', 'local_key');
        return $this->hasMany(Product::class);
    }


}
