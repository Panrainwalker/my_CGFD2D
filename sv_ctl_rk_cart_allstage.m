% -------------------------------------------------------------------------
% solver of isotropic elastic media using cartesian grid with 2-order central stencil
% all stage forward calculation for right hand side (rhs)
%
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 31, 2025
% -------------------------------------------------------------------------
%%%%%%

%% predefine
it = 0;


hWz = zeros(nz,nx,5); % rhs : [Vx_z Vz_Z Txx_z Tzz_z Txz_z]
hWx = zeros(nz,nx,5); % rhs : [Vx_x Vz_x Txx_x Tzz_x Txz_x]
hW = zeros(nz,nx,5);  % rhs : [Vx_t Vz_t Txx_t Tzz_t Txz_t]
W = zeros(nz,nx,5);   % rhs : [Vx Vz Txx Tzz Txz]

dx = xi_gd(2);
dz = zt_gd(2);
while 1
    
    it = it + 1
    if it > nt
        break
    end
    
    % inner point (RHS);
    % calculate derivatives
    cal_center
    %
    ass_rhs_cart;
    % add source
    Add_source;
    %-update W  Euler
    W(4:end-3,4:end-3,:) = W(4:end-3,4:end-3,:) + dt.*hW(4:end-3,4:end-3,:);   %
    
    if mod(it,100)==0
        pcolor(x_gd,z_gd, W(:,:,1));
        shading flat;
        colorbar;
        title(['Vx: ',num2str((it)*dt),'s']);
%         caxis([-1e-5 1e-5])
        pause(0.1);
    end
    
    
end
