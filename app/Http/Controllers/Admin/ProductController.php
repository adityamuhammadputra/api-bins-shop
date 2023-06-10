<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

use App\Models\Product;
use App\Resources\ProductMin as ResourcesProduct;
use App\Resources\ProductMin;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

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
        $product = Product::where('slug', $slug)
                        ->firstOrFail();
        return new ProductMin($product);
    }


    public function store(Request $request)
    {
        try {
            $input = $this->inputData($request, false);
            Product::create($input);
            $response = [
                'status' => 200,
                'message' => $request->name . ' berhasil ditambah'
            ];
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function update(Request $request, $slug)
    {
        // return collect($request)->except('_method');
        try {
            $input = $this->inputData($request, true);
            Product::where('slug', $slug)
                    ->update($input);

            $response = [
                'status' => 200,
                'message' => $request->name . ' berhasil diperbaharui'
            ];
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }

        return response()->json($response, $response['status']);
    }

    public function destroy(Product $product)
    {
        return $product->trashed();
    }

    public function inputData($request, $update = false)
    {
        $arrExcept = ['_method', 'price_rp', 'file', 'files', 'price_discount', 'discount', 'price_final_rp', 'created_at', 'updated_at'];
        $input = $request->except($arrExcept);
        $input['price'] = str_replace('.', '', $request->price);
        $input['slug'] = Str::slug($request->name);
        $arrImg = ['img1', 'img2', 'img3', 'img4', 'img5'];
        foreach ($arrImg as $img) {
            if ($request->{$img}) {
                $input[$img] = $this->inputFile($request, $img);
            }
        }

        if ($update == false) {
            $input['id'] = uuid();
        }

        return $input;
    }

    function inputFile($request, $name)
    {
        if ($request->hasFile($name)) {
            $file = $request->file($name);
            // $originalName = $file->getClientOriginalName();
            $fileName = uuid() . '_' . $file->getClientOriginalName();
            Storage::disk('public')->put($fileName, File::get($file));
            return $fileName;
        }

        return null;
    }

    public function updateRow(Request $request, Product $product)
    {
        try {
            $product->stock = $request->stock;
            $product->status = $request->status;
            $product->discount = str_replace('%', '', $request->discount);

            $product->save();
            $response = [
                'status' => 200,
                'message' => $product->Name . ' Produk diupdate'
            ];
        }
        catch (\Exception $e) {
            $response = [
                'status' => 503,
                'message' => $e->getMessage()
            ];
        }
        return response()->json($response, $response['status']);

    }

}
