% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% C�digo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Solver do problema

function [u]=solver(Kglobal,Fext)
u=Kglobal^-1*Fext;
end
