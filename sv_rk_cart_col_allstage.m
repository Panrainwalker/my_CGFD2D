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
% inputs:
% x_grid : computational grid locations in x dimension --> 1D vector
% z_grid : computational grid locations in z dimension --> 1D vector
%

% nt : number of time step  --> 1D vector
% dt : length of time step  --> 1D vector

% Vs  : S wave velocity (km/s)  --> 2D array
% Vp  : P wave velocity (km/s)  --> 2D array
% rho : desity  (kg/m^3)  --> 2D array

% mu  : shear modulus       --> 2D array
% lam : Lamé parameter      --> 2D array
% lam2mu : λ + 2μ           --> 2D array


% outputs:
% Vx : x-direction velocity  --> 1D vector
% Vz : z-direction velocity  --> 1D vector

% Txx : xx direction Stress --> 2D array
% Tzz : zz direction Stress --> 2D array
% Txz : xz direction Stress --> 2D array

% mu  : shear modulus       --> 2D array
% lam : Lamé parameter      --> 2D array
% lam2mu : λ + 2μ           --> 2D array
%% predefine

Vx = zeros(nz,nx);
Vz = zeros(nz,nx);
Txx = zeros(nz,nx);
Tzz = zeros(nz,nx);
Txz = zeros(nz,nx);

Vx_xi = zeros(nz,nx);
Vx_zt = zeros(nz,nx);
Vz_xi = zeros(nz,nx);
Vz_zt = zeros(nz,nx);

Txx_xi = zeros(nz,nx);
Txx_zt = zeros(nz,nx);
Tzz_xi = zeros(nz,nx);
Tzz_zt = zeros(nz,nx);
Txz_xi = zeros(nz,nx);
Txz_zt = zeros(nz,nx);

% for moment equation
Vx_t = zeros(nz,nx);
Vz_t = zeros(nz,nx);

% for Hooke's equatoin
Txx_t = zeros(nz,nx);
Tzz_t = zeros(nz,nx);
Txz_t = zeros(nz,nx);



hW = zeros(nz,nx,5); % middle stage
W = zeros(nz,nx,5);   % rhs : [Vx Vz Txx Tzz Txz]
tdW = zeros(nz,nx,5); % time derivative rhs : [Vx_t Vz_t Txx_t Tzz_t Txz_t]


it = 0;
nt=30;
while 1

    %--
    %-- FF/BB/FF/BB
    %--
    it = it + 1
    if it > nt
        break
    end

    %% inner point (RHS);
    rhs_update_fw_cart;
    Add_source;
    W = W + dt.*tdW;   %

    % %-RK syn
    % mW = W;
    %
    % %--------
    % %-------- F/B/F/B : the 1st time step for RK4
    % %--------
    % %---- 1st stage for F in RH4
    % % updata RHS
    % rhs_update_fw;
    % Add_source;
    % W = mW + rk_coef{1}{1}(1).* tdW;   %
    % tW = mW +rk_coef{1}{2}(1).* mW;      %
    %
    % % apply RK4
    % % free surface
    % % CFS-PML boundary
    %
    % %---- 2nd stage for B in RH4
    % rhs_update_bw;
    % Add_source;
    % W = mW + rk_coef{1}{1}(2).* tdW;   %
    % tW = tW +rk_coef{1}{2}(2).* mW;      %
    %
    %
    % %---- 3rd stage for F in RH4
    % rhs_update_fw;
    % Add_source;
    % W = mW + rk_coef{1}{1}(3).* tdW;   %
    % tW = tW +rk_coef{1}{2}(3).* mW;      %
    %
    %
    % %---- 4th stage for B in RH4
    % rhs_update_bw;
    % Add_source;
    % W = tW +rk_coef{1}{2}(4).* mW;      %




    pcolor(x_gd,z_gd,W(:,:,1));
    shading flat;
    colorbar;
    title(['Vx: ',num2str((it)*dt),'s']);
    pause(0.1);

end
%-update W


%--------
%-------- BB/FF/BB/FF/BB/FF : the 2th time stage for RK6
%--------

%--------
%-------- BB/FF/BB/FF : the 1th time stage for RK1
%--------

%--------
%-------- FF/BB/FF/BB/FF/BB : the 4th time stage for RK6
%--------


% end % for time loop