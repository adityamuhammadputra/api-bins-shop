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
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserController extends BaseController
{

    public function __construct()
    {
        // $this->middleware('auth:api', ['except' => ['login']]);
    }

    public function login(Request $request)
    {
        $user = User::where('email', $request->email)
                    ->first();

        if ($user) {
            $user->avatar = $request->picture;
            $user->save();
            return $this->tokenLogin();
        } else {
            $user = User::create([
                'g' => $request->sub,
                'email' => $request->email,
                'name' => $request->name,
                'avatar' => $request->picture,
                'password' => Hash::make('password'),
            ]);
            return $this->tokenLogin();
        }
    }

    public function tokenLogin()
    {
        $credentials = request(['email']);
        $credentials['password'] = 'password';

        if (!$token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Email atau password salah'], 401);
        }
        return $this->respondWithToken($token);
    }

    public function logout()
    {
        config(['auth.defaults.guard' => 'api']);
        auth()->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }


    protected function respondWithToken($token)
    {

        $user = auth()->user();
        $user->setAppends([]); // kl gak gini, banyak atribut yg asumsi web-based (request(), session(), dll)

        return response()->json([
            'accessToken' => $token,
            // 'tokenType' => 'bearer',
            'expiresIn' => auth()->factory()->getTTL() * 600,
            'user' => auth()->user(),
        ]);
    }


    public function user(Request $request)
    {
        return Auth::user();
        return response()->json(auth());

        return auth();
        dd(auth());
        return auth()->user();
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

    public function update(Request $request, $userId)
    {
        $user = User::where('Id', $userId)->firstOrFail();
        $user->phone = $request->phone;
        $user->gender = $request->gender;
        $user->birth = ($request->birth) ? Carbon::parse($request->birth)->addDay(1)->format('Y-m-d') : null;
        $user->save();
    }
}
