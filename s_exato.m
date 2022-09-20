% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Código Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Solucao exata do problema

function [s_ex]=s_exato(L,h,t,Fnodal,x)
I=t*h^3/12;
if x < L/2
    s_ex=(Fnodal*(4*x-L)/8)*(h/2)/I;
elseif x >= L/2
    s_ex=(Fnodal*(3*L-4*x)/8)*(h/2)/I;
end
