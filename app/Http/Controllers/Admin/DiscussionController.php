<?php

namespace App\Http\Controllers\Admin;


use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

use App\Models\ProductDiscussion;
use App\Resources\ProductDiscussion as ResourcesProductDiscussion;

class DiscussionController extends BaseController
{
    public function index(Request $request, $returnCount = false)
    {
        $data = ProductDiscussion::filtered()
                    ->whereNull('parent')
                    ->orderBy('created_at', 'desc')
                    ->get();

        if ($request->replay == 2) {
            foreach ($data as $key => $value) {
                // dd($value->children->last()->user_id);
                if (isset($value->children->last()->user_id) && $value->children->last()->user_id == userId()) {
                    $data->forget($key);
                }
                // foreach($value->children as $child) {
                //     if (isset($child->user_id) && $child->user_id == userId()) {
                //         // unset($data[$key]);
                //         $data->forget($key);
                //     }
                // }
            }
        }

        if ($returnCount) {
            return count($data);
        }

        return ResourcesProductDiscussion::collection(collect($data));
    }

    public function show($slug)
    {

    }

    public function store(Request $request)
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
