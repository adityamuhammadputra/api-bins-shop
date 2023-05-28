<?php

use App\Http\Controllers\ChartController;
use App\Http\Controllers\CheckoutController;
use App\Http\Controllers\DiscussionController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\TransactionController;
use App\Http\Controllers\TutorialController;
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
    Route::prefix('auth')->group(function () {
        Route::post('login', [UserController::class, 'login']);

        Route::group(['middleware' => 'jwt.verify'], function ($router) {
            Route::get('user', [UserController::class, 'user']);
            Route::patch('user/{user}', [UserController::class, 'update']);
            Route::post('logout', [UserController::class, 'logout']);
        });
    });


    Route::get('chart-count', [ChartController::class, 'count']);
    Route::resource('product', ProductController::class)->except('create');
    // Route::post('product-discus', [ProductController::class, 'discus']);
    Route::resource('chart', ChartController::class)->except('create', 'show');

    Route::group(['middleware' => 'jwt.verify'], function ($router) {
        Route::resource('checkout', CheckoutController::class)->only('store', 'show');
        Route::resource('order', TransactionController::class)->except('create', 'edit');
        Route::post('order-rating', [TransactionController::class, 'ratingStore']);
        // Route::get('order-rating', [ProductController::class, 'ratingGet']);
        Route::resource('discuss', DiscussionController::class);
        // Route::get('checkout/{checkout_id}', [CheckoutController::class, 'show']);
        // Route::get('checkout/{checkout_id}', [CheckoutController::class, 'show']);
    });

    Route::get('tutorial', [TutorialController::class, 'index']);

    Route::post('order-callback', [TransactionController::class, 'callback']);


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
