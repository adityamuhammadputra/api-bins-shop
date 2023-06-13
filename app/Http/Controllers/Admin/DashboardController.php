<?php

namespace App\Http\Controllers\Admin;

use App\Models\Chart;
use App\Models\ProductSeen;
use App\Models\Transaction;
use App\Models\User;
use App\Models\UserLog;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;

class DashboardController extends BaseController
{

    protected $ctrDiscuss;

    public function __construct()
    {
        $this->ctrDiscuss = app(DiscussionController::class);
    }

    public function index(Request $request)
    {
        $transactions = Transaction::whereIn('status_id', [2, 3, 9])
                            ->get();
        $dataDiscuss = $this->ctrDiscuss->index($request, true);

        $row1 = [
            [
                'color' => 'white',
                'total' => $transactions->where('status', 2)->count(),
                'label' => 'Pesanan Baru',
                'price' => toRupiah($transactions->where('status', 2)->sum('price')),
                'icon' => 'mdi-emoticon-happy-outline',
                'url' => 'transaction?status=1',
            ],
            [
                'color' => 'white',
                'total' => $transactions->where('status', 2)->count(),
                'label' => 'Pesanan Dikirim',
                'price' => toRupiah($transactions->where('status', 3)->sum('price')),
                'icon' => 'mdi-sticker-emoji',
                'url' => 'transaction?status=2',
            ],
            [
                'color' => 'white',
                'total' => $transactions->where('status', 9)->count(),
                'label' => 'Pengajuan Refund',
                'price' => toRupiah($transactions->where('status', 9)->sum('price')),
                'icon' => 'mdi-emoticon-sad-outline',
                'url' => 'transaction?status=4',
            ],
            [
                'color' => 'info',
                'total' => $dataDiscuss,
                'label' => 'Diskusi Belum Dibalas',
                'price' => null,
                'icon' => 'mdi-forum-outline',
                'url' => 'discuss',
            ],
        ];

        $procuctSeenToday = ProductSeen::whereDate('created_at', Carbon::today())->count();
        $procuctSeenYesterday = ProductSeen::whereDate('created_at', Carbon::yesterday())->count();
        $productSeenStat = $this->persen($procuctSeenToday, $procuctSeenYesterday);

        $procuctCartToday = Chart::whereDate('created_at', Carbon::today())->count();
        $procuctCartYesterday = Chart::whereDate('created_at', Carbon::yesterday())->count();
        $productCartStat = $this->persen($procuctCartToday, $procuctCartYesterday);

        $procuctTransactionToday = Transaction::whereDate('created_at', Carbon::today())->whereIn('status_id', [2, 3, 4])->sum('qty');
        $procuctTransactionYesterday = Transaction::whereDate('created_at', Carbon::yesterday())->whereIn('status_id', [2, 3, 4])->sum('qty');
        $productTransactionStat = $this->persen($procuctTransactionToday, $procuctTransactionYesterday);

        $procuctTransactionPriceToday = Transaction::whereDate('created_at', Carbon::today())->whereIn('status_id', [2, 3, 4])->sum('total');
        $procuctTransactionPriceYesterday = Transaction::whereDate('created_at', Carbon::yesterday())->whereIn('status_id', [2, 3, 4])->sum('total');
        $productTransactionPriceStat = $this->persen($procuctTransactionPriceToday, $procuctTransactionPriceYesterday);

        $colors = ['#2E93fA', '#0051a3', '#aadc8d', '#4caf50'];
        $labels = ['Produk Dilihat', 'Produk Dikeranjang', 'Produk Terjual', 'Potensi Penjualan'];
        $row2 = [
            [
                'color' => $colors[0],
                'total' => $procuctSeenToday,
                'total_yesterday' => $procuctSeenYesterday,
                'label' => $labels[0],
                'stat' => number_format((float)$productSeenStat, 2, '.', '') . '% dari kemarin',
                'stat_color' => ($procuctSeenYesterday > $procuctSeenToday) ? '#c81818' : (($procuctSeenYesterday == $procuctSeenToday) ? '#bdbdbd' : '#4caf50'),
            ],
            [
                'color' => $colors[1],
                'total' => $procuctCartToday,
                'total_yesterday' => $procuctCartYesterday,
                'label' => $labels[1],
                'stat' => number_format((float)$productCartStat, 2, '.', '') . '% dari kemarin',
                'stat_color' => ($procuctCartYesterday > $procuctCartToday) ? '#c81818' : (($procuctCartYesterday == $procuctCartToday) ? '#bdbdbd' : '#4caf50'),
            ],
            [
                'color' => $colors[2],
                'total' => $procuctTransactionToday,
                'total_yesterday' => $procuctTransactionYesterday,
                'label' => $labels[2],
                'stat' => number_format((float)$productTransactionStat, 2, '.', '') . '% dari kemarin',
                'stat_color' => ($procuctTransactionYesterday > $procuctTransactionToday) ? '#c81818' : (($procuctTransactionYesterday == $procuctTransactionToday) ? '#bdbdbd' : '#4caf50'),
            ],
            [
                'color' => $colors[3],
                'total' => toRupiah($procuctTransactionPriceToday),
                'total_yesterday' => $procuctTransactionPriceYesterday,
                'label' => $labels[3],
                'stat' => number_format((float)$productTransactionPriceStat, 2, '.', '') . '% dari kemarin',
                'stat_color' => ($procuctTransactionPriceYesterday > $procuctTransactionPriceToday) ? '#c81818' : (($procuctTransactionPriceYesterday == $procuctTransactionPriceToday) ? '#bdbdbd' : '#4caf50'),
            ],
        ];

        // row 3 start
        $keyTime = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23];
        $categories = ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23];

        $productSeen = DB::table('product_seens')
                        ->select(DB::raw('hour(created_at) as jam'), DB::raw('COUNT(id) as total'))
                        ->whereDate('created_at', Carbon::now())
                        ->groupBy(DB::raw('hour(created_at)'))
                        ->get()
                        ->pluck('total', 'jam')
                        ->toArray();

        $productCart = DB::table('charts')
                        ->select(DB::raw('hour(created_at) as jam'), DB::raw('COUNT(id) as total'))
                        ->whereDate('created_at', Carbon::now())
                        ->groupBy(DB::raw('hour(created_at)'))
                        ->get()
                        ->pluck('total', 'jam')
                        ->toArray();

        $productTransaction = DB::table('transactions')
                        ->select(DB::raw('hour(created_at) as jam'), DB::raw('SUM(qty) as total'))
                        ->whereDate('created_at', Carbon::now())
                        ->whereIn('status_id', [2, 3, 4])
                        ->groupBy(DB::raw('hour(created_at)'))
                        ->get()
                        ->pluck('total', 'jam')
                        ->toArray();

        $productTransactionPrice = DB::table('transactions')
                        ->select(DB::raw('hour(created_at) as jam'), DB::raw('SUM(total) as total'))
                        ->whereDate('created_at', Carbon::now())
                        ->whereIn('status_id', [2, 3, 4])
                        ->groupBy(DB::raw('hour(created_at)'))
                        ->get()
                        ->pluck('total', 'jam')
                        ->toArray();

        $seriesProductSeen = [];
        foreach ($keyTime as $time) {
            if (in_array($time, array_keys($productSeen))) {
                array_push($seriesProductSeen, $productSeen[$time]);
            } else {
                array_push($seriesProductSeen, 0);
            }
        }


        $seriesProductCart = [];
        foreach ($keyTime as $time) {
            if (in_array($time, array_keys($productCart))) {
                array_push($seriesProductCart, $productCart[$time]);
            } else {
                array_push($seriesProductCart, 0);
            }
        }

        $seriesProductTransaction = [];
        foreach ($keyTime as $time) {
            if (in_array($time, array_keys($productTransaction))) {
                array_push($seriesProductTransaction, $productTransaction[$time]);
            } else {
                array_push($seriesProductTransaction, 0);
            }
        }

        // $seriesProductTransactionPrice = [];
        // foreach ($keyTime as $time) {
        //     if (in_array($time, array_keys($productTransactionPrice))) {
        //         array_push($seriesProductTransactionPrice, $productTransactionPrice[$time]);
        //     } else {
        //         array_push($seriesProductTransactionPrice, 0);
        //     }
        // }

        // return $seriesProductTransaction;


        $series = [
            [
                'name' => $labels[0],
                'data' => $seriesProductSeen,
            ],
            [
                'name' => $labels[1],
                'data' => $seriesProductCart,
            ],
            [
                'name' => $labels[2],
                'data' => $seriesProductTransaction,
            ],
            // [
            //     'name' => $labels[3],
            //     'data' => $seriesProductTransactionPrice,
            // ],
        ];

        // return Carbon::now()->subMinutes(2);

        $row3 = [
            'colors' => $colors,
            'labels' => $labels,
            'categories' => $categories,
            'series' => $series,
        ];
        $response = [
            'row1' => $row1,
            'row2' => $row2,
            'row3' => $row3,
            'row4' => [
                'logs' => UserLog::with('user')
                                ->whereDate('created_at', Carbon::now())->limit(50)
                                ->orderBy('created_at', 'desc')
                                ->get(),

                'user_online' => User::whereNull('admin')
                                    ->whereNotNull('last_seen')
                                    ->where('last_seen', '>=', Carbon::now()->subMinutes(2))
                                    ->get(),
            ]
        ];



        return response()->json($response, 200);
    }

    public function persen($today, $yesterday)
    {
        if ($today == 0 && $yesterday == 0)
            $stat = 0;
        else if($yesterday == 0)
            $stat = 100;
        else
            $stat = ($today - $yesterday) / $yesterday * 100;

        return $stat;
    }

}
