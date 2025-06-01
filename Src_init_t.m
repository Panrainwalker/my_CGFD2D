t = 0:dt:src_t_end;
stf=fun_ricker(t,fc,t0);

if Src_disp==1
    figure
    plot(t,stf)
end

