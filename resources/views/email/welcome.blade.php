


@component('mail::message')
Hai, <b>{{ $data }} !</b>

@component('mail::panel')
<p>Terimakasih telah menggunakan <b>binsshop.tech</b> :) </p>
@endcomponent

<p>Kamu bisa Transaksi dengan mudah dan aman disini.
    Setiap Transaksi yang kamu lakukan di binsshop.tech, akan kami beritahu melaui email ini yaa..
    <br>
    <br>
    Jika perlu kami, jangan ragu untuk langsung hubungi kami yaa :)
</p>

@component('mail::button', ['url' => 'https://api.whatsapp.com/send/?phone=62816262439&text=Hai admin, mau tanya&type=phone_number&app_absent=0',  'color' => 'red'])
Tanya Admin
@endcomponent

<br>
<br>
<i style="font-size: 12px;">E-mail ini dibuat otomatis, mohon untuk tidak membalas, jika ada pertanyaan atau membutuhkan bantuan silahkan hubungi
    <br>WA: 0816262439 (chat only)
</i>
<br>
<br>

Thanks,<br>
{{ config('app.name') }}

@endcomponent
