Program CargaArchivos;

Uses crt;

Type
	T_RegVentasHistorico=Record 
		Anio:string[4];
		Mes:string[2];
		Num_Sucursal:word;
		Importe:real;
		End;
	T_ArchVentasHistorico=File of T_RegVentasHistorico;
	
	T_RegSucursal=Record
		Num_Sucursal:word;
		Nombre:string[30];
		Pais:string[50];
		Direccion:string[50];
		Tel:string[20];
		End;
	T_ArchSucursales=file of T_RegSucursal;
	
	T_RegCliente=Record
		Num_Cliente:longword;
		Nombre:String[30];
		Provincia:String[50];
		Localidad:String[50];
		Direccion:String[50];
		End;
	T_ArchClientes=file of T_RegCliente;
	
	T_RegVentas=Record
		Fecha:string[8];
		Num_Cliente:longword;
		Sucursal:word;
		Articulo:word;
		Cantidad:word;
		Importe:real;
		End;
	T_ArchVentas=file of T_RegVentas;

Var
	Seleccion:Byte;
	continua:boolean;
	Ventas2015:T_ArchVentas;
	VentasHistorico:T_ArchVentasHistorico;
	SucNuevas,SucMundo:T_ArchSucursales;
	Clientes:T_ArchClientes;
	
Procedure CargarVentas2015(var Ventas:T_ArchVentas); {Opción de carga 1}
Var reg:t_RegVentas; respuesta:char;
begin
	clrscr;
	rewrite(Ventas);
	repeat
		Writeln('Desea cargar el registro de una nueva venta S/N?');
		repeat
			respuesta:=readkey;
		until (respuesta='N') or (respuesta='S') or (respuesta='s') or (respuesta='n');
		if (respuesta='S') or (respuesta='s') then
			begin
				writeln('Ingrese fecha (AAAAMMDD)');
				readln(reg.fecha);
				writeln('Ingrese codigo de cliente');
				readln(reg.Num_Cliente);
				writeln('Ingrese codigo de sucursal');
				readln(reg.Sucursal);
				writeln('Ingrese codigo de articulo');
				readln(reg.Articulo);
				writeln('Ingrese cantidad vendida');
				readln(reg.Cantidad);
				writeln('Ingrese importe');
				readln(reg.Importe);
				write(Ventas,reg);
			end;		
		clrscr;
	until (respuesta='N') or (respuesta='n');
	writeln('Carga de archivo completada');
	writeln('Presione una tecla para continuar');
	readkey;
	Close(Ventas);
end;

Procedure CargarVentasHistorico(var VentasHistorico: t_ArchVentasHistorico); {Opción de carga 2}
Var reg:t_RegVentasHistorico; respuesta:char;
begin
	clrscr;
	rewrite(VentasHistorico);
	repeat
		Writeln('Desea cargar un registro de ventas nuevo? S/N?');
		repeat
			respuesta:=readkey;
		until (respuesta='N') or (respuesta='S') or (respuesta='s') or (respuesta='n');
		if (respuesta='S') or (respuesta='s') then
			begin
				writeln('Ingrese Anio');
				readln(reg.Anio);
				writeln('Ingrese Mes');
				readln(reg.Mes);
				writeln('Ingrese codigo de sucursal');
				readln(reg.Num_Sucursal);
				writeln('Ingrese importe');
				readln(reg.Importe);
				write(VentasHistorico,reg);
			end;
		clrscr;
	until (respuesta='N') or (respuesta='n');
	writeln('Carga de archivo completada');
	writeln('Presione una tecla para continuar');
	readkey;
	Close(VentasHistorico);
end;
		
