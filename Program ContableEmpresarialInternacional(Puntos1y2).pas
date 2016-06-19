Program ContableEmpresarialInternacional;
 
 Uses {BloqPpalProgram} Crt;
 
 Type {BloqPpalProgram}
  T_RegVentasArg=Record
    Fecha:string[8];
    Num_Cliente:longword;
    Sucursal:word;
    Articulo:word;
    Cantidad:word;
    Importe:real;
   end;
  T_ArchVentasArg=File of T_RegVentasArg;
  T_RegSucArg=Record
    Num_Sucursal:word;
    Nombre:string[30];
    Pais:string[50];
    Direccion:string[50];
    Telefono:string[20];
   end;
  T_ArchSucArg=File of T_RegSucArg;
  T_RegVentasHistorico=Record
    Anio:string[4];
    Mes:string[2];
    Num_Sucursal:word;
    Importe:real;
   end;
  T_ArchVentasHistorico=File of T_RegVentasHistorico;
  T_Mes=1..12;    
 
 
  
 Procedure LecturaArchVentasArg(Var ArchVentasArg:T_ArchVentasArg; Var RegVentasArg:T_RegVentasArg; Var FinVentasArg:boolean; Var Mes:T_Mes);
   
    Function ConseguirMes(RegVentasArg:T_RegVentasArg):T_Mes;
      Const
       Posicion=5;
       Cantidad=2;
      Var
       ST_Mes:string[2]; 
       code:byte;
      Begin
       ST_Mes:=Copy(RegVentasArg.Fecha, Posicion, Cantidad);
       Val(ST_Mes, ConseguirMes, code);
      End; 
   
    Begin{Local de Procedure LecturaArchVentasArg}
       FinVentasArg:=EOF(ArchVentasArg);
       if (not FinVentasArg) then
        begin
         Read(ArchVentasArg, RegVentasArg);
         Mes:=ConseguirMes(RegVentasArg)
        end;
    End; {Local de Procedure LecturaArchVentasArg}  
  
 
 
 
 Procedure LecturaArchSucArg(Var ArchSucArg:T_ArchSucArg; Var RegSucArg:T_RegSucArg; Var FinSucArg:boolean);
   Begin
    FinSucArg:=EOF(ArchSucArg);
    if (not FinSucArg) then 
     Read(ArchSucArg, RegSucArg)
   End;    
   
 
 
   
 Procedure CuadroVentasArg2015(Var ArchVentasArg:T_ArchVentasArg; Var ArchSucArg:T_ArchSucArg);

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
  
   Function ConversionEntero(VentasSucMesPpal:real):longword;
     Const
       Coma=',';
       Inicial=1;
     Var
      StAux:string[20];
      Posicion:byte;
      Cantidad:byte;
      code:byte;
     Begin
       Str(VentasSucMesPpal, StAux);
       Posicion:=Pos(Coma, StAux);
       Cantidad:=Posicion-Inicial;
       StAux:=Copy(StAux, Inicial, Cantidad); 
       Val(StAux, ConversionEntero, code)
     End; 
    
   Var{Locales del Procedure CuadroVentasArg2015}
     RegVentasArg:T_RegVentasArg;
     RegSucArg:T_RegSucArg;
     FinVentasArg:boolean;
     FinSucArg:boolean;
     Mes:T_Mes;
     MesPpal:T_Mes0;
     VentasSucMes:T_VecVentasSucMes;
     StSpace:string[3];
    
   Begin{Local del Procedure CuadroVentasArg2015}
     Reset(ArchVentasArg);
     Reset(ArchSucArg);
   
     writeln('----------------------------------------------------------------------------------------------------------------------------------');
     writeln('{Sucursales Arg}      Ene      Feb      Mar      Abr      May      Jun      Jul      Ago      Sep      Oct      Nov      Dic      ');
     writeln('----------------------------------------------------------------------------------------------------------------------------------');
   
     LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg, Mes);
     LecturaArchSucArg(ArchSucArg, RegSucArg, FinSucArg);
  
     StSpace:='  $'
   
     while (not FinVentasArg) and (not FinSucArg) do
       begin
         MesPpal:=0;
         InicializarVentasSucMes(VentasSucMes);
         while (not FinVentasArg) and (not FinSucArg) and (RegVentasArg.Sucursal=RegSucArg.Num_Sucursal) do
           begin
             inc(MesPpal);
             while (not FinVentasArg) and (not FinSucArg) and (RegVentasArg.Sucursal=RegSucArg.Num_Sucursal) and (Mes=MesPpal) do
               begin
                 VentasSucMes[MesPpal]:=VentasSucMes[MesPpal]+RegVentasArg.Importe;
                 LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg, Mes)
               end;
             VentaSucMes[MesPpal]:=ConversionEntero(VentasSucMes[MesPpal]); 
           end;  
         writeln(RegSucArg.Nombre, StSpace, VentasSucMes[1], StSpace, VentasSucMes[2], StSpace, VentasSucMes[3], StSpace, VentasSucMes[4], StSpace, VentasSucMes[5], StSpace, VentasSucMes[6], StSpace, VentasSucMes[7], StSpace, VentasSucMes[8], StSpace, VentasSucMes[9], StSpace, VentasSucMes[10], StSpace, VentasSucMes[11], StSpace, VentasSucMes[12]);        
         LecturaArchSucArg(ArchSucArg, RegSucArg, FinSucArg);   
       end;
   
     while (not FinSucArg) do
       begin
         InicializarVentasSucMes(VentasSucMes);
         writeln(RegSucArg.Nombre, StSpace, VentasSucMes[1], StSpace, VentasSucMes[2], StSpace, VentasSucMes[3], StSpace, VentasSucMes[4], StSpace, VentasSucMes[5], StSpace, VentasSucMes[6], StSpace, VentasSucMes[7], StSpace, VentasSucMes[8], StSpace, VentasSucMes[9], StSpace, VentasSucMes[10], StSpace, VentasSucMes[11], StSpace, VentasSucMes[12]);        
         LecturaArchSucArg(ArchSucArg, RegSucArg, FinSucArg);   
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
           VentasSucMes:=0;;
           while (not FinVentasArg) and (NroSuc=RegVentasArg.Sucursal) and (Mes=MesPpal) do
             begin
               VentasSucMes:=VentasSucMes+RegVentasArg.Importe;
               LecturaArchVentasArg(ArchVentasArg, RegVentasArg, FinVentasArg, Mes)
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
    
    FinVentasArg:=(EOF(ArchVentasArg);
    if (not FinVentasArg) then
      begin
        LecturaArchVentasArg(ArchVentasArch, RegVentasArg, FinVentasArg, Mes);
        LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes)
      end; 
    LecturaArchVentasHistorico(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico); 
    
    while (not FinVentasArg) and (not FinVentasHistorico) do
      begin
        if (RegVentasHistorico.Num_Suc<=RegVentasArgH.Num_Suc) then
            begin
              Writeln(ArchVentasHistoricoActualizado, RegVentasHistorico);
              LecturaArchVentasHistorico(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico);
            end;       
          else begin
                if (RegVentasArgH.Importe<>0) then
                    begin
                     Writeln(ArchVentasHistoricoActualizado, RegVentasArgH);
                     LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes);
                    end;
                  else LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes)
               end;
      end;
    
    while (not FinVentasArg) do
      begin
        Writeln(ArchVentasHistoricoActualizado, RegVentasArgH);
        LecturaConversionArchVentasArg(ArchVentasArg, RegVentasArgH, FinVentasArg, RegVentasArg, Mes)
      end;
    
    while (not FinVentasHistorico) do
      begin
        Writeln(ArchVentasHistoricoActualizado, RegVentasHistorico);
        LecturaArchVentasHistorico(ArchVentasHistorico, RegVentasHistorico, FinVentasHistorico)
      end;
    
    Close(ArchVentasArg);
    Close(ArchVentasHistorico);
    Close(ArchVentasHistoricoActualizado);  
  End; {Local de ProcedureActualizarVentasHistorico}
 
 
 
 Var {BloqPpalProgram}
   ArchVentasArg:T_ArchVentasArg;
   ArchSucArg:T_ArchSucArg;
   ArchVentasHistorico:T_ArchVentasHistorico;
   ArchVentasHistoricoActualizado:T_ArchVentasHistorico;
   
   
 Begin {BloqPpal}
    Assign(ArchVentasArg, 'C:\Ventas.dat');
    Assign(ArchSucArg, 'C:\SucursalesArg.dat');
    Assign(ArchVentasHistorico, 'C:\VentasHistorico.dat');
    Assign(ArchVentasHistoricoActualizado, 'C:\VentasHistoricoActualizado.dat');
    
    
    
    CuadroVentasArg2015(ArchVentasArg, ArchSucArg);
    ActualizarVentasHistorico(ArchVentasArg, ArchVentasHistorico, ArchVentasHistoricoActualizado);
    
    
    
 End. {BloqPpalProgram}
 
