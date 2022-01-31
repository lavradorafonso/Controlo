function p_ant = Restacionario(tempo)
p_ant = RT030_GetPressure();
pause(tempo);
while(abs(p_ant-RT030_GetPressure())> 0.01)
    pause(0.016);
    p_ant = RT030_GetPressure();
    pause(tempo);
    tempo = tempo - 0.05;  %vai-se verificando com maior frequencia se est? em regime estacionario
end;
end

