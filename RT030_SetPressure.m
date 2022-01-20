function [tension] = RT030_SetPressure(ReferencePressure)

%____________________Iniciliaz????es_______________________

delay = 0.016;
MotorVoltage=1;


%____________________C??ddigo_______________________


PressureValue = RT030_GetPressure();

while(PressureValue < ReferencePressure)
        
    if(ReferencePressure -PressureValue < (0.05+(ReferencePressure/7)))  %pequenos incrementos ao aproximar da referencia. referencias mais altas precisam de um pouco mais antecendencia
        MotorVoltage = MotorVoltage + 0.01;
        RT030_SetCompressorVoltage(MotorVoltage);
        PressureValue = Restacionario(4);
    else                                            %grandes incrementos
        MotorVoltage = MotorVoltage + 0.1;
        RT030_SetCompressorVoltage(MotorVoltage);
        PressureValue = Restacionario(1);
    end
    sprintf('Press?o: %g',PressureValue)
    %sprintf('Erro: %g', abs(PressureValue -ReferencePressure))
    sprintf('Tens?o: %g',MotorVoltage)
    if(abs(PressureValue-ReferencePressure)<0.01);   %parar quando se atingir um erro de 0.01
        break;
    end;

end;
tension=MotorVoltage;
sprintf('Acabou com %g tens???o e %g press???o na camara.', MotorVoltage, round(RT030_GetPressure(),2))
return
end