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
