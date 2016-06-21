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
