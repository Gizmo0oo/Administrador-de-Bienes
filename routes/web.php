<?php
Route::get('/', 'CreditosController@index');
//Rutas de los creditos
Route::get("/creditos/bienes", "CreditosController@bienes");
Route::get("/creditos/creditos", "CreditosController@creditos");
Route::post("/creditos/create",  "CreditosController@store");
Route::post("/creditos/destroy", "CreditosController@destroy");
Route::post("/creditos/update",  "CreditosController@update");
Route::match(["get", "post"] , "/creditos/{credito?}/add",  "CreditosController@add");
Route::match(["get","post"], "/creditos/{articulo?}/imagenes","CreditosController@imagenes");
Route::resource("creditos", "CreditosController");
//Ruta de los bienes
Route::get("/bienes/bienes", "BienesController@bienes");
Route::get("/bienes/articulos", "BienesController@articulos");
Route::post("/bienes/destroy", "BienesController@destroy");
Route::resource("bienes", "BienesController");
//Rutas de los contribuyentes
Route::get("/contribuyentes/contribuyentes", "ContribuyenteController@contribuyentes");
Route::get("/contribuyentes/creditos", "ContribuyenteController@creditos");
Route::resource("contribuyentes", "ContribuyenteController");
//Otros
Route::resource("avaluos", "AvaluosController");
Route::resource("remates", "RematesController");
Route::resource("subastas", "SubastaController");
Route::get("/subastas/{articulo}", "SubastaController@show");
Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
Route::get('/categorias', function(){
    return view("categorias.index");
});
