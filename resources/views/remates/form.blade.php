<div class="form-group">
    {{Form::label("remate", "Numero de remate:", ["class" => "control-label col-sm-2"])}}
    <div class="col-sm-10">
        {{Form::text("remate", null, ["class"=>"form-control", "id"=>"numero_remate"])}}
    </div>
</div>

<div class="form-group">
    {{Form::label("fecha_inicio", "Fecha Inicio:", ["class" => "control-label col-sm-2"])}}
    <div class="col-sm-10">
        {{Form::text("fecha_inicio", null, ["class"=>"form-control", "id"=>"fecha_inicio_remate"])}}
    </div>
</div>

<div class="form-group">
    {{Form::label("fecha_fin", "Fecha Fin:", ["class" => "control-label col-sm-2"])}}
    <div class="col-sm-10">
        {{Form::text("fecha_fin", null, ["class"=>"form-control", "id"=>"fecha_fin_remate"])}}
    </div>
</div>