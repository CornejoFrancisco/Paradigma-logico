% Obras Artisticas
obra_artisticas(ob1, "El lago de los Cisnes", dir1, 1877).
obra_artisticas(ob2, "Rincion de Luz", dir2, 1995).
obra_artisticas(ob3, "Floricienta", dir2, 2004).


%Directores
directores(dir1,"Victoria","Carreras",10).
directores(dir2,"Cris","Morena",30).
directores(dir3,"Arturo","Pauig",25).

%Funciones
funciones(fun1,ob1,18,05,2022,18,00,1).
funciones(fun2,ob1,18,05,2022,22,00,1).
funciones(fun3,ob2,18,05,2022,16,30,2).
funciones(fun4,ob2,18,05,2022,21,30,2).
funciones(fun5,ob1,19,05,2022,18,00,1).
funciones(fun6,ob1,19,05,2022,21,00,1).
funciones(fun7,ob1,20,05,2022,18,30,1).
funciones(fun8,ob2,20,05,2022,21,00,2).
funciones(fun9,ob1,21,05,2022,18,00,1).
funciones(fun10,ob1,21,05,2022,22,00,1).

%Entradas habilitadas
entradas_habilitadas(en1,fun1,500,no,numero(1)).
entradas_habilitadas(en2,fun1,500,si,numero(3)).
entradas_habilitadas(en3,fun1,500,no,numero(79)).
entradas_habilitadas(en4,fun1,500,si,numero(99)).
entradas_habilitadas(en5,fun1,200,si,vip("A","no")).
entradas_habilitadas(en6,fun1,200,si,vip("B","si")).

entradas_habilitadas(en7,fun2,500,no,numero(9)).
entradas_habilitadas(en8,fun2,500,si,numero(55)).
entradas_habilitadas(en9,fun2,500,si,numero(59)).
entradas_habilitadas(en10,fun2,300,no,vip("A","si")).
entradas_habilitadas(en11,fun2,700,si,vip("F","no")).

entradas_habilitadas(en12,fun3,500,si,numero(99)).
entradas_habilitadas(en13,fun3,500,no,vip("B","si")).
entradas_habilitadas(en14,fun3,500,si,numero(11)).
entradas_habilitadas(en15,fun3,200,si,vip("C","si")).

entradas_habilitadas(en16,fun4,500,si,numero(51)).
entradas_habilitadas(en17,fun4,500,si,vip("A","no")).
entradas_habilitadas(en18,fun4,500,no,numero(1)).
entradas_habilitadas(en19,fun4,200,si,vip("F","si")).
entradas_habilitadas(en20,fun4,500,si,numero(5)).

%Palcos
palcos("A","Primer izquierda",['A1','A2','A3','A4']).
palcos("B","Segundo izquierda",['B1','B2']).
palcos("C","Central arriba",['C1','C2','C3','C4','C5','C6']).
palcos("D","Central abajo",[]).
palcos("E","Primera derecha",['E1','E2']).
palcos("F","Segunda derecha",['F1','F2','F3']).

    %Punto 1
datos_entrada(Cod, Dia, Mes, Anios, Hora,Min, Titulo, Nom, Apel ):-  entradas_habilitadas(Cod,CFun,_,_,_),funciones(CFun,CFUNCION,Dia,Mes,Anios,Hora,Min,_),obra_artisticas(CFUNCION,Titulo,Dir,_), directores(Dir,Nom,Apel,_), nl.

    %Punto 2
existe_entrada_vendida_butaca_entre(Valor1, Valor2):- entradas_habilitadas(_,_,_,si,numero(Butaca)),Butaca =< Valor2,Butaca >= Valor1.

    %Punto 3.

importeFinalPlatea(NB,IMP,IF,Vendida):- ((NB =< 49, IF is IMP * 1.25 ); (NB > 49, IF is IMP * 1.10)),Vendida == si.
importeFinalVIP(Palco,Imp,Ser,IF,Vendida):- (palcos(Palco,_,Lista), length(Lista, X), ((Ser == "no", IF is X * Imp);(Ser == "si",IF is X * Imp * 1.30)),Vendida == si).

importe_final_entrada(CodE,IF):-
                     (entradas_habilitadas(CodE,_,IMP,Vendida,numero(NB)),importeFinalPlatea(NB,IMP,IF,Vendida);
                     entradas_habilitadas(CodE,_,Imp,VVIP,vip(X,F)), importeFinalVIP(X,Imp,F,IF, VVIP));(entradas_habilitadas(CodE,_,_,Vendida,_),Vendida == no, IF is 0).


    %Punto 4.
importe_total_funcion(Fun, IF) :- crearListaImportesFun(Fun, Lista), sumar(Lista,IF).
sumar([],0).
sumar([X|Ss],S) :- sumar(Ss,S2), S is S2+ X.

crearListaImportesFun(Funcion,F):-
    findall(IF,(entradas_habilitadas(Code,Fun,_,_,_), Fun == Funcion,importe_final_entrada(Code,IF)),F).


    % Punto 5.
importe_total_recaudado_obra(Cod,IF) :- crearListaImportesObra(Cod,Lista), sumar(Lista,IF).
crearListaImportesObra(Obra,F):-
  findall(IF,(obra_artisticas(Obra,_,_,_),funciones(Fun,Obra,_,_,_,_,_,_),entradas_habilitadas(Cod,Fun,_,_,_),importe_final_entrada(Cod,IF)),F).


    % Punto 6.
recaudacion_total_por_obra_de_director(CodDirector, Lista) :- crearListaObras(CodDirector, Lista).

crearListaObras(CDirec,L):-
    findall((Titulo,ImporteTotal),(obra_artisticas(CObra,Titulo,CDirec,_),importe_total_recaudado_obra(CObra,ImporteTotal)),L).
