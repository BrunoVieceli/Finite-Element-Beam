%Problema de viga engastada dos dois lados com carga concentrada
%Bruno Cavalli Vieceli - 00243759
%Código Adaptado de Jakson Manfredini Vassoler
%MEC 00082 - Elementos Finitos

%Define os pontos da quadratura de Gauss e pesos

function [pontos,peso]=gauss(elemento,pont_int)
if elemento==1 || elemento==2
    % Pontos da quadratura de Gauss no elemento quadrado isoparamétrico
    if pont_int==2
        % Define os pontos da quadratura de Gauss 2x2:
        peso=[1 1];
        pontos=[-0.577350269189626 0.577350269189626]; % na localização xi_i
    elseif pont_int==3
        % Define os pontos da quadratura de Gauss 3x3:
        peso=[0.555555555555556 0.888888888888889 0.555555555555556];
        pontos=[-0.774596669241483 0 0.774596669241483]; % na localização xi_i
    elseif pont_int==4
        % Define os pontos da quadratura de Gauss 4x4:
        peso=[0.347854845137454 0.652145154862546 0.652145154862546 0.347854845137454];
        pontos=[-0.861136311594053 -0.339981043584856 0.339981043584856 0.861136311594053]; % na localização xi_i
    else
        % Verifica a entrada do numero de pontos de integracao
        errordlg('Numero de pontos de integracao não implementado, Usando a quadratura 3x3','Quadratura de Gauss Invalida');
        % Define os pontos da quadratura de Gauss 3x3:
        p=0.774596669241483;
        pontos=[-p 0 p];
        peso=[0.555555555555556 0.888888888888889 0.555555555555556];
    end
end
end
