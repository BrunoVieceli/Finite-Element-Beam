% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Código Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Solucao exata do problema

function [u_ex,s_ex]=u_exato(E,L,h,t,Fnodal,x)
I=t*h^3/12;
if x < L/2
    u_ex=((Fnodal*x^2)*(4*x-3*L))/(48*E*I);
elseif x >= L/2
    u_ex=((Fnodal*(L-x)^2)*((L-x)*2*L-(3*L^2)/2))/(24*E*I*L);
end
