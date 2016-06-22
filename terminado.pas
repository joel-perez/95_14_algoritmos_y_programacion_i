Program ContableEmpresarialInternacional;
 
 Uses Crt,sysutils;
 
 const
    maxLargoNombre = 30;
    maxLargoProvincia = 50;
    maxLargoLocalidad = 50;
    maxLargoDireccion = 50;
    maxLargoPais = 50;
    maxLargoTelefono = 20;
    
 Type
  T_RegVentasArg=Record
    Fecha:string[8];
    Num_Cliente:longword;
    Sucursal:word;
    Articulo:word;
    Cantidad:word;
    Importe:real;
   end;
  T_ArchVentasArg=File of T_RegVentasArg;
  T_RegSucursal=Record
    Num_Sucursal:word;
    Nombre:string[maxLargoNombre];
    Pais:string[maxLargoPais];
    Direccion:string[maxLargoDireccion];
    Telefono:string[maxLargoTelefono];
   end;
  T_ArchSucursal=File of T_RegSucursal;
  T_RegVentasHistorico=Record
    Anio:string[4];
    Mes:string[2];
    Num_Sucursal:word;
    Importe:real;
   end;
  T_ArchVentasHistorico=File of T_RegVentasHistorico;
  T_Mes=1..12;  
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
 
 
  
 Procedure LecturaArchVentasArg(Var ArchVentasArg:T_ArchVentasArg; Var RegVentasArg:T_RegVentasArg; Var FinVentasArg:boolean);
    Begin
       FinVentasArg:=EOF(ArchVentasArg);
       if (not FinVentasArg) then
         Read(ArchVentasArg, RegVentasArg);
    End;
    
 Procedure LecturaArchVentasHst(Var ArchVentasHistorico:T_ArchVentasHistorico; Var RegVentasHistorico:T_RegVentasHistorico; Var Fin:boolean);
   
    Begin
       Fin:=EOF(ArchVentasHistorico);
       if (not Fin) then
         Read(ArchVentasHistorico, RegVentasHistorico);
    End;
    
 Procedure LecturaArchSucursal(Var ArchSucursal:T_ArchSucursal; Var RegSucursal:T_RegSucursal; Var FinSucursal:boolean);
   Begin
    FinSucursal:=EOF(ArchSucursal);
    if (not FinSucursal) then 
		Read(ArchSucursal, RegSucursal)
   End;
   
 Procedure LecturaArchVentas(Var ArchVentas:T_ArchVentasHistorico; Var RegVentas:T_RegVentasHistorico; Var FinVentas:boolean);
   Begin
    FinVentas:=EOF(ArchVentas);
    if (not FinVentas) then 
		Read(ArchVentas, RegVentas)
   End;
   
   procedure LeerClientes(var arClientes:tArClientes; var rCliente:tRCliente; var finClientes:boolean);
	begin
		finClientes := EOF(arClientes);
		if (not finClientes) then
			read(arClientes, rCliente);
	end;
	
	Function ConseguirMes(RegVentasArg:T_RegVentasArg):T_Mes;
      Const
       Posicion=5;
       Cantidad=2;
      Var
       ST_Mes:string[2]; 
	  Begin
       ST_Mes:=Copy(RegVentasArg.Fecha, Posicion, Cantidad);
       Val(ST_Mes, ConseguirMes);
      End; 
      
    {Consigna 3: Indentacion (un extra)}
		function PadRight(valor:string; anchoTotal:integer; relleno:char):string;
		begin
			PadRight := valor + StringOfChar(relleno, anchoTotal - Length(valor));
		end;
		
	


 Procedure CuadroVentasArg2015(Var ArchVentasArg:T_ArchVentasArg; Var ArchSucArg:T_ArchSucursal);
 
   Type{Local del ProcedureCuadroVentasArg2015}
    T_Mes0=0..12;
    T_VecVentasSucMes=Array [T_Mes] of real;
     
   Procedure InicializarVentasSucMes(Var VentasSucMes:T_VecVentasSucMes);
     Var
		j:T_Mes;
     Begin
		for j:=1 to 12 do
		VentasSucMes[j]:=0
     End;
    
   Var{Locales del Procedure CuadroVentasArg2015}
     RegVentasArg:T_RegVentasArg;
     RegSucArg:T_RegSucursal;
     FinVentasArg:boolean;
     FinSucArg:boolean;
     Mes:T_Mes;
     MesPpal:T_Mes0;
     VentasSucMes:T_VecVentasSucMes;
     StSpace:string[3];
    
   Begin{Local del Procedure CuadroVentasArg2015}
     Reset(ArchVentasArg);
     Reset(ArchSucArg);
     FinVentasArg:=TRUE;
     writeln('----------------------------------------------------------------------------------------------------------------------------------');
     writeln('{Sucursales Arg}      Ene      Feb      Mar      Abr      May      Jun      Jul      Ago      Sep      Oct      Nov      Dic      ');
     writeln('----------------------------------------------------------------------------------------------------------------------------------');
   
     LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg);
     LecturaArchSucursal(ArchSucArg, RegSucArg, FinSucArg);
  
     StSpace:='  $';
   
     while (not FinVentasArg) and (not FinSucArg) do
       begin
         MesPpal:=0;
         InicializarVentasSucMes(VentasSucMes);
         while (not FinVentasArg) and (not FinSucArg) and (RegVentasArg.Sucursal=RegSucArg.Num_Sucursal) do
           begin
             inc(MesPpal);
             while (not FinVentasArg) and (not FinSucArg) and (RegVentasArg.Sucursal=RegSucArg.Num_Sucursal) and (ConseguirMes(RegVentasArg)=MesPpal) do
               begin
                 VentasSucMes[MesPpal]:=VentasSucMes[MesPpal]+RegVentasArg.Importe;
                 LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg)
               end;
             VentasSucMes[MesPpal]:=Round(VentasSucMes[MesPpal]); 
           end;  
         writeln(RegSucArg.Nombre, StSpace, VentasSucMes[1], StSpace, VentasSucMes[2], StSpace, VentasSucMes[3], StSpace, VentasSucMes[4], StSpace, VentasSucMes[5], StSpace, VentasSucMes[6], StSpace, VentasSucMes[7], StSpace, VentasSucMes[8], StSpace, VentasSucMes[9], StSpace, VentasSucMes[10], StSpace, VentasSucMes[11], StSpace, VentasSucMes[12]);        
         LecturaArchSucursal(ArchSucArg, RegSucArg, FinSucArg);   
       end;
   
     while (not FinSucArg) do
       begin
         InicializarVentasSucMes(VentasSucMes);
         writeln(RegSucArg.Nombre, StSpace, VentasSucMes[1], StSpace, VentasSucMes[2], StSpace, VentasSucMes[3], StSpace, VentasSucMes[4], StSpace, VentasSucMes[5], StSpace, VentasSucMes[6], StSpace, VentasSucMes[7], StSpace, VentasSucMes[8], StSpace, VentasSucMes[9], StSpace, VentasSucMes[10], StSpace, VentasSucMes[11], StSpace, VentasSucMes[12]);        
         LecturaArchSucursal(ArchSucArg, RegSucArg, FinSucArg);   
       end; 
   
     Close(ArchVentasArg);
     Close(ArchSucArg); 
   End; {Local de Procedure CuadroVentasArg2015}
  
  
      
 Procedure ActualizarVentasHistorico(Var ArchVentasArg:T_ArchVentasArg; Var ArchVentasHistorico:T_ArchVentasHistorico; Var ArchVentasHistoricoActualizado:T_ArchVentasHistorico);
  
  Procedure LecturaConversionArchVentasArg(Var ArchVentasArg:T_ArchVentasArg; Var RegVentasArgH:T_RegVentasHistorico; Var FinVentasArg:boolean; Var RegVentasArg:T_RegVentasArg; Var Mes:T_Mes);
    
    Procedure ConversionH(Var RegVentasArgH:T_RegVentasHistorico; VentasSucMes:real; MesPpal:T_Mes; NroSuc:word);
       Const
         Anio='2015';
       Begin
         RegVentasArgH.Anio:=Anio;
         Str(MesPpal, RegVentasArgH.Mes);
         RegVentasArgH.Num_Sucursal:=NroSuc;
         RegVentasArgH.Importe:=VentasSucMes
       End;
    
    Var{Local de Procedure LecturaConversionArchVentasArg}
      VentasSucMes:real;
      MesPpal:T_Mes;
      NroSuc:word;
  
    Begin{Local de Procedure LecturaConversionArchVentasArg}
      if (not FinVentasArg)then
         begin   
           NroSuc:=RegVentasArg.Sucursal;
           MesPpal:=Mes;
           VentasSucMes:=0;
           while (not FinVentasArg) and (NroSuc=RegVentasArg.Sucursal) and (Mes=MesPpal) do
             begin
               VentasSucMes:=VentasSucMes+RegVentasArg.Importe;
               LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg)
             end;  
           ConversionH(RegVentasArgH, VentasSucMes, MesPpal, NroSuc)
         end;     
    End; {Local de Procedure LecturaConversionArchVentasArg}  
  
  
  
  Var{Local de ProcedureActualizarVentasHistorico}
     RegVentasArgH:T_RegVentasHistorico;
     RegVentasHistorico:T_RegVentasHistorico;
     FinVentasArg:boolean;
     FinVentasHistorico:boolean; 
     RegVentasArg:T_RegVentasArg;
     Mes:T_Mes;
     
  Begin{Local de ProcedureActualizarVentasHistorico}
    Reset(ArchVentasArg);
    Reset(ArchVentasHistorico);
    Rewrite(ArchVentasHistoricoActualizado);
    
    FinVentasArg:=EOF(ArchVentasArg);
    if (not FinVentasArg) then
      begin
        LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg);
        LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes)
      end; 
    LecturaArchVentasHst(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico); 
    
    while (not FinVentasArg) and (not FinVentasHistorico) do
        if (RegVentasHistorico.Num_Sucursal<=RegVentasArgH.Num_Sucursal) then
            begin
              Write(ArchVentasHistoricoActualizado, RegVentasHistorico);
              LecturaArchVentasHst(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico)
            end
        else
			begin
                if (RegVentasArgH.Importe<>0) then
                    begin
                     Write(ArchVentasHistoricoActualizado, RegVentasArgH);
                     LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes);
                    end
                  else 
                  LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes);
            end;
    
    while (not FinVentasArg) do
      begin
        Write(ArchVentasHistoricoActualizado, RegVentasArgH);
        LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes)
      end;
    
    while (not FinVentasHistorico) do
      begin
        Write(ArchVentasHistoricoActualizado, RegVentasHistorico);
        LecturaArchVentasHst(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico);
      end;
    
    Close(ArchVentasArg);
    Close(ArchVentasHistorico);
    Close(ArchVentasHistoricoActualizado);  
  End; {Local de ProcedureActualizarVentasHistorico}
  
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
	
   	Procedure ActualizarSucMundo(var SucMundo:T_ArchSucursal;var SucNuevas:T_ArchSucursal);
		Var
			SucMundoNuevo:T_ArchSucursal;
			RegMundo, RegNuevas:T_RegSucursal;
			FinMundo,FinNuevas:Boolean;
			err:boolean;
		Begin
			err:=false;
			Reset(SucMundo);
			Reset(SucNuevas);
			Rename(SucMundo, Concat('SucMundo',DateTimeToStr(Now),'.BAK'));
			Assign(SucMundoNuevo,'SucMundo.dat');
			Rewrite(SucMundoNuevo);
			LecturaArchSucursal(SucMundo,RegMundo,FinMundo);
			LecturaArchSucursal(SucNuevas,RegNuevas,FinNuevas);
			While NOT (FinMundo OR FinNuevas) do
				If RegNuevas.Num_Sucursal < RegMundo.Num_Sucursal then
					Begin
						Write(SucMundoNuevo, RegNuevas);
						LecturaArchSucursal(SucNuevas,RegNuevas,FinNuevas);
					End
				Else if RegNuevas.Num_Sucursal > RegMundo.Num_Sucursal then
					Begin
						Write(SucMundoNuevo, RegMundo);
						LecturaArchSucursal(SucMundo,RegMundo,FinMundo);
					End
				Else
					Begin
						err:=true;
						Write(SucMundoNuevo, RegNuevas);
						LecturaArchSucursal(SucNuevas,RegNuevas,FinNuevas);
						LecturaArchSucursal(SucMundo,RegMundo,FinMundo);
					End;
			While NOT FinMundo do
				Begin
					Write(SucMundoNuevo, RegMundo);
					LecturaArchSucursal(SucMundo,RegMundo,FinMundo);
				End;
			While NOT FinNuevas do
				Begin
					Write(SucMundoNuevo, RegNuevas);
					LecturaArchSucursal(SucNuevas,RegNuevas,FinNuevas);
				End;
			close(SucMundoNuevo);
			close(SucNuevas);
			close(SucMundo);
			If NOT err then
				Erase(SucMundo); //si por alguna razon habia dos iguales y por defecto se conservo el nuevo, no se borra el BAK
			SucMundo:=SucMundoNuevo;
		End;

 
 Var {BloqPpalProgram}
   ArchVentasArg:T_ArchVentasArg;
   ArchSucArg:T_ArchSucursal;
   ArchVentasHistorico:T_ArchVentasHistorico;
   ArchVentasHistoricoActualizado:T_ArchVentasHistorico;
   arClientes:tArClientes;
   arTotClientes:tArTotClientes;
   ArchSucMundo:T_ArchSucursal;
   ArchSucNuevas:T_ArchSucursal;
   
   
 Begin {BloqPpal}
    Assign(ArchVentasArg, 'Ventas.dat');
    Assign(ArchSucArg, 'SucursalesArg.dat');
    Assign(ArchVentasHistorico, 'VentasHistorico.dat');
    Assign(ArchVentasHistoricoActualizado, 'VentasHistoricoActualizado.dat');
    assign(arClientes, 'Clientes.dat');
    assign(arTotClientes, 'TotCli.txt');
    assign(ArchSucMundo, 'SucMundo.dat');
    assign(ArchSucNuevas, 'SucNuevas.dat');
    CuadroVentasArg2015(ArchVentasArg, ArchSucArg);
    ActualizarVentasHistorico(ArchVentasArg, ArchVentasHistorico, ArchVentasHistoricoActualizado);
    TotalizarClientes(arClientes, arTotClientes);
    ActualizarSucMundo(ArchSucMundo,ArchSucNuevas);
 End. {BloqPpalProgram}
