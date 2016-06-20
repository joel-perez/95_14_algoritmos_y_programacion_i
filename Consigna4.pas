uses sysutils;

Type
	T_RegSucursal=Record
		Num_Sucursal:word;
		Nombre:string[30];
		Pais:string[50];
		Direccion:string[50];
		Tel:string[20];
		End;
	T_ArchSucursales=file of T_RegSucursal;
Procedure ActualizarSucMundo(var SucMundo:T_ArchSucursales;var SucNuevas:T_ArchSucursales);
	Var
		SucMundoNuevo:T_ArchSucursales;
		RegMundo, RegNuevas:T_RegSucursal;
		FinMundo,FinNuevas:Boolean;
		err:boolean;
	Procedure LeerSucMundo(var SucMundo:T_ArchSucursales;var RegAux:T_RegSucursal;var Fin:boolean)
		Begin
			Fin:=EOF(SucMundo);
			if NOT Fin then
				read(SucMundo,RegAux)
		End;
	Procedure LeerSucNuevas(var SucNuevas:T_ArchSucursales;var RegAux:T_RegSucursal;var Fin:boolean)
		Begin
			Fin:=EOF(SucMundo);
			if NOT Fin then
				read(SucMundo,RegAux);
		End;
	Begin
		err:=false;
		Reset(SucMundo);
		Reset(SucNuevas);
		Rename(SucMundo, Concat('SucMundo',DateTimeToStr(Now),'.BAK'));
		Assign(SucMundoNuevo,'SucMundo.dat');
		Rewrite(SucMundoNuevo);
		LeerSucMundo(SucMundo,RegMundo,FinMundo);
		LeerSucNuevas(SucNuevas,RegNuevas,FinNuevas);
		While NOT (FinMundo OR FinNuevas) do
			If RegNuevas.Num_Sucursal < RegMundo.Num_Sucursal then
				Begin
					Write(SucMundoNuevo, RegNuevas);
					LeerSucNuevas(SucNuevas,RegNuevas,FinNuevas);
				End
			Else if RegNuevas.Num_Sucursal > RegMundo.Num_Sucursal then
				Begin
					Write(SucMundoNuevo, RegMundo);
					LeerSucMundo(SucMundo,RegMundo,FinMundo);
				End
			Else
				Begin
					err:=true;
					Write(SucMundoNuevo, RegNuevas);
					LeerSucNuevas(SucNuevas,RegNuevas,FinNuevas);
					LeerSucMundo(SucMundo,RegMundo,FinMundo);
				End;
		While NOT FinMundo do
			Begin
				Write(SucMundoNuevo, RegMundo);
				LeerSucMundo(SucMundo,RegMundo,FinMundo);
			End;
		While NOT FinNuevas do
			Begin
				Write(SucMundoNuevo, RegNuevas);
				LeerSucMundo(SucNuevas,RegNuevas,FinNuevas);
			End;
		close(SucMundoNuevo);
		close(SucNuevas);
		close(SucMundo);
		If NOT err then
			Erase(SucMundo); //si por alguna razon habia dos iguales y por defecto se conservo el nuevo, no se borra el BAK
		SucMundo:=SucMundoNuevo;
	End;