Procedure CargarSucursales(var Sucursales:T_ArchSucursales); {Opción de carga 3 y 4}		
Var reg:T_RegSucursal; respuesta:char;
begin
	clrscr;
	rewrite(sucursales);
	repeat
		Writeln('Desea cargar un registro de sucursal nuevo? S/N?');
		repeat
			respuesta:=readkey;
		until (respuesta='N') or (respuesta='S') or (respuesta='s') or (respuesta='n');
		if (respuesta='S') or (respuesta='s') then
			begin
				writeln('Ingrese Codigo de sucursal');
				readln(reg.Num_sucursal);
				writeln('Ingrese Nombre de la sucursal');
				readln(reg.Nombre);
				writeln('Ingrese Pais de la sucursal');
				readln(reg.Pais);
				writeln('Ingrese Direccion de la sucursal');
				readln(reg.direccion);
				writeln('Ingrese Telefono de la sucursal');
				readln(reg.tel);
				write(sucursales,reg);
			end;
		clrscr;
	until (respuesta='N') or (respuesta='n');
	writeln('Carga de archivo completada');
	writeln('Presione una tecla para continuar');
	readkey;
	Close(sucursales);		
end;

Procedure CargarClientes(var Clientes:T_ArchClientes); {Opción de carga 5}
Var reg:T_RegCliente; respuesta:char;
begin
	clrscr;
	rewrite(Clientes);
	repeat
		Writeln('Desea cargar un registro de cliente nuevo? S/N?');
		repeat
			respuesta:=readkey;
		until (respuesta='N') or (respuesta='S') or (respuesta='s') or (respuesta='n');
		if (respuesta='S') or (respuesta='s') then
			begin
				writeln('Ingrese Codigo de cliente');
				readln(reg.Num_Cliente);
				writeln('Ingrese Nombre completo del cliente');
				readln(reg.Nombre);
				writeln('Ingrese Provincia del cliente');
				readln(reg.provincia);
				writeln('Ingrese localidad del cliente');
				readln(reg.localidad);
				writeln('Ingrese Direccion del cliente');
				readln(reg.direccion);
				write(Clientes,reg);
			end;
		clrscr;
	until (respuesta='N') or (respuesta='n');
	writeln('Carga de archivo completada');
	writeln('Presione una tecla para continuar');
	readkey;
	Close(Clientes);		
end;

Procedure MostrarVentas2015 (var Ventas:T_ArchVentas); {Opcion de impresion por pantalla 1}
Var Cont:word; reg:t_RegVentas;
begin
	clrscr;
	Cont:=0;
	reset(Ventas);
	while not eof(Ventas) do
		begin	
			Inc(Cont);
			read(Ventas,Reg);
			Writeln('REGITSRO DE VENTA NRO. ',Cont);
			Writeln('Fecha:',Copy(reg.Fecha,7,2),'/',Copy(reg.Fecha,5,2),'/',Copy(reg.Fecha,1,4));
			Writeln('Codigo Cliente:',Reg.Num_Cliente); 
			Writeln('Codigo Sucursal:',Reg.Sucursal);
			Writeln('Codigo Articulo:',Reg.Articulo);
			Writeln('Cantidad:',Reg.Cantidad);
			Writeln('Importe:',Reg.Importe);
			Writeln(' ');
		end;
	close(Ventas);
end;

Procedure MostrarVentasHistorico (var VentasHistorico: t_ArchVentasHistorico); {Opcion de impresion por pantalla 2}
var Cont:Word; reg:t_RegVentasHistorico;
begin
	clrscr;
	Cont:=0;
	reset(VentasHistorico);
	while not eof(VentasHistorico) do
		begin
			inc(Cont);
			read(VentasHistorico,reg);
			Writeln('REGISTRO DE VENTAS NRO. ',Cont);
			Writeln('Anio: ',Reg.Anio);
			Writeln('Mes: ',Reg.Mes);
			Writeln('Codigo Sucursal: ',Reg.Num_Sucursal);
			Writeln('Importe: ',Reg.Importe);
			Writeln(' ');
		end;
	close(VentasHistorico);
End;

