global AI

tic
for i = 1:1000    
    Panel_com('get_adc_value',1);
    value(i) = AI;
end
toc

plot(value)

