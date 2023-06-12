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

        return ResourcesProduct::collection($products);
    }

    public function show($slug)
    {
        $product = Product::with('productRatings', 'productDiscussios')
                        ->where('slug', $slug)
                        ->firstOrFail();

        if (user()) {
            $productSeen = ProductSeen::where('product_id', $product->id)
                                ->where('user_id', userId())
                                ->whereDate('created_at', Carbon::today())
                                ->first();

            if (!$productSeen) {
                ProductSeen::create([
                    'id' => uuId(),
                    'product_id' => $product->id,
                    'user_id' => userId(),
                ]);
            }
        }

        return new ResourcesProduct($product);
    }

}
