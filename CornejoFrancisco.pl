cls:- write('\33\[2J').
% Funcion(CodigoFun,CodigoPelicula,Fecha(Dia,Mes;ano),ButacaNoVendidas,Tarifa,codigoFuncion)
funcion(fun1,peli3,fecha(21,5,2022),[12, 20, 30],200,sal1).
funcion(fun2,peli1,fecha(21,5,2022),[1, 10],220,sal2).
funcion(fun3,peli1,fecha(22,5,2022),[2, 12, 14, 20, 23],180,sal3).
funcion(fun4,peli2,fecha(22,5,2022),[ ],220,sal4).
funcion(fun5,peli3,fecha(23,5,2022),[20, 21, 25],150,sal1).
funcion(fun6,peli2,fecha(23,5,2022),[30, 31],180,sal2).
funcion(fun7,peli2,fecha(24,5,2022),[4, 18, 19, 30, 33],220,sal1).
funcion(fun8,peli1,fecha(25,5,2022),[ ],300,sal2).
funcion(fun9,peli2,fecha(25,5,2022),[ ],300,sal3).
funcion(fun10,peli1,fecha(25,5,2022),[ ],300,sal4).


% CodigoSala Descripcion proyecto CantidadButacas
sala(sal1,'Sala 1 - 3D - 50',si,50).
sala(sal2,'Sala 2 – común - 40',no,40).
sala(sal3,'Sala 3 – común - 30',no,30).
sala(sal4,'Sala 4 - 3D - 40',si,40).


%CodigoPelicula Titulo aniodefilmacion
pelicula(peli1,'La Dama y el Vagabundo',1997).
pelicula(peli2,'100 Dálmatas',2001).
pelicula(peli3,'Pluto y sus Amigos',2019).
pelicula(peli4,'Aristoperros',2020).

%Punto1
regla1(Peli1,Peli2) :- (pelicula(Peli1,_,_),
                        funcion(_,Peli1,fecha(25,5,2022),_,_,_);
                       pelicula(Peli2,_,_),
                       funcion(_,Peli2,fecha(25,5,2022),_,_,_)).

regla2(Fun,TT,DspSala) :- funcion(Fun,Peli,_,_,_,Desp),
     pelicula(Peli,TT,_),
     sala(Desp,DspSala,_,_).



regla3(Cantidad,Lista) :- findall(Codigo,
    (funcion(Codigo,_,_,ButacaNo,_,_),
     length(ButacaNo,NoVendida),NoVendida >= Cantidad),Lista).
