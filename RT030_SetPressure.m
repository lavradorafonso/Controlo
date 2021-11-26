function RT030_SetPressure()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes hereoutputArg1 = inputArg1;

%Inicializa??o de constantes
delay = 0.016;
delay_estab = 0.5;
ReferencePressure = 0.75;
hit = 0;
tol = 0.01;

% %Controlodo Compressor e do respetivo LED
% while(RT030_IsCompressorOn() == 0);
%     disp('Active Compressor please.');
%     RT030_SetCompressorLed(0);
%     pause(2);
% end;
% if(RT030_IsCompressorOn() == 1);
%     disp('The Compressor is active.');
%     RT030_SetCompressorLed(1);
%     pause(delay);
% end;

%Inicializa??o da press?o e tens?o
erroVoltage = RT030_SetCompressorVoltage(0);
pause(delay);%Abertura da valvula
erroValvula = RT030_SetValve(1);

pause(delay);
if(erroVoltage ~= 0 || erroValvula ~= 0)
    disp('A error has ocured in the valvue or in the motor DC.');
end;
%RT030_SetValveLed(1);
pause(delay);%Esperar que a press?o seja aproximadamente = 0
while(round(RT030_GetPressure(),2) > 0.1);
    pause(delay);
end;
%Fecho da valvula
erroValvula = RT030_SetValve(0);
pause(delay);
%RT030_SetValveLed(0);
pause(delay);
if(erroValvula ~= 0)
    disp('A error has ocured during the valvue opening.');
end;

%In?cio da resolu??o do problema
MotorVoltage = 1;
PressureValue = RT030_GetPressure();
pause(delay_estab);
while(hit == 0)%Se a press?o for menor, aumentamos a tens?o
    while(PressureValue < ReferencePressure)
        if(ReferencePressure -PressureValue < 0.15)
            MotorVoltage = MotorVoltage + 0.01;
            RT030_SetCompressorVoltage(MotorVoltage);
            PressureValue = estab(delay_estab + 2*0.45);
        else
            MotorVoltage = MotorVoltage + 0.1;
            RT030_SetCompressorVoltage(MotorVoltage);
            PressureValue = estab(delay_estab);
        end
        sprintf('Press?o: %g',PressureValue)
        sprintf('Erro: %g', abs(PressureValue -ReferencePressure))
        sprintf('Tens?o: %g',MotorVoltage)%Se o valor estiver com um erro de 0.01, ser? dado hit!
        if(abs(PressureValue-ReferencePressure)<tol);
            hit = 1;
            break;
        end;
    end;
    
    %Se a press?o for maior, abrimos um bocadinho a valvula eletr?nica
    while(PressureValue > ReferencePressure)RT030_SetValve(1);
        pause(delay);
        RT030_SetValveLed(1);
        pause(delay);
        while(PressureValue > (ReferencePressure -0.01))
            PressureValue = RT030_GetPressure();
            pause(delay);
        end;
        %Voltamos a fechar
        RT030_SetValve(0);
        pause(delay);
        RT030_SetValveLed(0);
        pause(delay);%E iremos diminuir a tens?o para n?o voltar a subir a press?o%na camara.
        MotorVoltage = MotorVoltage -0.05;
        RT030_SetCompressorVoltage(MotorVoltage);
        PressureValue = estab(4*delay_estab); %Rever
        sprintf('Press?o: %g',PressureValue)
        sprintf('Erro: %g', PressureValue -ReferencePressure)
        sprintf('Tens?o: %g',MotorVoltage)
        if(abs(PressureValue-ReferencePressure)<tol);
            hit = 1;
            break;
        end;
    end;
end;
sprintf('Acabou com %g tens???o e %g press???o na camara.', MotorVoltage, round(RT030_GetPressure(),2))
end
