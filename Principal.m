% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Limpar a memoria antes de iniciar o problema
clear; clc; format long;
disp('----------------------------------')

% Leitura de Dados, Montagem da estrutura de dados, Calculo do vetor de Forças externas total
[div_vert,pont_int,L,h,ndim,elemento,plotar_nos,modelo,E,nu,t,Nelem,Nnos,Ndesno,ndesl,str_recov,Nmat,Conect,Coord,desl_prsct,Propmat,Fnodal,Fext]=Dados;

% Gera malha indeformada para plotagem
[Nnos]=plot_malhaind(Nnos,Nelem,Conect,Coord,L,h,elemento,plotar_nos);

% Define os pontos da quadratura de Gauss
[pontos,peso]=gauss(elemento,pont_int);

% Define se o modelo é EPT ou EPD:
[C,modelo]=mod_mat(E,nu,modelo);

% Calcula a matriz de rigidez global
disp(' '); disp('Tempo para montar a matriz Global'); tic
[Kglobal]=rigid_global(pont_int,Nelem,Nnos,ndim,t,Conect,Coord,pontos,C,modelo,peso,elemento); toc

% Alteracao da matriz Kglobal com inclusao das cc
[Kglobal,cc_zero]=modKglobal(ndesl,desl_prsct,ndim,Nnos,Kglobal);

% Resolucao do sistema de equacoes
disp(' '); disp('Tempo para a solução do sistema de equações'); tic
[u]=solver(Kglobal,Fext); toc

% Gera a malha deformada
[CoordDef]=plot_malhadef(elemento,plotar_nos,Nnos,ndim,Coord,Nelem,Conect,u);

% Pos processamento
[tensao,deform]=posproc(u,pont_int,Nelem,ndim,Conect,Coord,C,elemento,pontos);

% Visualizacao das tensoes e deformacoes
[X_s,Y_s,s_s,e_s]=plot_sig_eps(tensao,deform,div_vert,pont_int,L,h);

% Erro de maximo
[erm_u,erm_s,erro_distr_u,erro_distr_s]=erro(Coord,u,L,h,E,t,Fnodal,div_vert,elemento,pont_int,X_s,s_s);