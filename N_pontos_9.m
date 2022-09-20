% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% ELEMENTO QUADRADO BIQUADRÁTICO ISOPARAMÉTRICO

function [N,dNdxi,dNdeta]=N_pontos_9(r,s)
% Valor das Funções de Interpolação N(xi,eta) no Ponto de Integração atual 'gauss':
N=zeros(2,18);
N9=(1-r^2)*(1-s^2);
N8=.5*(1-r)*(1-s^2)-.5*N9;
N7=.5*(1-r^2)*(1+s)-.5*N9;
N6=.5*(1+r)*(1-s^2)-.5*N9;
N5=.5*(1-r^2)*(1-s)-.5*N9;
N4=.25*(1-r)*(1+s)-.5*(N7+N8)-.25*N9;
N3=.25*(1+r)*(1+s)-.5*(N7+N6)-.25*N9;
N2=.25*(1+r)*(1-s)-.5*(N5+N6)-.25*N9;
N1=.25*(1-r)*(1-s)-.5*(N8+N5)-.25*N9;

N(1,1)=N1;  N(2,2)=N1;
N(1,3)=N2;  N(2,4)=N2;
N(1,5)=N3;  N(2,6)=N3;
N(1,7)=N4;  N(2,8)=N4;
N(1,9)=N5;  N(2,10)=N5;
N(1,11)=N6; N(2,12)=N6;
N(1,13)=N7; N(2,14)=N7;
N(1,15)=N8; N(2,16)=N8;
N(1,17)=N9; N(2,18)=N9;

% Valor das derivadas das funções de interpolação no ponto de integração atual:
dNdxi(9)=-2*r*(-s^2+1);
dNdxi(8)=0.5*s^2-0.5+1.0*r*(-s^2+1);
dNdxi(7)=-1.0*r*(1+s)+1.0*r*(-s^2+1);
dNdxi(6)=-0.5*s^2+0.5+1.0*r*(-s^2+1);
dNdxi(5)=-1.0*r*(1-s)+1.0*r*(-s^2+1);
dNdxi(4)=-0.25*s+0.50*r*(1+s)-0.50*r*(-s^2+1)-0.25*s^2;
dNdxi(3)=0.25*s+0.50*r*(1+s)-0.50*r*(-s^2+1)+0.25*s^2;
dNdxi(2)=-0.25*s+0.50*r*(1-s)-0.50*r*(-s^2+1)+0.25*s^2;
dNdxi(1)=0.25*s-0.25*s^2-0.50*r*(-s^2+1)+0.50*r*(1-s);

dNdeta(9)=-2*(-r^2+1)*s;
dNdeta(8)=-1.0*(1-r)*s+1.0*(-r^2+1)*s;
dNdeta(7)=-0.5*r^2+0.5+1.0*(-r^2+1)*s;
dNdeta(6)=-1.0*(1+r)*s+1.0*(-r^2+1)*s;
dNdeta(5)=0.5*r^2-0.5+1.0*(-r^2+1)*s;
dNdeta(4)=-0.25*r+0.25*r^2-0.50*(-r^2+1)*s+0.50*(1-r)*s;
dNdeta(3)=0.25*r+0.25*r^2-0.50*(-r^2+1)*s+0.50*(1+r)*s;
dNdeta(2)=-0.25*r-0.25*r^2-0.50*(-r^2+1)*s+0.50*(1+r)*s;
dNdeta(1)=0.25*r+0.50*(1-r)*s-0.50*(-r^2+1)*s-0.25*r^2;
