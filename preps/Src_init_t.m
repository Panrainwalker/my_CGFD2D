t = 0:dt:T_end+0.01;
stf=fun_ricker(t,fc,t0);
% stf(2:end)=0;
% stf(1)=1;
if Src_disp==1
    figure
    plot(t,stf)
end

