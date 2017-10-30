<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use App\Bien;
class BienesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $categorias = DB::select("select id, descripcion from categorias order by descripcion asc");
        $subcategorias = DB::select("select id, descripcion from subcategorias order by descripcion asc");
        $estados = DB::select("select id, nombre from estados order by nombre asc");
        $municipios = DB::select("select id, nombre from municipios order by nombre asc");
        return view("bienes.index", ["categorias" => $categorias, "subcategorias" => $subcategorias, "estados" => $estados, "municipios" => $municipios]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function bienes(){ 
        return response()->json(json_encode(Bien::all()), 200);
    }
}
