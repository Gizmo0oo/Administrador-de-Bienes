'use strict';
var botones_credito = [
    {
        "text": "<i id='add_credito' class='fa fa-plus' aria-hidden='true'></i>",
        "className": "btn btn-info",
        "titleAttr": "Mostrar Formulario",
        "action": function () {
            window.location = "/creditos/create";
        }
    },
    {
        "text": "<i class='fa fa-file-excel-o'></i>",
        "extend": "excelHtml5",
        "className": "btn btn-info",
        "titleAttr": "Excel",
        "filename": "reporte",
        "exportOptions": {
            "columns":[0, 1, 2, 3]
        }
    },
    {
        "text": "<i class='fa fa-file-pdf-o'></i>",
        "extend": "pdfHtml5",
        "className": "btn btn-info",
        "titleAttr": "PDF",
        "exportOptions": {
            "columns":[0,1,2,3]
        }
    }
],
botones_bienes = [
    {
        "text": "<i id='add_articulo' class='fa fa-plus' aria-hidden='true'></i>",
        "className": "btn btn-info btn-sm",
        "titleAttr": "Agregar Bién"
    },
    {
        "text": "<i class='fa fa-file-excel-o'></i>",
        "extend": "excelHtml5",
        "className": "btn btn-info btn-sm",
        "titleAttr": "Excel",
        "filename": "reporte",
        "exportOptions": {
            "columns":[0, 1, 2, 3]
        }
    },
    {
        "text": "<i class='fa fa-file-pdf-o'></i>",
        "extend": "pdfHtml5",
        "className": "btn btn-info btn-sm",
        "titleAttr": "PDF",
        "exportOptions": {
            "columns":[0,1,2,3]
        }
    }
],
columnas_creditos = [
    {
        "title": "Crédito Fiscal",
        "data": "folio"
    },
    {
        "title": "Documento determinante",
        "data": "documento_determinante"
    },
    {
        "title": "Origen del crédito fiscal",
        "data": "origen_credito"
    },
    {
        "title": "Adeudo",
        "data": "monto",
        "render": $.fn.dataTable.render.number( ',', '.', 0, '$' )
    },
    {
        "title": "Contribuyente",
        "data": "contribuyente",
        "render": function(data) {
            return "<a href='contribuyentes/" + data.id + "'><button type='button' class='btn btn-link'>" + data.Nombre + " " + data.Apellido_Paterno + " " + data.Apellido_Materno + "</button></a>";
        }
    },
    {
        "title": "Bienes",
        "defaultContent": "<button type='button' class='btn btn-default btn-sm'><i class='glyphicon glyphicon-eye-open'></i></button>",
        "data": null,
        "className": "view-bienes"
    },
    {
        "title": "Editar",
        "defaultContent": "<button type='button' class='btn btn-success btn-sm'><i class='glyphicon glyphicon-edit'></i></button>",
        "data": null,
        "className": "details-control"
    },
    {
        "title": "Baja",
        "className": "delete-control",
        "defaultContent": "<button type='button' class='btn btn-danger btn-sm'><i class='fa fa-trash-o' aria-hidden='true'></i></button>"
    }
],
columnas_bienes = [
    {
        "title": "Numero de Control",
        "data": "numero_control"
    },
    {
        "title": "Depositario",
        "data": "depositario",
        "render": function(data) {
            return data.nombre + " " + data.apellido_paterno + " " + data.apellido_materno;
        }
    },
    {
        "title": "Deposito",
        "data": "deposito",
        "render": function(data){
            return data.calle + " " + "#" + data.int + " " + "ext" + " " + data.ext + " " + data.colonia + " " + " " + "C.P" + " " +  data.cp + " " + data.estado.nombre;
        }
    },
    {
        "title": "Articulos",
        "data": null,
        "className": "view-bienes",
        "defaultContent": "<button type='button' class='btn btn-default btn-sm'><i class='glyphicon glyphicon-eye-open'></i></button>"
    },
    {
        "title": "Cantidad de Articulos",
        "data": "cantidad"
    },
    {
        "title": "Créditos Fiscales",
        "data": "creditos",
        "render": "[, ].folio"
    },
    {
        "title": "Editar",
        "data": null,
        "defaultContent": "<button type='button' class='btn btn-success btn-sm'><i class='glyphicon glyphicon-edit'></i></button>"
    },
    {
        "title": "Baja",
        "data": null,
        "defaultContent": "<button type='button' class='btn btn-danger btn-sm'><i class='fa fa-trash-o' aria-hidden='true'></i></button>"
    }
],
columnas_articulos = [
    {
        "title": "Numero de Control",
        "data": "bienes_numero_control"
    },
    {
        "title": "#",
        "data": "id"
    },
    {
        "title": "Descripion",
        "data": "descripcion"
    },
    {
        "title": "Cantidad",
        "data":  "cantidad"
    },
    {
        "title": "Categorias",
        "data": "categorias",
        "render": "[, ].descripcion"
    },
    {
        "title": "Depositario",
        "data": "depositario",
        "render": function(data) {
            return data.nombre + " " + data.apellido_paterno + " " + data.apellido_materno;
        }
    },
    {
        "title": "Deposito",
        "data": "deposito",
        "render": function(data){
            return data.calle + " " + data.int + " " + data.ext + " " + data.colonia + " " + data.estado.nombre;
        }
    },
    {
        "title": "Valuacion",
        "data": "ultima_valuacion.pivot.monto",
        "render": function(data = "0", type, row){
            if(data == "0")
                return "<a href='avaluos/" + row.id  + "'><botton type='button' class='btn btn-warning btn-sm'>" + "$" + data + "</button></a>";
            else
                return "<a href='avaluos'> <botton type='button' class='btn btn-info btn-sm'>" + "$" + data + "</button></a>";
        }
    },
    {
        "data":"id",
        "title": "Editar",
        "className": "details-articulo",
        "render": function(data) {
            return "<a href='bienes/" + data + "/edit'><button type='button' class='btn btn-success btn-sm'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></a>";
        }
    },
    {
        "data":null,
        "title": "Baja",
        "className": "delete-bien",
        "defaultContent": "<button type='button' class='btn btn-danger btn-sm'><i class='fa fa-trash-o' aria-hidden='true'></i></button>"
    },
],
columnas_contribuyentes= [
    {
        "title": "Nombre",
        "render": function(data, type, row){
            return "<a href='contribuyentes/" + row.id + "'><button type='button' class='btn btn-link'>" + row.Nombre + " " + row.Apellido_Paterno + " " + row.Apellido_Materno + "</button></a>";
        }
    },
    {
        "title": "Telefono",
        "data": "Telefono"
    },
    {
        "title": "Colonia",
        "data": "domicilios",
        "render": "[, ].colonia"
    },
    {
        "title": "Calle",
        "data": "domicilios",
        "render": "[, ].calle"
    },
    {
        "title": "CP",
        "data": "domicilios",
        "render": "[, ].cp"
    },
    {
        "title": "Estado",
        "data": "domicilios",
        "render": "[, ].estado.nombre"
    },
    {
        "title": "RFC",
        "data": "RFC"
    },
    {
        "title": "CURP",
        "data": "CURP"
    },
],
columnas_creditos_contribuyente = [
    {
        "title": "Crédito Fiscal",
        "data": "folio"
    },
    {
        "title": "Documento determinante",
        "data": "documento_determinante"
    },
    {
        "title": "Origen del crédito fiscal",
        "data": "origen_credito"
    },
    {
        "title": "Adeudo",
        "data": "monto",
        "render": $.fn.dataTable.render.number( ',', '.', 0, '$' )
    },
    {
        "title": "Bienes",
        "defaultContent": "<button type='button' class='btn btn-default btn-sm'><span class='glyphicon glyphicon-eye-open'></button>",
        "data": null,
        "className": "view-bienes"
    },
    {
        "title": "Editar",
        "defaultContent": "<button type='button' class='btn btn-success btn-sm'><span class='glyphicon glyphicon-edit'></span></button>",
        "data": null,
        "className": "details-control"
    },
    {
        "title": "Baja",
        "className": "delete-control",
        "defaultContent": "<button type='button' class='btn btn-danger btn-sm'><i class='fa fa-trash-o' aria-hidden='true'></i></button>"
    }
];