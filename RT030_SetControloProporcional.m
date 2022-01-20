function [press,tensao] = RT030_SetControloProporcional(pressao, k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

press=RT030_GetPressure();
aux=0;
tic
    while(abs(pressao-press)>0.01 | abs(pressap-press)<0.01)
        press(:)=RT030_GetPressure();
        tensao(:) = k*(pressao-press);   %realimentação (Y-X)*K
        RT030_SetCompressorVoltage(tensao);
        
        while(toc-aux ~= 0.3);  %periodo de 0.3 segundos
        aux=toc;
    
       
    end
end

