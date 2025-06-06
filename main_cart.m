% -------------------------------------------------------------------------
% Operator splitting 
%
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: Jun 5, 2025
% -------------------------------------------------------------------------
%%%%%%

clc;clear;close all

%% parameters (Time, Stencil, grid, media, source)
%%%%% Time %%%%%
T_total = 0.15;     % unit (s)

%%%%% grid %%%%%
nz=200 + 6;
nx=200 + 6;
length_z=400;
length_x=400; % length of x: 200m

topo = 0 + zeros(1, nx); % topography

Flag_grid = 1; % 1: Cartesian Grid  /  2: Curvilinear Grid

Grid_disp = 0; 

%%%%% media %%%%%
Flag_media = 1;
Media_disp = 0;

%%%%% source %%%%%
src_ix = 100 + 3; % source index
src_iz = 100 + 3;

T_end = T_total;
fc = 30 ;    %Hz
t0 = 0.04  ; %s

Src_disp = 0;
%%%%% station %%%%%
stax = 101;
staz = 101;

%%%%%% Stencil %%%%%
Stencil_t;

RK4a = rk_coef{1}{1};
RK4b = rk_coef{1}{2};
RK6a = rk_coef{2}{1};
RK6b = rk_coef{2}{2};

half_fd_stentil = 4;
ni1 = half_fd_stentil+1;
ni2 = nx-half_fd_stentil;
nk1 = half_fd_stentil+1;
nk2 = nz-half_fd_stentil;

izvec = nk1 : nk2;     % interior z
ixvec = ni1 : ni2;     % interior x


MACF = [-0.30874,-0.6326,1.233,-0.3334,0.04168]; % forward
MACB = -MACF(end:-1:1); % backward


%% Grid initial
Grid_init_t

%% Media initial
Media_init_t
dt = (0.6 * dh / Vp_max) ;
% dt = 1e-5 ;
nt = round(T_total/dt) + 1;
%% Source initial
Src_init_t


%% solver

RK4a = RK4a .* dt;
RK4b = RK4b .* dt;
RK6a = RK6a .* dt;
RK6b = RK6b .* dt;


dx = xi_gd(2);
dz = abs(zt_gd(2));
MACF = MACF / dx;
MACB = MACB / dx;

CLT = CLT /dx;
sigma = (3*dt*Vp_min)/(4*dx); % for filter
% sigma =2; 

flag_snap = 0;
gif_save= 0;



tic

figure;
hold on;

% 运行 MAC 模型
sv_mac_rk_cart_allstage;
Vzr_mac = Vzr;  % 保存结果
plot(Vzr_mac, 'b', 'DisplayName', 'MAC Model');
% 
% % 运行 OS 模型（结果缩小 1/2）
% sv_mac_rk_cart_os_allstage;
% Vzr_os = Vzr;  % 保存结果
% plot(Vzr_os / 2, 'k-', 'DisplayName', 'OS Model');
% 
% % 运行 CTL 模型
% sv_ctl_rk_cart_allstage;
% Vzr_ctl = Vzr;
% plot(Vzr_ctl, 'r--', 'DisplayName', 'CTL Model');

% 运行 FLT 模型
sv_flt_rk_cart_allstage;
Vzr_flt = Vzr;
plot(Vzr_flt, 'g--', 'DisplayName', 'FLT Model');

% 图像设置
ylim([-90, 90]);
legend show;
xlabel('Time Step');
ylabel('Vz at Station');
title('Vz Comparison Across Models');

t1 = toc;
fprintf('Total computation and plotting time: %.2f seconds\n', t1);

% figure
% plot(Vzr)