clc;clear;close all;

%% parameters (Stencil, grid, media, source)
%%%%% Time %%%%%
T_total = 0.25;     % unit (s)

%%%%% grid %%%%%
nz=200 + 6;
nx=200 + 6;
length_z=200;
length_x=200; % length of x: 200m

topo = 0 + zeros(1, nx); % topography

Flag_grid = 1; % 1: Cartesian Grid  /  2: Curvilinear Grid

Grid_disp = 0; 

%%%%% media %%%%%
Flag_media = 1;
Media_disp = 1;

%%%%% source %%%%%
src_ix = 100 + 3; % source index
src_iz = 100 + 3;

T_end = T_total;
fc = 30 ;    %Hz
t0 = 0.04  ; %s

Src_disp = 1;
%%%%% station %%%%%
stax = 50;
staz = 50;

%%%%%% Stencil %%%%%
Stencil_t;

RK4a = rk_coef{1}{1};
RK4b = rk_coef{1}{2};
RK6a = rk_coef{2}{1};
RK6b = rk_coef{2}{2};

half_fd_stentil = 3;
ni1 = half_fd_stentil+1;
ni2 = nx-half_fd_stentil;
nk1 = half_fd_stentil+1;
nk2 = nz-half_fd_stentil;

izvec = nk1 : nk2;     % interior z
ixvec = ni1 : ni2;     % interior x


MACF = [-0.30874,-0.6326,1.233,-0.3334,0.04168]; % forward
MACB = -MACF(end:-1:1); % backward


%% Grid generation

Grid_init_t

%% Media initial
Media_init_t

%% Source initial
Src_init_t

%% solver
RK4a = RK4a .* dt;
RK4b = RK4b .* dt;
RK6a = RK6a .* dt;
RK6b = RK6b .* dt;
figure
sv_ctl_rk_cart_allstage;
