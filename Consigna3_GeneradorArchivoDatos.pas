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

{Procedimiento para generar el archivo de Clientes automaticamente}
procedure GenerarArchivoClientes(var arClientes:tArClientes);
	procedure GuardarRegistro(var arClientes:tArClientes; Num_Cliente:tNumCliente; Nombre:tNombre; Provincia:tProvincia; Localidad:tLocalidad; Direccion:tDireccion);
	var
        rCliente:tRCliente;
	begin
        rCliente.Num_Cliente := Num_Cliente;
        rCliente.Nombre := Nombre;
        rCliente.Provincia := Provincia;
        rCliente.Localidad := Localidad;
        rCliente.Direccion := Direccion;
        write(arClientes, rCliente);
	end;
begin
	ReWrite(arClientes);
	GuardarRegistro(arClientes,  1, 'Joel Perez', 'Buenos Aires', 'Avellaneda', 'Mi Calle 521');
	GuardarRegistro(arClientes,  2, 'Oscar Perez', 'Buenos Aires', 'Avellaneda', 'Calle 123');
	GuardarRegistro(arClientes,  3, 'Elizabeth Kocij', 'Buenos Aires', 'Lanus', 'Calle 123');
	GuardarRegistro(arClientes,  4, 'Gisela Nizzero', 'Buenos Aires', 'Lomas', 'Calle 123');
	GuardarRegistro(arClientes,  5, 'Romina Godoy', 'Buenos Aires', 'Lomas', 'Calle 123');
	GuardarRegistro(arClientes,  6, 'Nadia Gamboa', 'CABA', 'Barracas', 'Calle 123');
	GuardarRegistro(arClientes,  7, 'Paula Sullivan', 'CABA', 'Barracas', 'Calle 123');
	GuardarRegistro(arClientes,  8, 'Federico Macintosh', 'CABA', 'Barracas', 'Calle 123');
	GuardarRegistro(arClientes,  9, 'Sebastian Langer', 'CABA', 'Barracas', 'Calle 123');
	GuardarRegistro(arClientes, 10, 'Mauricio Sarmoria', 'CABA', 'Belgrano', 'Calle 123');
	GuardarRegistro(arClientes, 11, 'Gianmarco Cafferata', 'CABA', 'Palermo', 'Calle 123');
	GuardarRegistro(arClientes, 12, 'Lucas Becaccini', 'CABA', 'Palermo', 'Calle 123');
	GuardarRegistro(arClientes, 13, 'David Yan', 'CABA', 'Palermo', 'Calle 123');
	GuardarRegistro(arClientes, 14, 'Alejandro Dolina', 'CABA', 'Palermo', 'Calle 123');
	GuardarRegistro(arClientes, 15, 'Luis Huergo', 'CABA', 'Palermo', 'Calle 123');
	GuardarRegistro(arClientes, 16, 'Rodrigo Bueno', 'Cordoba', 'Capital', 'Calle 123');
	GuardarRegistro(arClientes, 17, 'Juan Carlos Olave', 'Cordoba', 'Capital', 'Calle 123');
	GuardarRegistro(arClientes, 18, 'Augusto Ferrari', 'Cordoba', 'Capital', 'Calle 123');
	GuardarRegistro(arClientes, 19, 'Juan Carlos Jimenez Rufino', 'Cordoba', 'Rio Cuarto', 'Calle 123');
	GuardarRegistro(arClientes, 20, 'Hugo Lopez', 'Cordoba', 'Rio Cuarto', 'Calle 123');
	GuardarRegistro(arClientes, 21, 'Mirta Legrand', 'Cordoba', 'Rio Cuarto', 'Calle 123');
	GuardarRegistro(arClientes, 22, 'Alberto Olmedo', 'Santa Fe', 'Rosario', 'Calle 123');
	GuardarRegistro(arClientes, 23, 'Ernesto Guevara', 'Santa Fe', 'Rosario', 'Calle 123');
	GuardarRegistro(arClientes, 24, 'Fito Paez', 'Santa Fe', 'Rosario', 'Calle 123');
	GuardarRegistro(arClientes, 25, 'Lionel Messi', 'Santa Fe', 'Rosario', 'Calle 123');
	GuardarRegistro(arClientes, 26, 'Angel Di Maria', 'Santa Fe', 'Rosario', 'Calle 123');
	GuardarRegistro(arClientes, 27, 'Carlos Solari', 'Santa Fe', 'Santa Fe', 'Calle 123');
	GuardarRegistro(arClientes, 28, 'Eduardo Beilinson', 'Santa Fe', 'Santa Fe', 'Calle 123');
	GuardarRegistro(arClientes, 29, 'Natalia Oreiro', 'Santa Fe', 'Santa Fe', 'Calle 123');
	GuardarRegistro(arClientes, 30, 'Marcos Mundstock', 'Santa Fe', 'Santa Fe', 'Calle 123');
	GuardarRegistro(arClientes, 31, 'Fernando Ruiz Diaz', 'Santa Fe', 'Santa Fe', 'Calle 123');
	GuardarRegistro(arClientes, 32, 'Natalia Pastorutti', 'Santa Fe', 'Santa Fe', 'Calle 123');
	GuardarRegistro(arClientes, 33, 'Soledad Pastorutti', 'Santa Fe', 'Santa Fe', 'Calle 123');
	Close(arClientes);
end;

var
    arClientes:tArClientes;

{Procedimiento Principal}
begin
    assign(arClientes, 'Clientes.dat');
    GenerarArchivoClientes(arClientes);
end.
