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


E0 = zeros(nz,nx, 5,5);   % middle variance

E0a = (lam2mu) ./ ((lam2mu)^2-mu^2);
E0b = (-mu) ./ ((lam2mu)^2-mu^2);

E0(:,:,1,1) = rho;
E0(:,:,2,2) = rho;
E0(:,:,3,3) = E0a;
E0(:,:,3,4) = E0b;
E0(:,:,4,3) = E0b;
E0(:,:,4,4) = E0a;
E0(:,:,5,5) = rrho;

E0inv = zeros(nz, nx, 5, 5);  % inversed for E0

for i = 1:nz
    for j = 1:nx
        A = squeeze(E0(i,j,:,:));      
        E0inv(i,j,:,:) = inv(A);       
    end
end

% _x and _z denotes x or z  direction
hWz = zeros(nz,nx,5); % rhs : [Vx_z Vz_Z Txx_z Tzz_z Txz_z]
hWx = zeros(nz,nx,5); % rhs : [Vx_x Vz_x Txx_x Tzz_x Txz_x]

hW_z = zeros(nz,nx,5);  % rhs : [Vx_t Vz_t Txx_t Tzz_t Txz_t]
hW_x = zeros(nz,nx,5);  % rhs : [Vx_t Vz_t Txx_t Tzz_t Txz_t]

W_x = zeros(nz,nx,5);   % rhs : [Vx Vz Txx Tzz Txz]
W_z = zeros(nz,nx,5);   % rhs : [Vx Vz Txx Tzz Txz]
W = zeros(nz,nx,5);   % rhs : [Vx Vz Txx Tzz Txz]
tW = zeros(nz,nx,5);   % middle variance
mW = zeros(nz,nx,5);   % middle variance




while 1
    
    it = it + 1
    if it > nt
        break
    end

    % %--
    % 1 for x direction
    % %--
    % 

    mW = W;
    
    % Stage 1
    W = mW;
    cal_macF
    % ass_rhs_cart_osx;
    ass_rhs_cart;
    Add_source;
    k1 = hW;
    
    % Stage 2
    W = mW + RK4a(2) * k1;
    cal_macB;
    ass_rhs_cart_osx;
    Add_source;
    k2 = hW;
    
    % Stage 3
    W = mW + RK4a(3) * k2;
    cal_macF;
    ass_rhs_cart_osx;
    Add_source;
    k3 = hW;
    
    % Stage 4
    W = mW + RK4a(4) * k3;
    cal_macB;
    ass_rhs_cart_osx;
    Add_source;
    k4 = hW;
    
    % Final RK4 combination
    W = mW + RK4b(1) * k1 + RK4b(2) * k2 + RK4b(3) * k3 + RK4b(4) * k4;


    % %--
    % 2 for z direction
    % %--
    % 
    mW = W;
    
    % Stage 1
    W = mW;
    cal_macB;
    ass_rhs_cart_osz;
    Add_source;
    k1 = hW;
    
    % Stage 2
    W = mW + RK4a(2) * k1;
    cal_macF;
    ass_rhs_cart_osz;
    Add_source;
    k2 = hW;
    
    % Stage 3
    W = mW + RK4a(3) * k2;
    cal_macB;
    ass_rhs_cart_osz;
    Add_source;
    k3 = hW;
    
    % Stage 4
    W = mW + RK4a(4) * k3;
    cal_macF;
    ass_rhs_cart_osz;
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

    % %--
    % 3 for z direction
    % %--
    % 
     mW = W;
    
    % Stage 1
    W = mW;
    cal_macB;
    ass_rhs_cart_osz;
    Add_source;
    k1 = hW;
    
    % Stage 2
    W = mW + RK4a(2) * k1;
    cal_macF;
    ass_rhs_cart_osz;
    Add_source;
    k2 = hW;
    
    % Stage 3
    W = mW + RK4a(3) * k2;
    cal_macB;
    ass_rhs_cart_osz;
    Add_source;
    k3 = hW;
    
    % Stage 4
    W = mW + RK4a(4) * k3;
    cal_macF;
    ass_rhs_cart_osz;
    Add_source;
    k4 = hW;
    
    % Final RK4 combination
    W = mW + RK4b(1) * k1 + RK4b(2) * k2 + RK4b(3) * k3 + RK4b(4) * k4;
    
    
    %--
    % 4 for x direction
    %--
     mW = W;
    
    % Stage 1
    W = mW;
    cal_macF
    ass_rhs_cart_osx;
    Add_source;
    k1 = hW;
    
    % Stage 2
    W = mW + RK4a(2) * k1;
    cal_macB;
    ass_rhs_cart_osx;
    Add_source;
    k2 = hW;
    
    % Stage 3
    W = mW + RK4a(3) * k2;
    cal_macF;
    ass_rhs_cart_osx;
    Add_source;
    k3 = hW;
    
    % Stage 4
    W = mW + RK4a(4) * k3;
    cal_macB;
    ass_rhs_cart_osx;
    Add_source;
    k4 = hW;
    
    % Final RK4 combination
    W = mW + RK4b(1) * k1 + RK4b(2) * k2 + RK4b(3) * k3 + RK4b(4) * k4;

    
    Vxr(it) = W(staz  ,stax,1);
    Vzr(it) = W(staz  ,stax,2);
    
    if flag_snap==1
        if mod(it,50)==0
            pcolor(x_gd,z_gd, W(:,:,1));
            shading interp;
            colorbar;
            title(['Vx: ',num2str((it)*dt),'s']);
            %         caxis([-1e-5 1e-5])
            pause(0.1);
        end
    end
    
    
end

