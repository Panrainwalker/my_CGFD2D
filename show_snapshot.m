function show_snapshot(it)

    % subplot(2,1,1);

    pcolor(x_gd, z_gd, W(:,:,1));
    shading flat;
    colorbar;
    set(gca,'ydir','normal');
    axis image
    title(['Vx: ',num2str((it)*dt+t0),'s']);
    %caxis([-1,1]*1e-4);
    
    % subplot(2,1,2);
    % imagesc(xvec,zvec,W(:,:,2));
    % colorbar;
    % set(gca,'ydir','normal');
    % axis image
    % title(['Vz: ',num2str((it)*dt+t0),'s']);
    % %caxis([-1,1]*1e-4);
    
    pause(0.1);
end
