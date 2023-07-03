<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

use Tymon\JWTAuth\Contracts\JWTSubject;


class User extends Authenticatable implements JWTSubject
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'provider',
        'provider_id',
        'email',
        'avatar',
        'password',
        'last_seen',
    ];

    protected $primaryKey = 'email';
    protected $keyType = 'string';


    public function getJWTIdentifier()
    {
        // return $this->getKey();
        return $this->email;
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        // 'id',
        'password',
        'remember_token',
        'last_ip',
        'status',
        // 'admin',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function transactions(): HasMany
    {
        return $this->HasMany(Transaction::class, 'user_id', 'id');
    }

    public function transactionSuccess(): HasMany
    {
        return $this->HasMany(Transaction::class, 'user_id', 'id')->where('status_id', 4);
    }


    public function scopeFiltered($query)
    {
        if (request('admin')) {
            if (request('admin') == 1) {
                $query->where('admin', 1);
            } else {
                $query->whereNull('admin');
            }
        }

        $query->when(request('q'), function ($query) {
            $query->where(function ($query) {
                $param = '%' . request('q') . '%';
                $query->where('name', 'like', $param)
                    ->orWhere('email', 'like', $param)
                    ->orWhere('phone', 'like', $param);
            });
        });
    }

}
