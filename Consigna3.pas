program ContableEmpresarialInternacional;
uses Crt, Sysutils;

const
    maxLargoNombre = 30;
    maxLargoProvincia = 50;
    maxLargoLocalidad = 50;
    maxLargoDireccion = 50;

type
    tNumCliente=longint;
    tNombre = string[maxLargoNombre];
    tProvincia = string[maxLargoProvincia];
    tLocalidad = string[maxLargoLocalidad];
    tDireccion = string[maxLargoDireccion];
    tRCliente = record
                    Num_Cliente:tNumCliente;
                    Nombre:tNombre;
                    Provincia:tProvincia;
                    Localidad:tLocalidad;
				    Direccion:tDireccion;
                end;
    tArClientes = file of tRCliente;
    tArTotClientes = Text;

{Consigna 3: Lectura Adelantada}
procedure LeerClientes(var arClientes:tArClientes; var rCliente:tRCliente; var finClientes:boolean);
begin
    finClientes := EOF(arClientes);
    if (not finClientes) then
        read(arClientes, rCliente);
end;

{Consigna 3: Indentacion (un extra)}
function PadRight(valor:string; anchoTotal:integer; relleno:char):string;
begin
	PadRight := valor + StringOfChar(relleno, anchoTotal - Length(valor));
end;

{Consigna 3: Corte de Control}
procedure TotalizarClientes(var arClientes:tArClientes; var arTotClientes:tArTotClientes);
var
    auxProvincia:tProvincia;
    auxLocalidad:tLocalidad;
    finClientes:boolean;
    rCliente:tRCliente;
    totCantLoc,totCantProv,totCantGral:longint;
begin
    reset(arClientes);
    rewrite(arTotClientes);
    totCantGral := 0;
    LeerClientes(arClientes, rCliente, finClientes);
    writeln(arTotClientes, 'Reporte General de Clientes');
    while (not finClientes) do
    begin
        auxProvincia := rCliente.Provincia;
        totCantProv:=0;
        writeln(arTotClientes, '');
        writeln(arTotClientes, 'Provincia: ', auxProvincia);
        writeln(arTotClientes, PadRight('Localidad', maxLargoProvincia, ' '), 'Cantidad');
        while (auxProvincia = rCliente.Provincia) and (not finClientes) do {al final agrego las condiciones anteriores}
        begin
            auxLocalidad := rCliente.Localidad;
            totCantLoc := 0;
            while (auxLocalidad = rCliente.Localidad) and (auxProvincia = rCliente.Provincia) and (not finClientes) do {al final agrego las condiciones anteriores}
            begin
                inc(totCantLoc);
                LeerClientes(arClientes, rCliente, finClientes);
            end;
            writeln(arTotClientes, PadRight(auxLocalidad, maxLargoProvincia, '.'), totCantLoc);
            totCantProv := totCantProv + totCantLoc;
        end;
        writeln(arTotClientes, 'Total Provincia: ', totCantProv);
        totCantGral := totCantGral + totCantProv;
    end;
    writeln(arTotClientes, '');
    writeln(arTotClientes, 'Total General de Clientes: ', totCantGral);
    close(arTotClientes);
    close(arClientes);
end;

var
    arClientes:tArClientes;
    arTotClientes:tArTotClientes;

{Procedimiento Principal}
begin
    assign(arClientes, 'C:\95_14_algoritmos_y_programacion_i\Clientes.dat');
    assign(arTotClientes, 'C:\95_14_algoritmos_y_programacion_i\TotCli.txt');
    TotalizarClientes(arClientes, arTotClientes);
end.
