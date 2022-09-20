% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Monta a matriz de rigidez global e de Massa e aplica CC

function [Kglobal]=rigid_global(pont_int,Nelem,Nnos,ndim,t,Conect,Coord,pontos,C,modelo,peso,elemento)
% Inicia matrizes/vetores globais
Kglobal=zeros(Nnos*ndim,Nnos*ndim);
if elemento==1 % Q4
    enos=4;
elseif elemento==2 % Q9
    enos=9;
elseif elemento==3 % Q16
    enos=16;
elseif elemento==4 % Q25
    enos=25;
end

% Matriz de rigidez local:
for elmID=1:Nelem
    
    [Kelem]=rigid_local(pont_int,ndim,t,Conect,elmID,Coord,pontos,C,modelo,peso,enos,elemento);
    
    % Monta a matriz de rigidez global (aplicando a superposicao)
    for noellinha=1:enos								   % Varre os nós da matriz local
        for direcaolinha=1:ndim						       % Cada no tem "ndim" direcões
            linhael=ndim*(noellinha-1)+direcaolinha;	       % Calcula em qual linha da matriz local está o nó local (1 ou 2) do elemento
            nogloballinha=Conect(elmID,(noellinha+1));		   % Calcula qual o nó global correspondente àquele nó local do elemento
            linhaglobal=ndim*(nogloballinha-1)+direcaolinha; % Calcula a linha na matriz de global daquele nó naquela direção
            for noelcoluna=1:enos						   % Repete o mesmo procedimento para as colunas da matriz de rigidez local e global
                for direcaocoluna=1:ndim
                    colunael=ndim*(noelcoluna-1)+direcaocoluna;
                    noglobalcoluna=Conect(elmID,(noelcoluna+1));
                    colunaglobal=ndim*(noglobalcoluna-1)+direcaocoluna;
                    Kglobal(linhaglobal,colunaglobal)=Kglobal(linhaglobal,colunaglobal)+Kelem(linhael,colunael);
                end
            end
        end
    end
    % Fim do loop para um elemento
end
% Fim do loop "número de elementos"