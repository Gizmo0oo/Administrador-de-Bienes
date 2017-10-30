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

    public function imagenes() {
        return $this->hasMany("App\Imagenes");
    }

    public function peritos() {
        return $this->belongsToMany("App\Perito","valuaciones","bienes_numero_control","peritos_id");
    }

    public function bien(){
        return $this->belongsTo("App\Bien","bienes_numero_control");
    }
}
