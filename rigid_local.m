% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% ELEMENTO QUADRADO ISOPARAMÉTRICO

function [Kelem]=rigid_local(pont_int,ndim,t,Conect,elmID,Coord,pontos,C,modelo,peso,enos,elemento)
Kelem=zeros(enos*ndim,enos*ndim);
if modelo==1 % EPT
    h=t;	 % Espessura do elemento
else
    h=1;
end

% Coord globais dos nós do elemento a partir das conectividades (X formada por x/y colunas, nós nas linhas)
X=zeros(enos,ndim);
for p=1:enos
    for q=1:ndim
        X(p,q)=Coord(Conect(elmID,p+1),q+1);
    end
end

% Loop que percorre os pontos de integração
for pto_eta=1:pont_int
    for pto_xi=1:pont_int
        xi=pontos(pto_xi);  eta=pontos(pto_eta);
        peso1=peso(pto_xi); peso2=peso(pto_eta);
        
        if elemento==1
            [N,dNdxi,dNdeta]=N_pontos_4(xi,eta);  % Valor de N e dN_i/dxi_j nos ptos de Gauss para Q4
        elseif elemento==2
            [N,dNdxi,dNdeta]=N_pontos_9(xi,eta);  % Valor de N e dN_i/dxi_j nos ptos de Gauss para Q9
        elseif elemento==3
            [N,dNdxi,dNdeta]=N_pontos_16(xi,eta); % Valor de N e dN_i/dxi_j nos ptos de Gauss para Q16
        elseif elemento==4
            [N,dNdxi,dNdeta]=N_pontos_25(xi,eta); % Valor de N e dN_i/dxi_j nos ptos de Gauss para Q25
        end
        
        % Calcula a matriz Jacobiana no ponto de integração atual (J_ij=dX_i/dxi_j)
        dN=zeros(ndim,enos);
        for p=1:ndim
            for q=1:enos
                if p==1
                    dN(p,q)=dNdxi(q);
                else
                    dN(p,q)=dNdeta(q);
                end
            end
        end
        J=dN*X;
        
        % Calculo do determinante e da inversa (J^-1=dxi_i/dX_j):
        det_jac=det(J);
        if det_jac<=0
            sprintf('Elemento %d tem Jacobiano inválido!! Pode ter definido errado o sentido de rotação!',elmID)
            finish
        end
        inv_jac=inv(J);
        
        % Calcula as derivadas das funcoes de interpolacao no sistema x-y
        % 1a coluna: dN_i/dx 2a coluna: dN_i/dy
        dNdX=zeros(enos,2);
        for p=1:enos
            for q=1:ndim
                dNdX(p,q)=dNdxi(p)*inv_jac(q,1)+dNdeta(p)*inv_jac(q,2);
            end
        end
        
        % Monta matriz B para o ponto de integração atual:
        B=zeros(3,enos*ndim);
        for p=1:enos
            B(1,2*p-1)=dNdX(p,1); % 1ª Linha (dNp/dx):
            B(2,2*p)=dNdX(p,2);   % 2ª Linha (dNp/dy):
            B(3,2*p)=dNdX(p,1);   % 3ª Linha (dNp/dy):
            B(3,2*p-1)=dNdX(p,2); % 3ª Linha (dNp/dx):
        end
        
        % Calculo da matriz de rigidez do elemento
        Kelem=Kelem+h*transpose(B)*C*B*det_jac*peso1*peso2;
    end
end
% Fim do loop nº de pontos no elemento
