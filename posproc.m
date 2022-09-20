% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% MEC 00082 - Elementos Finitos

% Monta valores de tensao e deformacao

function [tensao,deform]=posproc(u,pont_int,Nelem,ndim,Conect,Coord,C,elemento,pontos)
deform = zeros(pont_int*pont_int*Nelem,6); % 1-elem 2-x_pto_int 3-y_pto_int 4-e_xx 5-e_yy 6-e_xy 7-e_vm
tensao = zeros(pont_int*pont_int*Nelem,7); % 1-elem 2-x_pto_int 3-y_pto_int 4-s_xx 5-s_yy 6-s_xy 7-s_vm

if elemento==1 % Q4
    enos=4;
elseif elemento==2 % Q9
    enos=9;
elseif elemento==3 % Q16
    enos=16;
elseif elemento==4 % Q25
    enos=25;
end
cont=0;
% loop através de todos os elementos
for elmID=1:Nelem
    X=zeros(enos,ndim);
    disp=zeros(enos*ndim,1);
    for p=1:enos
        disp(ndim*p-1)=u(2*Conect(elmID,p+1)-1); % deslocamentos em x dos nos do elemento
        disp(ndim*p)=u(2*Conect(elmID,p+1));     % deslocamentos em y dos nos do elemento
        for q=1:ndim
            X(p,q)=Coord(Conect(elmID,p+1),q+1);     % coordenadas globais dos nos do elemento
        end
    end
    % loop através de cada pto de integracao dentro do elemento
    for pto_eta=1:pont_int
        for pto_xi=1:pont_int
            cont=cont+1;
            xi=pontos(pto_xi);  eta=pontos(pto_eta);
            
            if elemento==1
                [N,dNdxi,dNdeta]=N_pontos_4(xi,eta);  % Valor de N e dN_i/dxi_j nos ptos para Q4
            elseif elemento==2
                [N,dNdxi,dNdeta]=N_pontos_9(xi,eta);  % Valor de N e dN_i/dxi_j nos ptos para Q9
            elseif elemento==3
                [N,dNdxi,dNdeta]=N_pontos_16(xi,eta); % Valor de N e dN_i/dxi_j nos ptos para Q16
            elseif elemento==4
                [N,dNdxi,dNdeta]=N_pontos_25(xi,eta); % Valor de N e dN_i/dxi_j nos ptos para Q25
            end
            
            % Coordenadas globais (x e y) do pto de integracao analisado
            x_pto_int=zeros(ndim,1);
            for p = 1:ndim
                for q = 1:enos
                    x_pto_int(p) = x_pto_int(p) + X(q,p)*N(1,2*q-1); % x=sum(x_i*N_i)
                end
            end
            
            % Calcula a matriz Jacobiana e inversa no ponto de integração atual (J_ij=dX_i/dxi_j)
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
            
            e_pto=B*disp;  % deformaçoes no pto de integracao avaliado
            s_pto=C*e_pto; % tensoes no pto de integracao avaliado
            e_vm=sqrt(.5*((e_pto(1) - e_pto(2))^2 + e_pto(1)^2 + e_pto(2)^2)+3*e_pto(3)^2); % deformacao de Von Mises
            s_vm=sqrt(.5*((s_pto(1) - s_pto(2))^2 + s_pto(1)^2 + s_pto(2)^2)+3*s_pto(3)^2); % tensao de Von Mises
            
            % Montagem das matrizes que contem def e sua localizacao
            deform(cont,1)=elmID;    deform(cont,2)=x_pto_int(1); deform(cont,3)=x_pto_int(2);
            deform(cont,4)=e_pto(1); deform(cont,5)=e_pto(2);     deform(cont,6)=e_pto(3);
            deform(cont,7)=e_vm;
            % Montagem das matrizes que contem tens e sua localizacao
            tensao(cont,1)=elmID;    tensao(cont,2)=x_pto_int(1); tensao(cont,3)=x_pto_int(2);
            tensao(cont,4)=s_pto(1); tensao(cont,5)=s_pto(2);     tensao(cont,6)=s_pto(3);
            tensao(cont,7)=s_vm;
        end
    end
end
end

