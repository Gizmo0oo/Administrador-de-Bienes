<div class="form-group">
    <div>
        <label class="control-label" for="estado_deposito">Estado:</label>
        <select id="estado_deposito">
            @foreach($estados as $estado)
                <option value="{{$estado->id}}">{{$estado->nombre}}</option>
            @endforeach
        </select>
    </div>
</div>

<div class="form-group">
    <div>
        <label class="control-label" for="municipio_deposito">Municipio:</label>
        <select id="municipio_deposito"></select>
    </div>
</div>

<div class="form-group">
    <div>
        <label class="control-label" for="colonia_deposito">Colonia:</label>
        <input class="form-control" id="colonia_deposito" placeholder="Ingrese la colonia" type="text">
    </div>
</div>

<div class="form-group">
  <div>
      <label class="control-label" for="codigo_postal_deposito">Codigo postal:</label>
      {{Form::text("codigo_postal", null, ["class"=>"form-control", "id"=>"codigo_postal_deposito", "placeholder"=>"Ingrese el codigo postal"])}}
  </div>
</div>


<div class="form-group">
    <div>
        <label class="control-label" for="ext_deposito">Numero Exterior:</label>
        {{Form::text("numero_exterior", null, ["class"=>"form-control", "id"=>"ext_deposito", "placeholder"=>"Ingrese el numero exterior"])}}
    </div>
</div>

<div class="form-group">
    <div>
        <label class="control-label" for="int_deposito">Numero Interio:</label>
        {{Form::text("numero_interior", null, ["class" => "form-control", "id" => "int_deposito", "placeholder" => "Ingrese el numero interio"])}}
    </div>
</div>

<div class="form-group">
    <div>
        <label class="control-label" for="calle_desposito">Calle:</label>
        {{Form::text("calle", null, ["class"=>"form-control", "id" => "calle_deposito", "placeholder" => "Ingrese la calle"])}}
    </div>
</div>