<?php

use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\DiscussionController as AdminDiscussionController;
use App\Http\Controllers\Admin\ProductController as AdminProductController;
use App\Http\Controllers\Admin\TransactionController as AdminTransactionController;
use App\Http\Controllers\ChartController;
use App\Http\Controllers\CheckoutController;
use App\Http\Controllers\DiscussionController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\TransactionController;
use App\Http\Controllers\TutorialController;
use App\Http\Controllers\UserController;
use App\Mail\WelcomeEmail;
use App\Models\AssetStatus;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
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
    Route::get('phpinfo', function(){
        $uuIds = '';
        foreach (range(1,20) as $value) {
            $uuIds .= uuId() . '<br>';
        }
        return $uuIds;
        return uuId();
        return phpinfo();
    });

    Route::prefix('auth')->group(function () {
        Route::post('login', [UserController::class, 'login']);
        Route::post('refresh', [UserController::class, 'refresh']);

        Route::group(['middleware' => 'jwt.verify'], function ($router) {
            Route::get('user', [UserController::class, 'user']);
            Route::patch('user/{user}', [UserController::class, 'update']);
            Route::post('logout', [UserController::class, 'logout']);
        });
    });


    Route::get('chart-count', [ChartController::class, 'count']);
    Route::get('notif-count', [ChartController::class, 'countNotif']);

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

    Route::prefix('/admin/')->group(function () {
        Route::prefix('auth')->group(function () {
            Route::post('/login', [UserController::class, 'login']);
        });

        Route::group(['middleware' => ['jwt.verify']], function ($router) {
            // Route::resource('transaction', AdminTransactionController::class)->except('create', 'edit');
            Route::post('dashboard', [DashboardController::class, 'index']);

            Route::post('transaction', [AdminTransactionController::class, 'index']);
            Route::patch('transaction/{transaction}', [AdminTransactionController::class, 'update']);
            Route::get('status', [AdminTransactionController::class, 'status']);

            // Route::post('product', [AdminProductController::class, 'store']);
            // Route::patch('product/{slug}', [AdminProductController::class, 'update']);
            // Route::get('product/{slug}', [AdminProductController::class, 'show']);
            Route::resource('product', AdminProductController::class)->only('store', 'update', 'show', 'destroy');
            Route::post('product-data', [AdminProductController::class, 'index']);
            Route::patch('product-row/{product}', [AdminProductController::class, 'updateRow']);

            Route::resource('discuss', AdminDiscussionController::class)->only('store', 'show', 'update');
            Route::post('discuss-data', [AdminDiscussionController::class, 'index']);

            Route::post('user-data', [UserController::class, 'index']);

        });

    });

});

Route::get('/test-mail', function(){
    Mail::to('adityamuhammadputra@gmail.com')->send(new WelcomeEmail('adityamuhammadputra'));
    return response()->json('emial has send adityamuhammadputra@gmail.com', 200);
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
