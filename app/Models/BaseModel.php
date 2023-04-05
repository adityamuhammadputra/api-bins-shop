<?php

namespace App\Models;


use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

abstract class BaseModel extends Model
{

    public function trashed()
    {
        try {
            $this->newQueryWithoutScopes()->where('id', $this->id)->update([
                'deleted_at' => Carbon::now(),
                'deleted_by' => userId(),
            ]);
            $response = [
                'status' => 200,
                'msg' => "data berhasil dihapus",
                'data' => $this,
            ];
        } catch (\Throwable $th) {
            $response = [
                'status' => 500,
                'msg' => $th->getMessage(),
                'data' => $this,
            ];
        }
        return response()->json($response, $response['code']);
    }

    public function scopeMyData($query)
    {
        $query->where('created_by', userId());
    }

    public function scopeActive($query)
    {
        $query->where('status', 1);
    }

    public function scopeInActive($query)
    {
        $query->where('status', '!=', 1);
    }

    public function scopeSoftDelete($query)
    {
        $query->whereNull('deleted_at');
    }
}
