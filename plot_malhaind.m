%Problema de viga engastada dos dois lados com carga concentrada
%Bruno Cavalli Vieceli - 00243759
%Código Adaptado de Jakson Manfredini Vassoler
%MEC 00082 - Elementos Finitos

% Gera malha indeformada para plotagem

function [Nnos]=plot_malhaind(Nnos,Nelem,Conect,Coord,L,h,elemento,plotar_nos)
figure(1)
Mesh = GetMesh(Nnos,Nelem,Conect,elemento);
gplot(Mesh,Coord(:,2:3));
axis([0 L (-h) (2*h)]);

%plota o numero dos nos
daspect([1 1 1])

if plotar_nos==1 % Monta matriz C para EPT
    for j = 1:Nnos
        text(Coord(j,2),Coord(j,3),int2str(j));
    end
end

title('Malha Indeformada');