function p_ant = estab(tempo)
p_ant = RT030_GetPressure();
pause(tempo);
while(abs(p_ant-RT030_GetPressure())> 0.01)
    pause(0.016);
    p_ant = RT030_GetPressure();
    pause(tempo);
    tempo = tempo + 0.45;
end;
end

