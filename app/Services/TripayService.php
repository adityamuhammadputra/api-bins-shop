<?php

namespace App\Services;

use Carbon\Carbon;

class TripayService {

    public function signature()
    {
        $privateKey   = config('tripay.private_key');
        $merchantCode = config('tripay.kode');
        $merchantRef  = 'INV55567';
        $amount       = 1500000;

        return hash_hmac('sha256', $merchantCode.$merchantRef.$amount, $privateKey);
    }

}