Procedure MostrarSucursales (var Sucursales:T_ArchSucursales); {Opcion de impresion por pantalla 3 y 4}
var Cont:Word; reg:t_RegSucursal;
begin
	clrscr;
	Cont:=0;
	reset(Sucursales);
	while not eof(Sucursales) do
		begin
			inc(Cont);
			read(Sucursales,reg);
			Writeln('REGISTRO DE SUCURSAL NRO. ',Cont);
			Writeln('Codigo Sucursal: ',Reg.Num_Sucursal);
			Writeln('Nombre: ',Reg.Nombre);
			Writeln('Pais: ',Reg.Pais);
			Writeln('Direccion; ',Reg.Direccion);
			Writeln('Telefono: ',Reg.Tel);
			Writeln(' ');
		end;
	close(sucursales);
end;
			
			
Procedure MostrarClientes (var Clientes:T_ArchClientes); {Opcion de impresion por pantalla 5}
var Cont:Word; reg:t_RegCliente;
begin
	clrscr;
	Cont:=0;
	reset(Clientes);
	while not eof(Clientes) do		
		begin
			inc(Cont);
			read(Clientes,reg);
			Writeln('REGISTRO DE CLIENTE NRO. ',Cont);
			Writeln('Codigo de Cliente: ',Reg.Num_Cliente);
			Writeln('Nombre Completo: ',Reg.Nombre);
			Writeln('Provincia: ',Reg.Provincia);
			Writeln('Localidad: ',Reg.Localidad);
			Writeln('Direccion: ',Reg.Direccion);
			Writeln(' ');
			readkey;
		end;
	close(Clientes);
end; 

BEGIN {Programa Principal}
	Assign(Ventas2015,'C:\Ventas.dat');
	Assign(VentasHistorico,'C:\VentasHistorico.dat'); 
	Assign(SucNuevas,'C:\SucursalesArg.dat');
	Assign(SucMundo,'C:\SucursalesMundo.dat');
	Assign(Clientes,'C:\Clientes.dat');
	Writeln('Bienvenido al programa de carga de carga de archivos');
	continua:=true;
	While continua do
		begin {Menu de seleccion de carga de archivos}
			repeat
				clrscr;
				Writeln('Seleccione la opcion deseada'); 
				Writeln('1-Cargar archivo de Ventas del anio 2015');
				Writeln('2-Cargar archivo de Ventas historico');
				Writeln('3-Cargar archivo de Sucursales argentinas');
				Writeln('4-Cargar archivo de Sucursales del  mundo');
				Writeln('5-Cargar archivo de Clientes');
				Writeln('6-Finalizar Carga');
				readln(seleccion);
				Case seleccion of
					1:CargarVentas2015(Ventas2015);
					2:CargarVentasHistorico(VentasHistorico); 
					3:CargarSucursales(SucNuevas); 
					4:CargarSucursales(SucMundo); 
					5:CargarClientes(Clientes);
					6:Continua:=False;
					else writeln ('La opcion elegida no es correcta, intente nuevamente'); readkey;
				end;
			until (seleccion=1) or (seleccion=2) or (seleccion=3) or (seleccion=4) or (seleccion=5) or (seleccion=6);
		end;
	continua:=true; {Reutilizo la misma bandera en el siguiente menu}
	While continua do
		begin {Menu de seleccion de impresion de archivos por pantalla}
			repeat
				clrscr;
				Writeln('Seleccione la opcion deseada'); 
				Writeln('1-Mostrar archivo de Ventas del anio 2015');
				Writeln('2-Mostrar archivo de Ventas historico');
				Writeln('3-Mostrar archivo de Sucursales argentinas');
				Writeln('4-Mostrar archivo de Sucursales del  mundo');
				Writeln('5-Mostrar archivo de Clientes');
				Writeln('6-Salir');
				readln(seleccion);
				Case seleccion of
					1:MostrarVentas2015(Ventas2015);
					2:MostrarVentasHistorico(VentasHistorico);
					3:MostrarSucursales(SucNuevas);
					4:MostrarSucursales(SucMundo);
					5:MostrarClientes(Clientes); 
					6:Continua:=False;
					else writeln ('La opcion elegida no es correcta, intente nuevamente'); 
				end;
			until (seleccion=1) or (seleccion=2) or (seleccion=3) or (seleccion=4) or (seleccion=5) or (seleccion=6);
		end;
	writeln('Presione una tecla para continuar . . .');
	readkey;
END.
