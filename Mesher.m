% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Código Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Mesher

function [Nelem,Nnos,Coord,Conect]=Mesher(L,h,div_vert,elemento)
raz_asp=round(L/h);       % Razao de esbeltez
div_hor=raz_asp*div_vert; % Numero de divisões horizontais
alt_ele=h/div_vert;       % Altura do elemento
comp_ele=L/div_hor;       % Comprimento do elemento

% Matriz de coordenadas dos nos
No=1;
for i=1:(elemento*div_vert+1)
    for j=1:(elemento*div_hor+1)
        Coord(No,:)=[No (comp_ele)*(j-1)/elemento (alt_ele)*(i-1)/elemento] ;
        No=No+1;
    end
end

% Matriz de Conectividade
if elemento==1 %Q4
    Elem=1;
    for j=1:div_vert
        for i=1:div_hor
            Conect(Elem,:)=[Elem (i+(j-1)*(div_hor+1)) (i+1+(j-1)*(div_hor+1)) (i+1+j*(div_hor+1)) (i+j*(div_hor+1))];
            Elem=Elem+1;
        end
    end
elseif elemento==2 %Q9
    Elem=1;
    for i=1:div_vert
        for j=1:div_hor
            Conect(Elem,:)=[Elem ((2*j-1)+2*(i-1)*(2*div_hor+1)) ((2*j-1)+2+2*(i-1)*(2*div_hor+1)) ((2*j-1)+2+2*i*(2*div_hor+1)) ((2*j-1)+2*i*(2*div_hor+1)) ((2*j-1)+1+2*(i-1)*(2*div_hor+1)) ((2*j-1)+2+2*i*(2*div_hor+1)-(2*div_hor+1)) ((2*j-1)+1+2*i*(2*div_hor+1)) ((2*j-1)+2*i*(2*div_hor+1)-(2*div_hor+1)) (1+(2*j-1)+2*i*(2*div_hor+1)-(2*div_hor+1))];
            Elem=Elem+1;
        end
    end
elseif elemento==3 %Q16
    Elem=1;
    for i=1:div_vert
        for j=1:div_hor
            disp('Conectividade não implementada');
            finish
        end
    end
elseif elemento==4 %Q25
    Elem=1;
    for i=1:div_vert
        for j=1:div_hor
            disp('Conectividade não implementada');
            finish
        end
    end
end

Nelem=Elem-1; % Numero de elementos
Nnos=No-1;    % Numero de nos