Program ContableEmpresarialInternacional;
 
 Uses Crt,sysutils;
 
 Const
    maxLargoNombre = 30;
    maxLargoProvincia = 50;
    maxLargoLocalidad = 50;
    maxLargoDireccion = 50;
    maxLargoPais = 50;
    maxLargoTelefono = 20;
    MaxSucArg=80;

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
  T_RegVentasHst=Record
    Anio:string[4];
    Mes:string[2];
    Num_Sucursal:word;
    Importe:real;
   end;
  T_ArchVentasHistorico=File of T_RegVentasHst;
  T_Mes=1..12; 
  T_SucArg=1..MaxSucArg;
  T_VecSucArg=Array [T_SucArg] of word;
  T_MatVentasArg=Array [T_SucArg, T_Mes] of real;
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


 Procedure LecturaArchSucursal(Var ArchSucursal:T_ArchSucursal; Var RegSucursal:T_RegSucursal; Var FinSucursal:boolean);
   Begin
    FinSucursal:=EOF(ArchSucursal);
    if (not FinSucursal) then
		Read(ArchSucursal, RegSucursal);
   End;


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


 Function PadRight(Valor:string; AnchoTotal:integer; Relleno:char):string;
    Begin
	  PadRight:=Valor+StringOfChar(Relleno, AnchoTotal-Length(Valor));
    End;
    
    
 Procedure LeerClientes(var arClientes:tArClientes; var rCliente:tRCliente; var finClientes:boolean);
	begin
		finClientes := EOF(arClientes);
		if (not finClientes) then
			read(arClientes, rCliente);
	end;


 Procedure CuadroVentasArg2015(Var ArchVentasArg:T_ArchVentasArg; Var ArchSucArg:T_ArchSucursal; Var VecSucArg:T_VecSucArg; Var MatVentasArg:T_MatVentasArg);

   Const{Local del Procedure CuadroVentasArg2015}
    Space=' ';

   Type{Local del Procedure CuadroVentasArg2015}
    T_Mes0=0..12;
    T_Suc0=0..80;
    T_VecVentasSucMes=Array [T_Mes] of real;
    T_VecVentasMesString=Array [T_Mes] of string[5];
    
   Procedure InicializarVentasSucMes(Var VentasSucMes:T_VecVentasSucMes);
     Var
		Mes:T_Mes;
     Begin
		for Mes:=1 to 12 do
		VentasSucMes[Mes]:=0;
     End;
     
   Procedure CargaMatVecArg2015(Var MatVentasArg:T_MatVentasArg; Var VecSucArg:T_VecSucArg; VentasSucMes:T_VecVentasSucMes; NroSuc:T_SucArg; NumSuc:word);
    Var
      Mes:T_Mes;
    Begin
      For Mes:=1 to 12 do
          MatVentasArg[NroSuc, Mes]:=VentasSucMes[Mes];
      VecSucArg[NroSuc]:=NumSuc;    
    End;  
   
   Function RecorteNombreSuc(Nombre:string):string;
    Const
     Posicion=1;
     MaxNom=7;
    Var
     Aux:string[MaxNom]; 
    Begin
     Aux:=Copy(Nombre, Posicion, MaxNom);
     RecorteNombreSuc:=PadRight(Aux, MaxNom, Space);
    End;
    
   Procedure ConversionVentasString(Var VentasMesString:T_VecVentasMesString; VentasSucMes:T_VecVentasSucMes);
    Const
     MaxStVentas=5;
    Var
     j:T_Mes;
     VentasMesInteger:longword;
     StVentas:string[MaxStVentas];
    Begin
     for j:=1 to 12 do
      begin
       VentasMesInteger:=Round(VentasSucMes[j]);
       Str(VentasMesInteger, StVentas);
       VentasMesString[j]:=PadRight(StVentas, MaxStVentas, Space);
      end;
    End;       
   
   Procedure Pausar();
     Begin
       writeln('Presione una tecla y continuar leyendo...');
       readkey;
       writeln('--------------------------------------------------------------------------------');
       writeln('SucArg  Ene   Feb   Mar   Abr   May   Jun   Jul   Ago   Sep   Oct   Nov   Dic   ');
       writeln('--------------------------------------------------------------------------------');
     End;
   
   Var{Local del Procedure CuadroVentasArg2015}
     RegVentasArg:T_RegVentasArg;
     RegSucArg:T_RegSucursal;
     FinVentasArg:boolean;
     FinSucArg:boolean;
     Mes:T_Mes;
     MesPpal:T_Mes0;
     NroSuc:T_Suc0;
     VentasSucMes:T_VecVentasSucMes;
     VentasMesString:T_VecVentasMesString;
     NomSuc:string[7];
     Ctrl:longword;
     Salida:char;

   Begin{Local del Procedure CuadroVentasArg2015}
     ClrScr;
     Reset(ArchVentasArg);
     Reset(ArchSucArg);
     writeln('--------------------------------------------------------------------------------');
     writeln('SucArg  Ene   Feb   Mar   Abr   May   Jun   Jul   Ago   Sep   Oct   Nov   Dic   ');
     writeln('--------------------------------------------------------------------------------');
     LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg);
     if (not FinVentasArg) then
       Mes:=ConseguirMes(RegVentasArg);
     LecturaArchSucursal(ArchSucArg, RegSucArg, FinSucArg);
     NroSuc:=0;
     Ctrl:=0;
     while (not FinVentasArg) and (not FinSucArg) do
      begin
         Ctrl:=Ctrl+1;
         if (Ctrl mod 6 = 0) then Pausar();
         Inc(NroSuc);
         MesPpal:=0;
         InicializarVentasSucMes(VentasSucMes);
         while (not FinVentasArg) and (not FinSucArg) and (RegVentasArg.Sucursal=RegSucArg.Num_Sucursal) do
           begin
             Inc(MesPpal);
             while (not FinVentasArg) and (not FinSucArg) and (RegVentasArg.Sucursal=RegSucArg.Num_Sucursal) and (Mes=MesPpal) do
               begin
                 VentasSucMes[MesPpal]:=VentasSucMes[MesPpal]+RegVentasArg.Importe;
                 LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg);
                 Mes:=ConseguirMes(RegVentasArg);
               end;
           end;
         CargaMatVecArg2015(MatVentasArg, VecSucArg, VentasSucMes, NroSuc, RegSucArg.Num_Sucursal);  
         ConversionVentasString(VentasMesString, VentasSucMes);
         NomSuc:=RecorteNombreSuc(RegSucArg.Nombre);
         write(NomSuc, Space, VentasMesString[1], Space, VentasMesString[2], Space, VentasMesString[3], Space, VentasMesString[4], Space);
         write(VentasMesString[5], Space, VentasMesString[6], Space, VentasMesString[7], Space, VentasMesString[8], Space);
         writeln(VentasMesString[9], Space, VentasMesString[10], Space, VentasMesString[11], Space, VentasMesString[12]);
         writeln('--------------------------------------------------------------------------------');
         LecturaArchSucursal(ArchSucArg, RegSucArg, FinSucArg);
      end;
     InicializarVentasSucMes(VentasSucMes);
     ConversionVentasString(VentasMesString, VentasSucMes);
     while (not FinSucArg) do
       begin
         Inc(NroSuc);
         NomSuc:=RecorteNombreSuc(RegSucArg.Nombre);
         write(NomSuc, Space, VentasMesString[1], Space, VentasMesString[2], Space, VentasMesString[3], Space, VentasMesString[4], Space);
         write(VentasMesString[5], Space, VentasMesString[6], Space, VentasMesString[7], Space, VentasMesString[8], Space);
         writeln(VentasMesString[9], Space, VentasMesString[10], Space, VentasMesString[11], Space, VentasMesString[12]);
         writeln('--------------------------------------------------------------------------------');
         CargaMatVecArg2015(MatVentasArg, VecSucArg, VentasSucMes, NroSuc, RegSucArg.Num_Sucursal);
         LecturaArchSucursal(ArchSucArg, RegSucArg, FinSucArg);
       end;
     repeat
      writeln('Presione ESC en caso de finalizar la lectura del Cuadro de Ventas de las Sucursales Arg en 2015.');
      Salida:=Readkey;
      if (Salida=#27) then writeln('Muchas Gracias.');
     until (Salida=#27);
     Close(ArchVentasArg);
     Close(ArchSucArg);
   End; {Local de Procedure CuadroVentasArg2015}
   
   
 Procedure ActualizarVentasHistorico(Var ArchVentasHistorico, ArchVentasHistoricoActualizado:T_ArchVentasHistorico; Var MatVentasArg:T_MatVentasArg; Var VecSucArg:T_VecSucArg);
  
  Const{Local Procedure ActualizarVentasHistorico}
   Anio='2015';
  
  Procedure LecturaArchVentasHistorico(Var ArchVentasHistorico:T_ArchVentasHistorico; Var RegVentasHistorico:T_RegVentasHst; Var FinVentasH:boolean);
    Begin
       FinVentasH:=EOF(ArchVentasHistorico);
       if (not FinVentasH) then
         Read(ArchVentasHistorico, RegVentasHistorico);
    End; 
          
  Var{Local Procedure ActualizarVentasHistorico}
     FinVentasHistorico:boolean;
     RegVentasHistorico:T_RegVentasHst;
     RegVentasArgH:T_RegVentasHst;
     NroSuc:T_SucArg;
     MesPpal:T_Mes;
  
  Begin{Local de ProcedureActualizarVentasHistorico}
   Reset(ArchVentasHistorico);
   Rewrite(ArchVentasHistoricoActualizado);
   LecturaArchVentasHistorico(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico);
   for NroSuc:=1 to MaxSucArg do
       begin
          while (not FinVentasHistorico) and (RegVentasHistorico.Num_Sucursal<=VecSucArg[NroSuc]) do
                  begin
                    Write(ArchVentasHistoricoActualizado, RegVentasHistorico);
                    LecturaArchVentasHistorico(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico);
                  end;
          for MesPpal:=1 to 12 do
              if (MatVentasArg[NroSuc, MesPpal]<>0) then
                  begin
                     RegVentasArgH.Anio:=Anio;
                     STR(MesPpal, RegVentasArgH.Mes);
                     RegVentasArgH.Num_Sucursal:=VecSucArg[NroSuc];
                     RegVentasArgH.Importe:=MatVentasArg[NroSuc, MesPpal];
                     Write(ArchVentasHistoricoActualizado, RegVentasArgH);
                  end;        
       end;                          
   while (not FinVentasHistorico) do
      begin
         Write(ArchVentasHistoricoActualizado, RegVentasHistorico);
         LecturaArchVentasHistorico(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico);
      end;                    
   Close(ArchVentasHistorico);
   Close(ArchVentasHistoricoActualizado);  
  End;{Local de Procedure ActualizarVentasHistorico}                                            
  
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
			RegMundo, RegNuevas:T_RegSucursal;
			FinMundo,FinNuevas:Boolean;
			SucMundoNuevo:T_ArchSucursal;
		Begin
			Reset(SucMundo);
			Reset(SucNuevas);
			Assign(SucMundoNuevo, 'SucursalesMundoActualizado.dat');
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
  MatVentasArg:T_MatVentasArg;
  VecSucArg:T_VecSucArg; 
   
 Begin {BloqPpal}
    Assign(ArchVentasArg, 'Ventas.dat');
    Assign(ArchVentasHistorico, 'VentasHistorico.dat');
    Assign(ArchVentasHistoricoActualizado, 'VentasHistoricoActualizado.dat');
    Assign(arClientes, 'Clientes.dat');
    Assign(arTotClientes, 'TotCli.txt');
    Assign(ArchSucArg, 'SucursalesArg.dat');
    Assign(ArchSucMundo,'SucursalesMundo.dat');
    CuadroVentasArg2015(ArchVentasArg, ArchSucArg, VecSucArg, MatVentasArg);
    ActualizarVentasHistorico(ArchVentasHistorico, ArchVentasHistoricoActualizado, MatVentasArg, VecSucArg);
    TotalizarClientes(arClientes, arTotClientes);
    ActualizarSucMundo(ArchSucMundo,ArchSucArg);
 End. {BloqPpalProgram}
