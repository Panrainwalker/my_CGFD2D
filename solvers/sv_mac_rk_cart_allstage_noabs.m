% -------------------------------------------------------------------------
% solver of isotropic elastic media using cartesian grid
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
tW = zeros(nz,nx,5);   % middle variance
mW = zeros(nz,nx,5);   % middle variance


while 1
    
    it = it + 1
    if it > nt
        break
    end
    mW = W;
    
    % Stage 1
    W = mW;
    prep_free_cart;
    % for inner point
    cal_macF
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;

    % for free surface

    Add_source;

    k1 = hW;
    
    % Stage 2
    W = mW + RK4a(2) * k1;
    prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;
    Add_source;
    k2 = hW;
    
    % Stage 3
    W = mW + RK4a(3) * k2;
    prep_free_cart;
    % for inner point
    cal_macF
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;
    Add_source;
    k3 = hW;
    
    % Stage 4
    W = mW + RK4a(4) * k3;
    prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;
    Add_source;
 
    k4 = hW;
    
    % Final RK4 combination
    W = mW + RK4b(1) * k1 + RK4b(2) * k2 + RK4b(3) * k3 + RK4b(4) * k4;
    
    
    Vxr(it) = W(staz  ,stax,1);
    Vzr(it) = W(staz  ,stax,2);
    
    it = it + 1
    if it > nt
        break
    end
    mW = W;

    
    % Stage 1
    W = mW;
    prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;

    % for free surface

    Add_source;

    k1 = hW;
    
    % Stage 2
    W = mW + RK4a(2) * k1;
    prep_free_cart;
    % for inner point
    cal_macF
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;
    Add_source;

    k2 = hW;
    
    % Stage 3
    W = mW + RK4a(3) * k2;
    prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;
    Add_source;
  
    k3 = hW;
    
    % Stage 4
    W = mW + RK4a(4) * k3;
    prep_free_cart;
    % for inner point
    cal_macF
    % for free surface
    apply_free_srf_cart
    ass_rhs_cart;
    Add_source;
    
    k4 = hW;
    
    % Final RK4 combination
    W = mW + RK4b(1) * k1 + RK4b(2) * k2 + RK4b(3) * k3 + RK4b(4) * k4;
    

    Vxr(it) = W(staz  ,stax,1);
    Vzr(it) = W(staz  ,stax,2);
    
    if flag_snap==1
        if mod(it,50)==0
            pcolor(x_gd,z_gd, W(:,:,1));
            % plot(W(round(nz/2)+1:end,100,1));
            shading interp;
            colorbar;
            set(gca, 'YDir', 'reverse');
            title(['Vx: ',num2str((it)*dt),'s']);
            %         caxis([-1e-5 1e-5])
            pause(0.1);
        end
    end
    
    
end

