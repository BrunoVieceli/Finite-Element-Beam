% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Código Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Leitura de Dados, Motagem da estrutura de dados, Calculo do vetor de Forças externas Total

function [div_vert,pont_int,L,h,ndim,elemento,plotar_nos,modelo,E,nu,t,Nelem,Nnos,Ndesno,ndesl,str_recov,Nmat,Conect,Coord,desl_prsct,Propmat,Fnodal,Fext]=Dados
% Definicao das propriedades geometricas e de material
E=2.1e5;     % Modulo de elasticidade
nu=0.3;      % Coeficiente de Poisson
t=24;        % Espessura do elemento (se modelo EPD)
L=480;       % Comprimento da viga
h=t;         % Altura da viga (viga quadrada)
Fnodal=-350; % Forca Aplicada
D_centro=.5; % Distancia em relacao a x da aplicacao da carga

pont_int=3;   % Numero de pontos de integracao (por direcao)
modelo=1;     % Modelo (1)EPT ou (2)EPD
elemento=2;   % Tipo de elemento (1)Q4 (2)Q9 (3)Q16 (4)Q25
div_vert=1;   % Numero de divisoes vertical
plotar_nos=0; % (0) nao plota os nos (1) plota os nos
str_recov=0;  % (0) sem stress recovery (1) com stress recovery (nao implementado)

Ndesno=2;         % Numero de deslocamentos por no
ndim=Ndesno;      % Numero de dimensoes do problema
Nmat=1;           % Numero de materiais diferentes
Propmat=[1 E nu]; % As propriedades do material de cada elemento

% Mesher
[Nelem,Nnos,Coord,Conect]=Mesher(L,h,div_vert,elemento);

% Aplicando as cc nas linhas
ndesl=0; %numero de restricoes
for i=1:Nnos
    if Coord(i,2)==0
        ndesl=ndesl+1;
        desl_prsct(ndesl,1)=Coord(i,1); desl_prsct(ndesl,2)=1; desl_prsct(ndesl,3)=0;
        ndesl=ndesl+1;
        desl_prsct(ndesl,1)=Coord(i,1); desl_prsct(ndesl,2)=2; desl_prsct(ndesl,3)=0;
    end
    if Coord(i,2)==L
        ndesl=ndesl+1;
        desl_prsct(ndesl,1)=Coord(i,1); desl_prsct(ndesl,2)=1; desl_prsct(ndesl,3)=0;
        ndesl=ndesl+1;
        desl_prsct(ndesl,1)=Coord(i,1); desl_prsct(ndesl,2)=2; desl_prsct(ndesl,3)=0;
    end
end

% Inicializar o vetor de forcas externas nodais
Fext=zeros(Nnos*Ndesno,1);
% Insercao da forca externa
for i=1:Nnos
    if Coord(i,3)==h
        if Coord(i,2)==D_centro*L
            Fext(2*Coord(i,1),1)=Fnodal;
        end
    end
end

end