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
T_total = 0.6;     % unit (s)

%%%%% grid %%%%%
nz=230 + 6;
nx=230 + 6;
length_z=800;
length_x=800; % length of x: 200m

topo = 0 + zeros(1, nx); % topography

Flag_grid = 1; % 1: Cartesian Grid  /  2: Curvilinear Grid

Grid_disp = 0; 

%%%%% media %%%%%
Flag_media = 1;
Media_disp = 0;

%%%%% source %%%%%
src_ix = 115 + 3; % source index
src_iz = 115 + 3;

T_end = T_total;
fc = 20 ;    %Hz
t0 = 1.2/fc;
Src_disp = 0;


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

%%%%% station %%%%%
stax = 131;
staz = nk2;

%% Grid initial
Grid_init_t

%% Media initial
Media_init_t

CFL=1.5;
dt = ( CFL * dh / Vp_max) ;
% dt = 1e-5 ;
nt = round(T_total/dt) + 1;
%% Source initial
Src_init_t

%% absorbing boundary
damp = ones(nz,nx);
ndamp = 30;
ivec = ni1 : ni1+ndamp-1;
jvec = 1 : ndamp;
%-- z1/z2
for i = ni1 : ni2
    damp(ivec      ,i) = ((exp(-( (0.015*(ndamp-jvec)).^2 ) )).^10)';
    %damp(nk2-ndamp+1:nk2,i) = ((exp(-( (0.015*(jvec      )).^2 ) )).^10)';
end
%-- x1/x2
for k = nk1 : nk2
    damp(k,ivec      ) = min( (exp(-( (0.015*(ndamp-jvec)).^2 ) )).^10, ...
                                 damp(k,ivec) );
    damp(k,ni2-ndamp+1:ni2) = min( (exp(-( (0.015*(jvec      )).^2 ) )).^10, ...
                                 damp(k,ni2-ndamp+1:ni2) );
end
%% solver

RK4a = RK4a .* dt;
RK4b = RK4b .* dt;
% RK6a = RK6a .* dt;
% RK6b = RK6b .* dt;


dx = xi_gd(2);
dz = abs(zt_gd(2));
MACF = MACF / dx;
MACB = MACB / dx;

CLT = CLT /dx;
sigma = (3*dt*Vs_min)/(4*dx); % for filter



flag_snap = 1;
gif_save= 0;
plot_sta = 1;



tic


% 运行 MAC 模型
sv_mac_rk_cart_allstage;
Vzr_mac = Vzr;  % 保存结果

% sv_mac_rk_cart_allstage_noabs;
% Vzr_mac_noasb = Vzr;  % 保存结果


% sv_mac_rk_cart_os_allstage;
% Vzr_os = Vzr;  % 保存结果


% sv_ctl_rk_cart_allstage;
% sv_flt_rk_cart_allstage;






%%
% figure
% plot(Vzr)
if plot_sta ==1

figure
plot(Vzr_mac / max(abs(Vzr_mac)), 'r', 'DisplayName', 'MAC Model');
hold on
% plot(Vzr_mac_noasb / max(abs(Vzr_mac_noasb)), 'k--', 'DisplayName', 'OS Model');
% plot(10*(Vzr_os / max(abs(Vzr_os))-Vzr_mac / max(abs(Vzr_mac)))-1.5, 'b-', 'DisplayName', '10 * diff');

legend;
% ylim([-1, 1]);
xlabel('Time step');
ylabel('Normalized Vzr');
% title('Comparison of MAC and OS scheme');


fig = gcf;
fig.Units = 'inches';
fig.Position = [1, 1, 6, 4];



if ~exist('output', 'dir')
    mkdir('output');
end

cfl_str = strrep(sprintf('%.2f', CFL), '.', '_');


saveas(gcf, fullfile('output', ['compare_mac_os+CFL_', cfl_str, '.png']));
print(gcf, fullfile('output', ['compare_mac_os+CFL_', cfl_str, '.pdf']), '-dpdf', '-r300');
end