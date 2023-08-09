<?php

use App\Mail\SendEmail;
use App\Models\UserLog;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use Ramsey\Uuid\Uuid;

function user()
{
    return auth()->user();
}

function userId()
{
    return auth()->user()->id;
}

function userName()
{
    return auth()->user()->name;
}

function uuId()
{
    $uuid1 = Uuid::uuid1();
    return $uuid1->toString();
}

function dateInput($date)
{
    if (!$date)
        return null;
    $d =  Carbon::createFromFormat('d F Y', $date);
    return Carbon::parse($d)->format('Y-m-d');
}

function dateInput2($date)
{
    if (!$date)
        return null;
    $d =  Carbon::createFromFormat('d/m/Y', $date);
    return Carbon::parse($d)->format('Y-m-d');
}

function dateOutput($date)
{
    if (!$date)
        return '';
    return Carbon::parse($date)->format('d F Y');
}

function dateOutput2($date)
{
    if (!$date)
        return '-';
    return Carbon::parse($date)->format('d/m/Y');
}

function dateOutputIndo($date, $lc = 'IND')
{
    if ($date != null) {
        $dt = new Carbon($date);
        setlocale(LC_TIME, $lc);
        return $dt->formatLocalized('%e %B %Y');
    } else {
        return null;
    }
}

function dateTimeOutput($date)
{
    if (!$date)
        return '-';
    return Carbon::parse($date)->format('d/m/Y H:i:s');
}

function dateTimeOutput2($date)
{
    if (!$date)
        return '-';
    return Carbon::parse($date)->format('d F Y, H:i:s');
}

function toRupiah($val)
{
    if ($val) {
        return "Rp " .number_format($val, 0, ",", ".");
    }

    return "Rp 0";
}

function sendMail($data)
{
    if ($data->to) {
        Mail::to($data->to)->send(new SendEmail($data));
    }
}

function userCreateLog($desc)
{
    $data = [
        'id' => uuId(),
        'user_id' => (user()) ? userId() : null,
        'url' => request()->url(),
        'method' => request()->method(),
        'desc' => $desc,
        'ip_address' => $_SERVER['REMOTE_ADDR'],
    ];

    UserLog::create($data);
}


function iconUrl($code)
{
    $icons = [
        'BNIVA' => 'https://assets.tripay.co.id/upload/payment-icon/n22Qsh8jMa1583433577.png',
        'BRIVA' => 'https://assets.tripay.co.id/upload/payment-icon/8WQ3APST5s1579461828.png',
        'MANDIRIVA' => 'https://assets.tripay.co.id/upload/payment-icon/T9Z012UE331583531536.png',
        'BCAVA' => 'https://assets.tripay.co.id/upload/payment-icon/ytBKvaleGy1605201833.png',
        'BSIVA' => 'https://assets.tripay.co.id/upload/payment-icon/tEclz5Assb1643375216.png',
        'ALFAMART' => 'https://assets.tripay.co.id/upload/payment-icon/jiGZMKp2RD1583433506.png',
        'INDOMARET' => 'https://assets.tripay.co.id/upload/payment-icon/zNzuO5AuLw1583513974.png',
        'OVO' => 'https://assets.tripay.co.id/upload/payment-icon/fH6Y7wDT171586199243.png',
        'QRISC' => 'https://assets.tripay.co.id/upload/payment-icon/m9FtFwaBCg1623157494.png',
        'SHOPEEPAY' => 'https://assets.tripay.co.id/upload/payment-icon/d204uajhlS1655719774.png',
    ];

    return $icons[$code];
}
