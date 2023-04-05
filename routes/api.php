<?php

use App\Http\Controllers\ChartController;
use App\Http\Controllers\CheckoutController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\UserController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Response;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('/v1/')->group(function () {
    Route::post('/auth/login', [UserController::class, 'craeteOrUpdate']);
    Route::get('/auth/user', [UserController::class, 'user']);

    Route::resource('product', ProductController::class)->except('create');
    Route::resource('chart', ChartController::class)->except('create', 'show');
    Route::get('chart-count', [ChartController::class, 'count']);

    Route::post('checkout', [CheckoutController::class, 'store']);
    Route::get('checkout/{checkout_id}', [CheckoutController::class, 'show']);

    Route::get('/storage/{fileName}', function ($fileName) {
        if (!Storage::disk('public')->exists($fileName)) {
            abort(404, 'Tidak ditemukan');
        }
        $file = Storage::disk('public')->get($fileName);
        $type = Storage::disk('public')->mimeType($fileName);

        $response = Response::make($file, 200);
        $response->header("Content-Type", $type);

        return $response;
    });
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
