% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Codigo Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Monta matriz Constitutiva

function [C,modelo]=mod_mat(E,nu,modelo)
C=zeros(3,3);
if modelo==1 % Monta matriz C para EPT
    C(1,1)=E/(1-nu^2);
    C(1,2)=nu*C(1,1);
    C(2,1)=C(1,2);
    C(2,2)=C(1,1);
    C(3,3)=E/(2*(1+nu));
elseif modelo==2 % Monta matriz C para EPD
    C(1,1)=E*(1-nu)/((1+nu)*(1-2*nu));
    C(1,2)=E*nu/((1+nu)*(1-2*nu));
    C(2,1)=C(1,2);
    C(2,2)=C(1,1);
    C(3,3)=E/(2*(1+nu));
else
    errordlg('ESCOLHA ERRADA','ESCOLHA NOVAMENTE O MODELO DO MATERIAL');
    a={'Escolha o modelo de elasticidade plana'};
    b={'EPT - Estado Plano de Tensão'};
    c={'EPD - Estado Plano de Deformação'};
    modelo=menu(a,b,c);
    
    if modelo==1 % Monta matriz C para EPT
        C(1,1)=E/(1-nu^2);
        C(1,2)=nu*C(1,1);
        C(2,1)=C(1,2);
        C(2,2)=C(1,1);
        C(3,3)=E/(2*(1+nu));
    else % Monta matriz C para EPD
        C(1,1)=E*(1-nu)/((1+nu)*(1-2*nu));
        C(1,2)=E*nu/((1+nu)*(1-2*nu));
        C(2,1)=C(1,2);
        C(2,2)=C(1,1);
        C(3,3)=E/(2*(1+nu));
    end
end
