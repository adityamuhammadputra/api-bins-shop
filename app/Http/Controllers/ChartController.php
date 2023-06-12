<?php

namespace App\Http\Controllers;

use App\Models\Chart;
use App\Models\Product;
use App\Models\Transaction;
use App\Resources\Cart;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Str;

use Sawirricardo\Midtrans\Laravel\Facades\Midtrans;

class ChartController extends BaseController
{

    public function index(Request $request)
    {
        try {
            $data = Chart::with('product')
                    ->where('user_id', userId())
                    ->get();

            $response = [
                'status' => 200,
                'message' => '',
                'data' => Cart::collection($data),
            ];
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function store(Request $request)
    {
        try {
            $data = Product::findOrFail($request->product_id);

            $input['id'] = uuId();
            $input['user_id'] = userId();

            $input['product_id'] = $data->id;
            $input['qty'] = $request->qty ?? 1;

            $check = Chart::where('user_id', userId())
                        ->where('product_id', $data->id)
                        ->first();
            if (!$check) {
                Chart::create($input);
            } else {
                Chart::where('user_id', userId())
                        ->where('product_id', $data->id)
                        ->update([
                            'qty' => $check->qty + 1
                        ]);
            }
            $response = [
                'status' => 200,
                'message' => Str::limit($data->name, 20, '...'). " ditambahkan ke keranjang",
            ];

            userCreateLog('Has Add Cart');

        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function update(Request $request, Chart $chart)
    {
        $chart->notes = $request->notes;
        $chart->qty = $request->qty;
        $chart->save();

        return response()->json($chart, 200);
    }

    function destroy(Chart $chart)
    {
        try {
            // $data = $chart;
            $data = Product::findOrFail($chart->product_id);
            $chart->delete();
            $response = [
                'status' => 200,
                'message' => Str::limit($data->name, 12, '...'). " berhasil dihapus",
            ];

            userCreateLog('Has Remove Cart');
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function count(Request $request)
    {
        if (user()) {
            $response = [
                'status' => 200,
                'message' => Chart::where('user_id', userId())->count(),
            ];
        } else {
            $response = [
                'status' => 200,
                'message' => 0,
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function countNotif(Request $request)
    {
        if (user()) {
            $response = [
                'status' => 200,
                'message' => Transaction::filtered()
                                ->where('user_id', userId())
                                ->count(),
            ];
        } else {
            $response = [
                'status' => 200,
                'message' => 0,
            ];
        }

        return response()->json($response, $response['status']);

    }
}
