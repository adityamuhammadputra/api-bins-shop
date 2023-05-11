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
        return ResourcesProduct::collection(Product::with('transactionDetails')->filtered()->paginate(25));
    }

    public function show($slug)
    {
        $product = Product::where('slug', $slug)
                    ->firstOrFail();
        return new ResourcesProduct($product);
    }
}
