<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Articulo extends Model {

    protected $primaryKey = "id";
    protected $fillable = ['id','descripcion', 'cantidad', 'bienes_numero_control'];
    public $timestamps = false;
    
    public function categorias() {
        return $this->belongsToMany("App\Categoria_bien","articulos_categorias","articulos_id","categorias_id");
    }

    public function subcategorias() {
        return $this->belongsToMany("App\Subcategoria_bien","articulos_subcategorias","articulos_id","subcategorias_id");
    }

    public function imagenes() {
        return $this->hasMany("App\Imagen","Productos_id","id");
    }

    public function valuaciones() {
        return $this->belongsToMany("App\Perito","valuaciones","articulos_id","peritos_id")
                    ->orderBy("fecha", "des")
                    ->withPivot("monto","fecha", "numero_dictamen");
    }
    
    public function bien(){
        return $this->belongsTo("App\Bien","bienes_numero_control");
    }

    public function remates() {
        return $this->belongsToMany("App\Remate","lotes","articulos_id","remate_id");
    
    }

    public static function activos(){
        return static::where("estado", 1)->get();
    }

}