<?php

use Illuminate\Database\Seeder;

class bajas_articulos extends Seeder
{
   public function run() {
        $bajas = [
            "Retiro de Bienes por Pago del Crédito Fiscal Anterior al Remate",
            "Prescripción del Crédito Fiscal",
            "Adjudicación del Bien en Favor del Postor",
            "Adjudicación del Bien en Favor de la Autorid Fiscal",
            "Abandono de Bienes en Favor del Fisco",
            "Resolución Amdinistrativa o Judicial:",
            "Credito",  
        ];
        foreach($bajas as $baja) {
            DB::table("motivos_bajas_bienes")->insert([
                "descripcion" => $baja
            ]);
        }
    }
}
