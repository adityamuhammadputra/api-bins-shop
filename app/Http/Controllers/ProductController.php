<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

use App\Models\Product;
use App\Resources\Product as ResourcesProduct;


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
        $product->seen = $product->seen + 1;
        $product->save();
        return new ResourcesProduct($product);
    }

}
