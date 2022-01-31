function [press,tensao] = RT030_SetControloProporcional(pressao, k)

press=RT030_GetPressure();

    for i=1:10
        tic
        pressV=RT030_GetPressure();
        press(i)=pressV(1);
        T = k*(pressao-press(1));   %realimenta????o (Y-X)*K
        RT030_SetCompressorVoltage(T);
        tensao(i)=T;      
        
        while toc < 0.3    %periodo de 0.3 segundos
        end
        
    end
    
t=(0:0.3:(length(press)*0.3));
figure;
subplot(211);
plot(t,press);
title('Press?o');
xlabel("Tempo-segundos");
ylabel("Press?o bar");
grid on;
subplot(212);
plot(t,tensao);
title('Tens?o-V');
xlabel("Tempo-segundos");
ylabel("Tens?o-V");
grid on;
end

