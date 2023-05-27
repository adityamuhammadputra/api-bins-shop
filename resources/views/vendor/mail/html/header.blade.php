@props(['url'])
<tr>
    <td class="header">
        <a href="{{ $url }}" style="display: inline-block;">
            <img src="{{ URL::to('/') }}/logo.png" class="logo" alt="Laravel Logo"> <span>Bins Shop</span>
        </a>
    </td>
</tr>
