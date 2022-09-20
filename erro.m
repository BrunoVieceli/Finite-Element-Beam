% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% MEC 00082 - Elementos Finitos

% Solver do problema

function [erm_u,erm_s,erro_distr_u,erro_distr_s]=erro(Coord,u,L,h,E,t,Fnodal,div_vert,elemento,pont_int,X_s,s_s)
raz_asp=round(L/h);       % Razao de esbeltez
div_hor=raz_asp*div_vert; % Numero de divisões horizontais

err_pos_max=h/2;
L_neutra=zeros(div_hor*elemento+1,2);
erm_u=0; erm_s=0; no_L_neutra=1;
erro_distr_u = zeros(div_hor*elemento+1,1);
erro_distr_s = zeros(div_hor*pont_int,1);

% Loop para pegar o no mais proximo a linha neutra
for i=0:elemento*div_vert
    err_pos=abs(Coord((div_hor+1)*i+1,3)-h/2);
    if err_pos<err_pos_max
        err_pos_max=err_pos;
        no_L_neutra=Coord((div_hor+1)*i+1,1);
    end
end

% Constroi matriz com os nos e posicoes em x na linha neutra
for i=0:div_hor*elemento
    L_neutra(i+1,1)=Coord(no_L_neutra+i,1); % numero do no
    L_neutra(i+1,2)=Coord(no_L_neutra+i,2); % posicao do no em x
end

% Faz a varredura para obter o erro maximo do deslocamento
for i=1:div_hor*elemento+1
    [u_ex]=u_exato(E,L,h,t,Fnodal,L_neutra(i,2)); % Calcula o deslocamento da solucao exata no pto de analise
    u_ef=u(2*L_neutra(i,1),1); % Deslocamento da solucao aproximada
    erro=abs(abs(u_ex)-abs(u_ef)); % Norma de maximo
    if (erro>erm_u)
        erm_u=erro;
    end
    erro_distr_u(i,1) = erro;
end


% Faz a varredura para obter o erro maximo da tensao
for i=1:div_hor*pont_int
    [s_ex]=s_exato(L,h,t,Fnodal,X_s(1,i)); % Calcula a tensao da solucao exata no pto de analise
    s_ef=s_s(pont_int*div_vert,i); % tensao da solucao aproximada
    erro=abs(abs(s_ex)-abs(s_ef)); % Norma de maximo
    if (erro>erm_s)
        erm_s=erro;
    end
    erro_distr_s(i,1) = erro;
end

% Plotar o erro ao longo do comprimento
figure(5)
plot(L_neutra(:,2),erro_distr_u(:,1))
figure(6)
plot(X_s(1,:),erro_distr_s(:,1))
fprintf(1,' O erro máximo do deslocamento em y é %e\n', erm_u);
fprintf(1,' O erro máximo do tensao é %e\n', erm_s);
end
