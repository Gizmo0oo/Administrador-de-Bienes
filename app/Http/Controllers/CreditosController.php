<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositorios\Usuario;
use App\Http\Requests\CreditosRequest;
use App\Credito;
use App\Contribuyente;
use App\Domicilio;
use App\Bien;
use App\Articulo;
use App\Depositario;
use App\Estado;
use DB;

class CreditosController extends Controller {

    private $users;
    public function __construct(Usuario $users) {
        $this->middleware('auth');
        $this->users = $users;
    }

    public function index() {
        
    $bajas_creditos =  DB::table("motivos_bajas_creditos_fiscales")->select("id", "descripcion")->orderBy("descripcion", "asc")->get();
        
    $bajas_articulos = DB::table("motivos_bajas_bienes")->select("id", "descripcion")->orderBy("descripcion", "asc")->get();

    return view("index", ["bajas_creditos" => $bajas_creditos, "bajas_articulos" => $bajas_articulos]);
    
    }

    public function create() {
        
        $origenes_del_credito = [
            "1"=> "Anexo 18", 
            "2" => "ISTUV", 
            "3" => "Control de Obligaciones", 
            "4" => "Multas Federales No Fiscales", 
            "5" => "Liquidaciones DAFE" 
        ];

        $categorias = DB::table("categorias")->select("id", "nombre")->orderBy("nombre", "asc")->get();
        
        $subcategorias = DB::table("subcategorias")->select("id", "nombre")->orderBy("nombre", "asc")->get();
        
        $estados = DB::table("estados")->select("id", "nombre")->orderBy("nombre", "asc")->get();

        $municipios = DB::table("municipios")->select("id", "nombre")->orderBy("nombre", "asc")->get();
        
        return view("creditos.create", [
            "origenes" => $origenes_del_credito,  "categorias" => $categorias, "subcategorias" => $subcategorias, "estados" => $estados,
            "municipios" => $municipios
        ]);
    }

    public function store(CreditosRequest $request) {
        
        if($request->input("credito.contribuyente.curp")){
            $id_contribuyente = $request->input("credito.contribuyente.curp");
        } else {
            $id_contribuyente = $request->input("credito.contribuyente.rfc");
        }

        $contribuyente = new contribuyente([
                "id" => $id_contribuyente,
                "nombre" => $request->input("credito.contribuyente.nombre"),
                "apellido_paterno" => $request->input("credito.contribuyente.apellido_paterno"),
                "apellido_materno" => $request->input("credito.contribuyente.apellido_materno"),
                "telefono" => $request->input("credito.contribuyente.telefono"),
                "rfc" => $request->input("credito.contribuyente.rfc"),
                "razon_social" => $request->input("credito.contribuyente.razon_social")
            ]);

        $contribuyente->save();
        
        $domicilio_contribuyente = new Domicilio([
            "cp" => $request->input("credito.contribuyente.domicilio.cp"),
            "int" => $request->input("credito.contribuyente.domicilio.int"),
            "ext" => $request->input("credito.contribuyente.domicilio.ext"),
            "calle" => $request->input("credito.contribuyente.domicilio.calle"),
            "colonia" => $request->input("credito.contribuyente.domicilio.colonia"),
            "municipios_id" => $request->input("credito.contribuyente.domicilio.municipio"),
            "estados_id" => $request->input("credito.contribuyente.domicilio.estado")
        ]);

        $domicilio_contribuyente->save();

        $contribuyente->domicilios()->attach($domicilio_contribuyente->id);
        
        $credito = new Credito([
            "folio" => $request->input("credito.folio"),
            "monto" => $request->input("credito.monto"),
            "documento_determinante" => $request->input("credito.documento"),
            "origen_credito" => $request->input("credito.origen"),
        ]);

        $contribuyente->creditos()->save($credito);


        $depositario = new Depositario([
            "nombre" => $request->input("credito.bien.depositario.nombre"),
            "apellido_paterno" => $request->input("credito.bien.depositario.apellido_paterno"),
            "apellido_materno" => $request->input("credito.bien.depositario.apellido_materno")
        ]);
        $depositario->save();
        
        $deposito = new Domicilio([
            "cp" => $request->input("credito.bien.deposito.cp"),
            "int" => $request->input("credito.bien.deposito.int"),
            "ext" => $request->input("credito.bien.deposito.ext"),
            "calle" => $request->input("credito.bien.deposito.calle"),
            "colonia" => $request->input("credito.bien.deposito.colonia"),
            "municipios_id" => $request->input("credito.bien.deposito.municipio"),
            "estados_id" => $request->input("credito.bien.deposito.estado")
        ]);
        $deposito->save();

        foreach($request->input('credito.bien.articulos') as $b) {
            $bien = new Bien([
                "numero_control" => $b["numero_control"],
                "descripcion" => $b["descripcion"],
                "cantidad" => $b["cantidad"],
                "depositarios_id" => $depositario->id,
                "deposito_id" => $deposito->id
            ]);
            $bien->save();
            foreach($b["categorias"] as $categoria) {
                if(array_has($categoria, "subcategorias")) {
                    foreach($categoria["subcategorias"] as $subcategoria) {
                        if(array_has($subcategoria, "subsubcategorias")) {
                            foreach($subcategoria["subsubcategorias"] as $subsubcategoria) {
                                $bien->categorias()->attach($categoria["id"], ["subcategoria_id" => $subcategoria["id"], "subsubcategoria_id" => $subsubcategoria["id"]]);
                            }
                        } else {
                            $bien->categorias()->attach($categoria["id"], ["subcategoria_id" => $subcategoria["id"]]);
                        }
                    }
                } else {
                    $bien->categorias()->attach($categoria["id"]);
                }
            }
            $credito->bienes()->attach($bien->numero_control, ['documento' => $request->input("credito.bien.documento_embargo")]);
        }
        return response()->json("Credito Fiscal"." ".$credito->folio." "."Creado con Exito",200);
    }

