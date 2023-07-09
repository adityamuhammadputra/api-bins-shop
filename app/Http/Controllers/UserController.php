<?php

namespace App\Http\Controllers;

use App\Mail\WelcomeEmail;
use App\Models\AssetStatus;
use App\Models\Transaction;
use App\Models\User;
use App\Models\UserLog;
use App\Resources\User as ResourcesUser;
use App\Resources\UserTransaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;

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

        if ($request->admin) {
            if ($user->admin == 1) {
                return $this->tokenLoginAdmin();
            } else {
                return response()->json(['error' => 'Halaman ini hanya untuk admin'], 401);
            }
        }

        if ($user) {
            $user->avatar = $request->picture;
            $user->save();
            return $this->tokenLogin();
        } else {
            $user = User::create([
                'provider' => $request->provider,
                'provider_id' => $request->provider_id,
                'email' => $request->email ?? null,
                'name' => $request->name,
                'avatar' => $request->picture,
                'password' => Hash::make('password'),
            ]);

            if ($request->email && $request->name)
                Mail::to($request->email)->send(new WelcomeEmail($request->name));

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

    public function tokenLoginAdmin()
    {
        $credentials = request(['email', 'password']);
            if (!$token = auth()->attempt($credentials)) {
                return response()->json(['error' => 'Email atau password salah'], 401);
            }
            return $this->respondWithToken($token);
    }

    public function logout()
    {
        config(['auth.defaults.guard' => 'api']);
        auth()->logout();

        userCreateLog('Has Logout');
        return response()->json(['message' => 'Successfully logged out']);
    }


    protected function respondWithToken($token)
    {

        $user = auth()->user();
        $user->setAppends([]); // kl gak gini, banyak atribut yg asumsi web-based (request(), session(), dll)


        userCreateLog('Has Login');

        return response()->json([
            'accessToken' => $token,
            // 'tokenType' => 'bearer',
            'expiresIn' => auth()->factory()->getTTL() * 600,
            'user' => $user,
        ]);
    }

    public function user(Request $request)
    {
        $user = Auth::user();
        $user->transaction_count = Transaction::where('user_id', userId())
                                        ->where('status_id', 4)
                                        ->count();

        userCreateLog('Visit Profile');
        return $user;
        return response()->json(auth());
        return auth();
        dd(auth());
        return auth()->user();
    }

    public function index(Request $request)
    {

        try {
            $data = User::with('transactionSuccess')
                        ->filtered()
                        ->paginate(50);

            $response = [
                'status' => 200,
                'data' => UserTransaction::collection($data),
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
        try {
            $user = User::where('Id', $userId)->firstOrFail();
            $user->phone = $request->phone;
            $user->gender = $request->gender;
            $user->birth = ($request->birth) ? Carbon::parse($request->birth)->addDay(1)->format('Y-m-d') : null;
            $user->save();

            $response = [
                'status' => 200,
                'message' => 'success',
                'data' => $user,
            ];
        } catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }
}
