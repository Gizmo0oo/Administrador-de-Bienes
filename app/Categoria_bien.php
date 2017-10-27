<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Categoria_bien extends Model
{
    protected $primaryKey = "id";
    protected $table = "categorias";
    public function subcategorias() {
        return $this->belongsToMany("categorias_bienes","categorias_id", "subcategoria_id");
    }
}
