<?php

use Carbon\Carbon;
use Ramsey\Uuid\Uuid;

function user()
{
    return auth()->user();
}

function userId()
{
    return auth()->user()->id;
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
