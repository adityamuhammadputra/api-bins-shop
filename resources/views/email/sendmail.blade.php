


@component('mail::message')
# {{ $data->invoice }} <span style="float:right;"> {{ $data->status_name }}</span>
<br>

Hai {{ $data->user }}. <b>{{ $data->status_desc }}</b>

@component('mail::panel')
<table style="width: 100%;">
    @if (isset($data->product) && count($data->product) > 0)
    @foreach ($data->product as $product)
    <tr>
        <td> {{ $product['product_name'] }} x {{ $product['qty'] }}</td>
        <td style="text-align: right;"> {{ toRupiah($product['price_discount']) }}</td>
    </tr>
    @endforeach
    @endif
    <tr>
        <td><b>Total Harga</b></td>
        <td style="text-align: right;"> <b>{{ $data->price }}</b></td>
    </tr>
    @if (isset($data->payment_timeout))
    <tr>
        <td colspan="2" style="padding-top: 30px;font-size: 14px;"><i>Silahkan lakukan pembayaran sebelum pukul {{ $data->payment_timeout }}</i></td>
    </tr>
    @endif
</table>
@endcomponent

<br>
Klik tombol <b>lihat pesanan</b>, untuk melihat detail pesanan kamu<br>

@component('mail::button', ['url' => 'https://bins.shop/' . $data->link,  'color' => 'red'])
Lihat Pesanan
@endcomponent

<i style="font-size: 14px;">E-mail ini dibuat otomatis, mohon untuk tidak membalas, jika ada pertanyaan atau membutuhkan bantuan silahkan hubungi
    <br>WA: 0816262439 (chat only)
</i>
<br>
<br>

Thanks,<br>
{{ config('app.name') }}

@endcomponent
