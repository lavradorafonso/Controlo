function [tension,PressureValue,time] = RT030_SetReferencePressure(ReferencePressure)

%____________________Iniciliaz????es_______________________

delay = 0.016;
delay_estab = 0.5;
MotorVoltage=1;
hit = 0;
tol = 0.01;

%____________________C??ddigo_______________________


PressureValue = RT030_GetPressure();
pause(delay_estab);
while(hit == 0)            %Flag para a press?o menor que a referencia
    while(PressureValue < ReferencePressure)
        
        if(ReferencePressure -PressureValue < 0.1)  %pequenos incrementos
            MotorVoltage = MotorVoltage + 0.01;
            RT030_SetCompressorVoltage(MotorVoltage);
            PressureValue = estab(delay_estab + 2*0.45);
        else                                            %grandes incrementos
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
end;
sprintf('Acabou com %g tens???o e %g press???o na camara.', MotorVoltage, round(RT030_GetPressure(),2))
end