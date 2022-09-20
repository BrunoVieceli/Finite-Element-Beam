% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Código Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Modificacao da Matriz Kglobal para incluir as cc

function [Kglobal,cc_zero]=modKglobal(ndesl,desl_prsct,ndim,Nnos,Kglobal)
% vetor com os nos globais com restricao
cc_zero=zeros(ndesl,1);
 for i=1:ndesl
     cc_zero(i,1)=(desl_prsct(i,1)*ndim-2)+desl_prsct(i,2); % captando os números dos nós com deslocamento prescrito
 end
for col=1:Nnos*ndim
    for j=1:ndesl
        if cc_zero(j,1)==col
            for k=1:Nnos*ndim
              Kglobal(col,k)=0; % zera a coluna da matriz global que tem deslc prescrito associado
              Kglobal(k,col)=0; % zera a linha da matriz global que tem deslc prescrito associado
            end
            Kglobal(col,col)=1; % iguala a 1 para equivaler ao deslc prescrito na hora de resolver para u(x,y).
        end
    end
end
