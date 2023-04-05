<?php

namespace App\Http\Controllers;

use App\Models\Chart;
use App\Models\Product;
use App\Models\User;
use App\Resources\Cart;
use App\Resources\Product as ResourcesProduct;
use App\Resources\User as ResourcesUser;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Str;

use Sawirricardo\Midtrans\Laravel\Facades\Midtrans;

class UserController extends BaseController
{

    public function craeteOrUpdate(Request $request)
    {
        $user = User::where('auth', $request->sub)
                    ->first();
        if ($user) {
            return $user;
        }
        $user = User::create([
            'auth' => $request->sub,
            'email' => $request->email,
            'name' => $request->name,
            'avatar' => $request->picture,
        ]);

        return $user;
    }

    public function user(Request $request)
    {
        return $request;
    }

    public function index(Request $request)
    {
        try {
            $data = User::paginate();

            $response = [
                'status' => 200,
                'message' => 'success',
                'data' => ResourcesUser::collection($data),
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
}