    public function show($id)
    {
        //
    }

    public function edit($id)
    {
        //
    }

    public function update(Request $request) {
        $folio = $request->input("credito.folio");
        $credito = Credito::where("folio", $folio)->firstOrFail();
        $credito->contribuyentes_id = $credito->contribuyente->id;
        $credito->monto = $request->input("credito.monto");
        $credito->documento_determinante = $request->input("credito.documento");
        $credito->origen_credito = $request->input("credito.origen");
        $credito->save();
        return response()->json("Credito Fiscal"." ".$credito->folio." "."actualizado cone exito!", 200);
    }

    public function destroy(Request $request) {
        $folio = $request->input("folio");
        $credito = Credito::where("folio", $folio)->firstOrFail();
        $credito->estatus = 0;
        $credito->save();
        $contribuyente = $credito->contribuyente;
        $contribuyente->estado = 0;
        $contribuyente->save();
        DB::insert("insert into bajas_creditos_fiscales (creditos_fiscales_folio, baja, usuarios_id, comentarios) values(?,?,?,?)", 
            [
                $credito->folio, $request->input("baja"), 1, $request->input("comentarios")
            ]
        );
        foreach($credito->bienes as $bien) {
                $bien->estado = 0;
                $bien->save();
        }
        return response()->json("Credito Fiscal"." ".$credito->folio." "."se dio de Baja", 200);
    }

    public function creditos(){

        $consulta = Credito::activos();
        $creditos = Collect();
        foreach($consulta as $credito) {
            $credito->contribuyente;
            $creditos->push($credito);
        }
        return response()->json($creditos, 200);
    }

    public function bienes(Request $request) {
        $bienes = Collect();
        $credito = Credito::where("folio", $request->input("folio"))->firstOrFail();
        foreach($credito->bienes as $bien) {
            $subcategorias = Collect();
            $bien->depositario;
            $bien->deposito->estado->nombre; 
            $bien->valuaciones->first();
            foreach($bien->categorias as $categoria){
                $bien->subcategorias = $this->users->subcategorias($categoria->id);
                foreach($bien->subcategorias as $subcategoria) {
                    $bien->subsubcategorias = $this->users->subsubcategorias($subcategoria->id);
                }    
            }   
            $bienes->push($bien);
        }
        return response()->json($bienes, 200);
    }

    public function add(Credito $credito, request $request) {
        
        if($request->isMethod("post")) {
            $articulo = $credito->bienes->first()->articulos()->create([
                "descripcion" => $request->input("descripcion"),
                "cantidad" => $request->input("cantidad")
            ]);
            $articulo->categorias()->attach([$request->input("categoria")]);
            $articulo->subcategorias()->attach([$request->input("subcategoria")]);
            return redirect("/bienes")->with("status", "Se agrego el bien correctamente");
        }

        $categorias = DB::select("select id, nombre from categorias");
        $subcategorias = DB::select("select id, nombre from subcategorias");
        return view("articulos.add", ["categorias" => $categorias, "subcategorias" => $subcategorias, "credito" => $credito]);
    }

    public function imagenes(Bien $bien, request $request){
        if($request->isMethod("post")) {
            $imagen = $request->file("file");
            $nombre = $imagen->getClientOriginalName();
            $extencion = $imagen->guessExtension();
            $dir = public_path().'/img';
            $bien->imagenes()->create(["nombre" => $nombre]);
            $subir = $imagen->move($dir, $nombre);
        } else {
            foreach($bien->categorias as $categoria) {
                $categoria->subcategorias = $this->users->subcategorias($categoria->id);
                foreach ($categoria->subcategorias as $subcategoria) {
                    $subcategoria->subsubcategorias = $this->users->subsubcategorias($subcategoria->id);
                }
            }
        }
            return view("imagenes.index", ["bien" => $bien, "categorias" => []]);
    }

    public function municipios(request $request){
        $id = $request->input("id");
        $municipios = Estado::where("id",$id)->firstOrFail()->municipios;
        if($municipios->isEmpty()){
            return response()->json(["obj" => ["id" => '0', "nombre" => ""]], 200);
        }
        return response()->json($municipios, 200);
    }
}
