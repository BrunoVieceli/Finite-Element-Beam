% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% ELEMENTO QUADRADO BILINEAR ISOPARAMÉTRICO

function [N,dNdxi,dNdeta]=N_pontos_4(xi,eta)
% Valor das Funções de Interpolação N(xi,eta) no Ponto de Integração atual 'gauss':
N=zeros(2,8);
N1=.25*(1-xi)*(1-eta);
N2=.25*(1+xi)*(1-eta);
N3=.25*(1+xi)*(1+eta);
N4=.25*(1-xi)*(1+eta);

N(1,1)=N1;N(2,2)=N1;
N(1,3)=N2;N(2,4)=N2;
N(1,5)=N3;N(2,6)=N3;
N(1,7)=N4;N(2,8)=N4;

% Valor das derivadas das funções de interpolação no ponto de integração atual:
dNdxi(1)=.25*(-1+eta);			% Função dN1/dxi
dNdxi(2)=.25*(1-eta);			% Função dN2/dxi
dNdxi(3)=.25*(1+eta);			% Função dN3/dxi
dNdxi(4)=.25*(-1-eta);			% Função dN4/dxi

dNdeta(1)=.25*(-1+xi);			% Função dN1/deta
dNdeta(2)=.25*(-1-xi);			% Função dN2/deta
dNdeta(3)=.25*(1+xi);			% Função dN3/deta
dNdeta(4)=.25*(1-xi);			% Função dN4/deta
