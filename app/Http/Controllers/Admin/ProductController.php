<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

use App\Models\Product;
use App\Resources\Product as ResourcesProduct;
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
        $product = Product::with('productRatings', 'productDiscussios')
                        ->where('slug', $slug)
                        ->firstOrFail();
        return new ResourcesProduct($product);
    }

    public function updateRow(Request $request, Product $product)
    {
        try {
            $product->stock = $request->stock;
            $product->status = $request->status;

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


    public function inputData($request, $update = false)
    {
        $arrImg = ['img1', 'img2', 'img3', 'img4', 'img5'];
        $input = $request->except($arrImg);
        $input['price'] = str_replace('.', '', $request->price);
        $input['slug'] = Str::slug($request->name);
        foreach ($arrImg as $img) {
            $input[$img] = $this->inputFile($request, $img);
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

}
