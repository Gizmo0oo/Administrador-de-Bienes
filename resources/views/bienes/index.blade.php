@extends("layout.master")
@section("title","Bienes")
@section("content")
    @include("articulos.tabla-articulos")
@endsection
@section("scripts")
    {{Html::script("js/variables.js")}}    
    {{Html::script("js/funciones.js")}}
    {{Html::script("js/bienes.js")}}
@endsection