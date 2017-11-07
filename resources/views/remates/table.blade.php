<div class="form-group">
    <table class="table table-bordered table-hover">
        <thead>
            <th>#</th><th>Descripcion</th><th>Cantidad</th><th>Valuacion</th><th>Remate</th>
        </thead>
        <tbody>
            @foreach($articulos as $articulo)
                <tr>
                    <td>{{$articulo->id}}</td>
                    <td>{{$articulo->descripcion}}</td>
                    <td>{{$articulo->cantidad}}</td>
                    <td>${{$articulo->valuaciones()->first()->pivot->monto}}</td>
                    <td>{{Form::checkbox("remates[]", $articulo->id)}}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>