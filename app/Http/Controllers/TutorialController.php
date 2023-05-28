<?php

namespace App\Http\Controllers;

use App\Models\AssetTutorial;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;


class TutorialController extends BaseController
{
    public function index(Request $request)
    {
        $data = AssetTutorial::orderBy('sort', 'asc')
                    ->get();

        return $data;
    }
}
