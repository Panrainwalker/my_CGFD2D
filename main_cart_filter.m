clc;clear;close all;

%% parameters (Stencil, grid, media, source)
%%%%% Time %%%%%
T_total = 0.5;     % unit (s)

Stencil_t;

%%%%% source %%%%%
src_ix = 200 + 3; % source index
src_iz = 200 + 3;

src_t_end=0.05;
fc = 30 ; %Hz
t0 = 0.04  ; %s


%% Grid generation

% Code for Cartesian Grid
nz=400 + 6;
nx=400 + 6;
length_z=200;
length_x=200; % length of x: 200m

topo = 0 + zeros(1, nx); % topography flat 100m

% computational grid
xi_gd = linspace(1,length_x,nx); % 100 points
zt_gd = -linspace(1,length_z,nz);


[x_gd, z_gd] = meshgrid(xi_gd, zt_gd);

%     figure;
%     plot(x_gd, z_gd, 'k')           % plot vertical lines
%     hold on
%     plot(x_gd', z_gd', 'k')         % plot horizontal lines
%     axis equal tight
%     xlabel('X (m)');
%     ylabel('Z (m)');
%     title('Cartesian Grid');


d_diag1 = sqrt( (x_gd(2:end,2:end) - x_gd(1:end-1,1:end-1)).^2 + ...
    (z_gd(2:end,2:end) - z_gd(1:end-1,1:end-1)).^2 );
d_diag2 = sqrt( (x_gd(2:end,1:end-1) - x_gd(1:end-1,2:end)).^2 + ...
    (z_gd(2:end,1:end-1) - z_gd(1:end-1,2:end)).^2 );

d_diag = min(d_diag1, d_diag2);
dh = min(min(d_diag));

%% Media initial
Vp  = ones(nz,nx);
Vs  = ones(nz,nx);
rho = ones(nz,nx);


disp('Half-space model');
Vp(:,:)  = 2000;
Vs(:,:)  = 1000;
rho(:,:) = 1200;


Vp_max = max(max(Vp));
Vp_min = min(min(Vp));
Vs_max = max(max(Vs));
Vs_min = min(min(Vs));


dt = (0.1 * dh / Vp_max) ;
nt = round(T_total/dt) + 1;

disp(['Vp_min=',num2str(Vp_min),'; Vp_max=',num2str(Vp_max)]);
disp(['Vs_min=',num2str(Vs_min),'; Vs_max=',num2str(Vs_max)]);
disp(['dt=',num2str(dt),'; nt=',num2str(nt)]);


mu  = Vs.^2 .* rho;
lam = Vp.^2 .* rho - 2.0 * mu;

lam2mu = zeros(nz,nx);
lam2mu = lam + 2.0*mu;

%% Source initial
t = 0:dt:T_total;
stf=fun_ricker(t,fc,t0);


%% solver

RK4a = [0.5,0.5,1.0,0.0];
RK4b = [1.0/6.0,1.0/3.0,1.0/3.0,1.0/6.0];

hWz = zeros(nz,nx,5); % rhs : [Vx_z Vz_Z Txx_z Tzz_z Txz_z]
hWx = zeros(nz,nx,5); % rhs : [Vx_x Vz_x Txx_x Tzz_x Txz_x]
hW = zeros(nz,nx,5);  % rhs : [Vx_t Vz_t Txx_t Tzz_t Txz_t]
W = zeros(nz,nx,5);   % rhs : [Vx Vz Txx Tzz Txz]
tW = zeros(nz,nx,5);   % middle variance
mW = zeros(nz,nx,5);   % middle variance

dx = xi_gd(2);
dz = abs(zt_gd(2));
RK4a = RK4a .* dt;
RK4b = RK4b .* dt;

it = 0;
while 1
    
    it = it + 1
    if it > nt
        break
    end
    
    mw = W;
    
    
    %--
    %-- FF/BB/FF/BB Stage 1 for RK4
    %--
    
    % Part 1 FF
    % calculate derivatives
    cal_Dxf;
    cal_Dzf;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
    W = mW + RK4a(1) * hW; %-- RK
    tW = mW + RK4b(1) * hW;
    
    % Part 2 BB
    % calculate derivatives
    cal_Dxb;
    cal_Dzb;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
    W = mW + RK4a(2) * hW; %-- RK
    tW = tW + RK4b(2) * hW;
    
    % Part 3 FF
    % calculate derivatives
    cal_Dxf;
    cal_Dzf;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
     W = mW + RK4a(3) * hW; %-- RK
    tW = tW + RK4b(3) * hW;
    
    
    % Part 4 BB
    % calculate derivatives
    cal_Dxb;
    cal_Dzb;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
    W = tW + RK4b(4) * hW; 
    

    %--
    %-- BB/FF/BB/FF
    %--
    it = it + 1
    if it > nt
        break
    end
    mw = W;
    
    % Part 1 BB
    % calculate derivatives
    cal_Dxb;
    cal_Dzb;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
    W = mW + RK4a(1) * hW; %-- RK
    tW = mW + RK4b(1) * hW;
    
    % Part 2 FF
    % calculate derivatives
    cal_Dxf;
    cal_Dzf;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
     W = mW + RK4a(2) * hW; %-- RK
    tW = tW + RK4b(2) * hW;
    
    % Part 3 BB
    % calculate derivatives
    cal_Dxb;
    cal_Dzb;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
     W = mW + RK4a(3) * hW; %-- RK
    tW = tW + RK4b(3) * hW;
    
    
    % Part 4 FF
    % calculate derivatives
    cal_Dxf;
    cal_Dzf;
    ass_rhs;
    % add source
    Add_source;
    %-update W  
    W = tW + RK4b(4) * hW; 
    



    if mod(it,100)==0
        %     pcolor(x_gd(1:2:end-1,2:2:end-1),z_gd(1:2:end-1,2:2:end-1), W(1:2:end-1,2:2:end-1,3));
%             pcolor(x_gd(1:2:end-1,1:2:end-1),z_gd(1:2:end-1,1:2:end-1), W(1:2:end-1,1:2:end-1,1));
        pcolor(x_gd,z_gd, W(:,:,1));
        shading flat;
        colorbar;
        title(['Vx: ',num2str((it)*dt),'s']);
%         caxis([-1e-5 1e-5])
        pause(0.1);
    end
    
    
end












