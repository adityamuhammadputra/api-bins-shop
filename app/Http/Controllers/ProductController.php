<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

use App\Models\Product;
use App\Models\ProductSeen;
use App\Resources\Product as ResourcesProduct;
use Carbon\Carbon;

class ProductController extends BaseController
{
    public function index(Request $request)
    {
        $products = Product::with('productRatings', 'productDiscussios')
                        ->filtered()
                        ->sort()
                        ->paginate(50);

        userCreateLog("Visit Product List");

        return ResourcesProduct::collection($products);
    }

    public function show(Request $request, $slug)
    {
        $product = Product::with('productRatings', 'productDiscussios')
                        ->where('slug', $slug)
                        ->firstOrFail();

        $userId = null;
        if (user()) {
            $userId = userId();
        }

        $productSeen = ProductSeen::where('product_id', $product->id)
                                ->where('user_id', $userId)
                                ->where('ip_address', $_SERVER['REMOTE_ADDR'])
                                ->whereDate('created_at', Carbon::today())
                                ->first();

        if (!$productSeen) {
            ProductSeen::create([
                'id' => uuId(),
                'product_id' => $product->id,
                'user_id' => $userId,
                'ip_address' => $_SERVER['REMOTE_ADDR'],
            ]);
        }

        userCreateLog("Visit Product $product->slug");

        return new ResourcesProduct($product);
    }

}
