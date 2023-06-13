<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

use App\Models\ProductDiscussion;
use App\Resources\ProductDiscussion as ResourcesProductDiscussion;

class DiscussionController extends BaseController
{
    public function index(Request $request)
    {
        $data = ProductDiscussion::filtered()
                    ->where('user_id', userId())
                    ->whereNull('parent')
                    ->orderBy('created_at', 'desc')
                    ->get();

        return ResourcesProductDiscussion::collection($data);
    }

    public function show($slug)
    {

    }

    public function store(Request $request)
    {
        try{
            $product = Product::find($request->product_id);

            $data = [
                'id' => uuId(),
                'parent' => $request->parent,
                'user_id' => userId(),
                'product_id' => $product->id,
                'desc' => isset($request->desc_key) ? $request->desc_parent[$request->desc_key] : $request->desc,
            ];
            ProductDiscussion::create($data);

            userCreateLog("Add Discussion Product $product->slug");

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
