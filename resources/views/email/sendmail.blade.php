


@component('mail::message')
# INV20230524175505 <span style="float:right;"> Menunggu Pembayaran</span>

<b>Hallo muhammad aditya </b> <br>Pesanan kamu<br>

@component('mail::panel')

<table style="width: 100%;">
    <tr>
        <td> Office 2021 x 1</td>
        <td style="text-align: right;"> Rp. 115.000</td>
    </tr>
    <tr>
        <td> Office 2019 x 2</td>
        <td style="text-align: right;"> Rp. 100.000</td>
    </tr>
    <tr>
        <td><b>Total Harga</b></td>
        <td style="text-align: right;"> <b>Rp. 215.000</b></td>
    </tr>
</table>
@endcomponent


Status Pesanan:<br>
<b>Pemesanan berhasil, menunggu verifikasi pembayaran</b>
<br>
<br>
Klik tombol lihat pesanan, untuk melihat detail pesanan kamu<br>

@component('mail::button', ['url' => 'https://bins.shop/order/inv',  'color' => 'red'])
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
