<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CreditosRequest extends FormRequest
{
    public function authorize() {
        return true;
    }

    public function rules(){
        return [
            'credito.folio' => 'required|unique:creditos_fiscales,folio',
            'credito.monto' => 'required|numeric|min:1',
            'credito.documento' => 'required',
            'credito.origen' => 'required',
            'credito.contribuyente.rfc' => 'unique:contribuyentes,id',
            'credito.contribuyente.curp' => 'required',            
            'credito.contribuyente.curp' => 'unique:contribuyentes,id'
        ];
    }

    public function messages(){
        return [
            'credito.folio.required' => 'Por favor introduzca un número de crédito fiscal.',
            'credito.folio.unique' => 'El crédito fiscal ya existe',
            'credito.monto.required' => 'Por favor introduzca un monto.',
            'credito.monto.numeric' => "El monto debe ser un valor numerico",
            'credito.monto.min' => 'El monto debe ser mayor de 0.',
            'credito.origen.required' => 'Por favor introduzca el origen del crédito.',
            'credito.documento.required' => 'Por favor introduzca el documento determinante.',
            "credito.contribuyente.nombre.required" => "Por favor introduzca del nombre del contribuyente",
            'credito.contribuyente.apellido_paterno.required' => 'Por favor introduzca el apellido paterno del contribuyente',
            'credito.contribuyente.apellido_materno.required' => 'Por favor introduzca el apellido materno del contribuyente',
            'credito.contribuyente.curp.unique' => 'El CURP ya existe'
        ];
    }

}