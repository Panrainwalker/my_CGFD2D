% -------------------------------------------------------------------------
% 2D media for CGFD2D
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
% topo : free surface topography [Default: flat layer] --> 1D vector

% outputs:
% nt : number of time step  --> 1D vector
% dt : length of time step  --> 1D vector

% Vs  : S wave velocity (km/s)  --> 2D array
% Vp  : P wave velocity (km/s)  --> 2D array
% rho : desity  (kg/m^3)  --> 2D array

% mu  : shear modulus       --> 2D array
% lam : Lamé parameter      --> 2D array
% lam2mu : λ + 2μ           --> 2D array

%%
% 1 Half-space model Grid
% 2 Two-layer model
% Flag_media = 21;

Vp  = ones(nz,nx);
Vs  = ones(nz,nx);
rho = ones(nz,nx);

if Flag_media == 1
    disp('Half-space model');
    Vp(:,:)  = 2000;
    Vs(:,:)  = 1000;
    rho(:,:) = 1200;
    
    
    
elseif Flag_media == 2
    disp('Two-layer model');
    depth_threshold = 300;
    transition_width = 5;
    
    mask_deep = z_gd > (depth_threshold + transition_width/2);
    mask_shallow = z_gd < (depth_threshold - transition_width/2);
    mask_transition = ~mask_deep & ~mask_shallow;
    
    Vp_deep = 2000; Vs_deep = 1000; rho_deep = 1200;
    
    Vp_shallow = 3000; Vs_shallow = 1500; rho_shallow = 1800;
    
    
    Vp(mask_deep) = Vp_deep;
    Vs(mask_deep) = Vs_deep;
    rho(mask_deep) = rho_deep;
    
    Vp(mask_shallow) = Vp_shallow;
    Vs(mask_shallow) = Vs_shallow;
    rho(mask_shallow) = rho_shallow;
    
    
    depth = z_gd(mask_transition);
    alpha = (depth - (depth_threshold - transition_width/2)) / transition_width;
    
    % Apply geometric average
    Vp(mask_transition) = exp( log(Vp_shallow).*(1 - alpha) + log(Vp_deep).*alpha );
    Vs(mask_transition) = exp( log(Vs_shallow).*(1 - alpha) + log(Vs_deep).*alpha );
    rho(mask_transition) = exp( log(rho_shallow).*(1 - alpha) + log(rho_deep).*alpha );
    
    
end


if Media_disp==1
    figure;
    pcolor(x_gd, z_gd, Vs);
    shading flat;
    axis equal tight;
    xlabel('x (m)');
    ylabel('z (m)');
    title('Vs');
end
%% CFL condition
rrho = 1./rho;
Vp_max = max(max(Vp));
Vp_min = min(min(Vp));
Vs_max = max(max(Vs));
Vs_min = min(min(Vs));

CFL=0.8
dt = (CFL * dh / Vp_max) ;
% dt = 1e-6 ;
nt = round(T_total/dt) + 1;

disp(['Vp_min=',num2str(Vp_min),'; Vp_max=',num2str(Vp_max)]);
disp(['Vs_min=',num2str(Vs_min),'; Vs_max=',num2str(Vs_max)]);
disp(['dt=',num2str(dt),'; nt=',num2str(nt)]);



%-- model derived info
%-- Vp^2 = (lam + 2 mu) / rho
%-- Vs^2 = mu / rho
mu  = Vs.^2 .* rho;
lam = Vp.^2 .* rho - 2.0 * mu;

lam2mu = zeros(nz,nx);
lam2mu = lam + 2.0*mu;