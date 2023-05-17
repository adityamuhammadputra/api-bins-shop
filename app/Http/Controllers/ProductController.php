<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Resources\Product as ResourcesProduct;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Request;

class ProductController extends BaseController
{
    public function index(Request $request)
    {
        $products = Product::filtered()
                        ->sort()
                        ->paginate(50);
        return ResourcesProduct::collection($products);
    }

    public function show($slug)
    {
        $product = Product::where('slug', $slug)
                    ->firstOrFail();
        return new ResourcesProduct($product);
    }
}
