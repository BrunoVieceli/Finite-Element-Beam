% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% MEC 00082 - Elementos Finitos

% Solver do problema

function [X_s,Y_s,s_s,e_s]=plot_sig_eps(tensao,deform,div_vert,pont_int,L,h)
raz_asp=round(L/h);       % Razao de esbeltez
div_hor=raz_asp*div_vert; % Numero de divisões horizontais
cont=1;
np=pont_int;
np2=pont_int*pont_int;

XX=zeros(np*div_hor,1); YY=zeros(np*div_vert,1);

% monta vetor com posicoes X
for i=1:div_hor
    for j=1:pont_int
        XX(j+np*(i-1))=deform(1+np2*(i-1)+(j-1),2);
    end
end

% monta vetor com posicoes Y
for i=0:div_vert-1
    for j=1:pont_int
        YY(np*i+j)=deform((div_hor*np2)*i+1+(j-1)*np,3);
    end
end

[X_s,Y_s]=meshgrid(XX,YY); % Monta a malha para plotar a superficie

a={'Qual tensão plotar?'}; b={'sig_xx'}; c={'sig_yy'}; d={'sig_xy'}; e={'sig_vm'};
S=menu(a,b,c,d,e);
a={'Qual deformação plotar?'}; b={'eps_xx'}; c={'eps_yy'}; d={'eps_xy'}; e={'eps_vm'};
E=menu(a,b,c,d,e);

for i=0:div_vert-1 % Monta a malha de tensoes e deformacoes de acordo com as coordenadas de analise
    for j=0:div_hor-1
        m=0;
        for k=1:np
            for l=1:np
                s_s((np*i+1)+(k-1),(np*j+1)+(l-1))=tensao(cont+m,S+3);
                e_s((np*i+1)+(k-1),(np*j+1)+(l-1))=deform(cont+m,E+3);
                m=m+1;
            end
        end
        cont=cont+np2;
    end
end
figure(3); surf(X_s,Y_s,s_s); shading interp; colorbar; daspect([5 1 1]); title('Tensões');
figure(4); surf(X_s,Y_s,e_s); shading interp; colorbar; daspect([5 1 1]); title('Deformações');
end