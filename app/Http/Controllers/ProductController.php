<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

use App\Models\Product;
use App\Models\ProductDiscussion;
use App\Resources\Product as ResourcesProduct;


class ProductController extends BaseController
{
    public function index(Request $request)
    {
        $products = Product::with('productRatings')
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
        return new ResourcesProduct($product);
    }

    public function discus(Request $request)
    {
        try{
            $data = [
                'id' => uuId(),
                'parent' => $request->parent,
                'user_id' => userId(),
                'product_id' => $request->product_id,
                'desc' => $request->desc,
            ];
            ProductDiscussion::create($data);

            $response = [
                'status' => 200,
                'message' => 'Diskusi berhasil ditambah',
            ];
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }
        return response()->json($response, 200);
    }
}
