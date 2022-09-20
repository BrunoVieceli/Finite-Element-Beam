% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% ELEMENTO QUADRADO BILINEAR ISOPARAM�TRICO

function [N,dNdxi,dNdeta]=N_pontos_4(xi,eta)
% Valor das Fun��es de Interpola��o N(xi,eta) no Ponto de Integra��o atual 'gauss':
N=zeros(2,8);
N1=.25*(1-xi)*(1-eta);
N2=.25*(1+xi)*(1-eta);
N3=.25*(1+xi)*(1+eta);
N4=.25*(1-xi)*(1+eta);

N(1,1)=N1;N(2,2)=N1;
N(1,3)=N2;N(2,4)=N2;
N(1,5)=N3;N(2,6)=N3;
N(1,7)=N4;N(2,8)=N4;

% Valor das derivadas das fun��es de interpola��o no ponto de integra��o atual:
dNdxi(1)=.25*(-1+eta);			% Fun��o dN1/dxi
dNdxi(2)=.25*(1-eta);			% Fun��o dN2/dxi
dNdxi(3)=.25*(1+eta);			% Fun��o dN3/dxi
dNdxi(4)=.25*(-1-eta);			% Fun��o dN4/dxi

dNdeta(1)=.25*(-1+xi);			% Fun��o dN1/deta
dNdeta(2)=.25*(-1-xi);			% Fun��o dN2/deta
dNdeta(3)=.25*(1+xi);			% Fun��o dN3/deta
dNdeta(4)=.25*(1-xi);			% Fun��o dN4/deta
