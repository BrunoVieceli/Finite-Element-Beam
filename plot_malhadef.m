% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Gera a malha deformada

function [CoordDef]=plot_malhadef(elemento,plotar_nos,Nnos,ndim,Coord,Nelem,Conect,u)
%Inicia Valores
CoordDef=zeros(Nnos,ndim+1);

%fator de amplitude dos deslocamentos
fator=1e3;

%novas coordenadas dos nos
for ii=1:Nnos
    CoordDef(ii,1)=ii;
    CoordDef(ii,2)=Coord(ii,2) + fator*u(2*ii-1);
    CoordDef(ii,3)=Coord(ii,3) + fator*u(2*ii);
end

% Gera malha deformada para plotagem
figure(2)
subplot(1,1,1)
Mesh = GetMesh(Nnos,Nelem,Conect,elemento);
gplot(Mesh,CoordDef(:,2:3),'-r');

axis([0 (max(abs(CoordDef(:,2)))) (min(CoordDef(:,3))-0.2*abs(min(CoordDef(:,3)))) (max(CoordDef(:,3))+0.2*max(CoordDef(:,3)))]);
daspect([1 1 1])
%plota o numero dos nos
if plotar_nos==1
    for j = 1:Nnos
        text(CoordDef(j,2),CoordDef(j,3), int2str(j));
    end
end

title(['Deslocamentos u(x,y) ampliado ',int2str(fator),' vezes']);
end
