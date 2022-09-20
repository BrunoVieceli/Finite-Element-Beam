% Problema de viga engastada dos dois lados com carga concentrada
% Bruno Cavalli Vieceli - 00243759
% Código Adaptado de Jakson Manfredini Vassoler
% MEC 00082 - Elementos Finitos

% Gera matriz M para plotagem

function [M] = GetMesh(Nnos,Nelem,Conect,elemento)
if elemento==1 %Q4
    M = zeros(Nnos,Nnos);
    for e = 1:Nelem
        %nos dos elementos
        no1 = Conect(e,2); no2 = Conect(e,3); no3 = Conect(e,4); no4 = Conect(e,5);
        %conectividade no elemento
        M(no1,no2)=1; M(no2,no3)=1; M(no3,no4)=1; M(no4,no1)=1;
    end
elseif elemento==2 %Q9
    M = sparse(Nnos,Nnos);
    for e = 1:Nelem
        %nos dos elementos
        no1 = Conect(e,2); no2 = Conect(e,3); no3 = Conect(e,4); no4 = Conect(e,5);
        no5 = Conect(e,6); no6 = Conect(e,7); no7 = Conect(e,8); no8 = Conect(e,9);
        %conectividade no elemento
        M(no1,no5)=1; M(no5,no2)=1; M(no2,no6)=1; M(no6,no3)=1;
        M(no3,no7)=1; M(no7,no4)=1; M(no4,no8)=1; M(no8,no1)=1;
    end
elseif elemento==3 %Q16
    M = sparse(Nnos,Nnos);
    for e = 1:Nelem
        %nos dos elementos
        no1 = Conect(e,2);  no2 = Conect(e,3);   no3 = Conect(e,4);   no4 = Conect(e,5);
        no5 = Conect(e,6);  no6 = Conect(e,7);   no7 = Conect(e,8);   no8 = Conect(e,9);
        no9 = Conect(e,10); no10 = Conect(e,11); no11 = Conect(e,12); no12 = Conect(e,13);
        %conectividade no elemento
        M(no1,no5)=1;  M(no5,no6)=1;   M(no6,no2)=1;
        M(no2,no7)=1;  M(no7,no8)=1;   M(no8,no3)=1;
        M(no3,no9)=1;  M(no9,no10)=1;  M(no10,no4)=1;
        M(no4,no11)=1; M(no11,no12)=1; M(no12,no1)=1;
    end
elseif elemento==4 %Q25
    M = sparse(Nnos,Nnos);
    for e = 1:Nelem
        %nos dos elementos
        no1 = Conect(e,2);   no2 = Conect(e,3);   no3 = Conect(e,4);   no4 = Conect(e,5);
        no5 = Conect(e,6);   no6 = Conect(e,7);   no7 = Conect(e,8);   no8 = Conect(e,9);
        no9 = Conect(e,10);  no10 = Conect(e,11); no11 = Conect(e,12); no12 = Conect(e,13);
        no13 = Conect(e,14); no14 = Conect(e,15); no15 = Conect(e,16); no16 = Conect(e,17);
        %conectividade no elemento
        M(no1,no5)=1;  M(no5,no6)=1;   M(no6,no7)=1;   M(no7,no2)=1;
        M(no2,no8)=1;  M(no8,no9)=1;   M(no9,no10)=1;  M(no10,no3)=1;
        M(no3,no11)=1; M(no11,no12)=1; M(no12,no13)=1; M(no13,no4)=1;
        M(no4,no14)=1; M(no14,no15)=1; M(no15,no16)=1; M(no16,no1)=1;
    end
end