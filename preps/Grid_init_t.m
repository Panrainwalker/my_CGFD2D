% -------------------------------------------------------------------------
% 2D grid generation for CGFD2D
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 27, 2025
% -------------------------------------------------------------------------
%%%%%%
% inputs:
% nz : grid number in x dimension --> single number
% nx : grid number in z dimension --> single number
% length_x : length in x dimension --> single number
% length_z : length in x dimension --> single number
% topo : free surface topography [Default: flat layer] --> 1D vector


% outputs:
% x_gd : Physical grid  --> 2D vector
% z_gd : Physical grid  --> 2D vector

% xi_gd : computational grid  --> 2D vector
% zt_gd : computational grid  --> 2D vector

% dh : minimum distance  --> 2D vector

%%
% 1 Cartesian Grid
% 2 Curvilinear Grid
% Flag_grid = 21;

if Flag_grid == 1
    % Code for Cartesian Grid

    % computational grid
    xi_gd = linspace(0,length_x,nx); % 100 points
    zt_gd = -linspace(-length_z,0,nz);
    
    
    [x_gd, z_gd] = meshgrid(xi_gd, zt_gd);
    if Grid_disp==1
        figure;
        plot(x_gd, z_gd, 'k')           % plot vertical lines
        hold on
        plot(x_gd', z_gd', 'k')         % plot horizontal lines
        axis equal tight
        xlabel('X (m)');
        ylabel('Z (m)');
        title('Cartesian Grid');
    end
    
elseif Flag_grid == 2

    
    % Generate computational grid
    xi_gd = linspace(0,length_x,nx);
    zt_gd = -linspace(-length_z,0,nz);
    
    % Parameters for the Gaussian hill
    A = 30;                                         % Peak height (in meters)
    x0 = mean(xi_gd);                              % Hill center
    sigma = (max(xi_gd) - min(xi_gd)) / 10;       % Width
    
    % Generate Gaussian topography (elevation at each x)
    topo = A * exp(-((xi_gd - x0).^2) / (2 * sigma^2));
    
    topo_bottom =  0.* topo - length_z;
    
    % Create curvilinear grid
    [x_gd, ] = meshgrid(xi_gd, zt_gd);   % X: horizontal
    
    
    z_gd(1+3,1:nx) = topo; % add 3 is because z-direction ghost point for Matrix calculation
    for j = 2 + 3:nz
        for i = 1:nx
            z_gd(j, i) =  z_gd(j-1,i) - (topo(i)-topo_bottom(i))/(nz-3) ;  % shift vertically
        end
    end
    
    % calculate image traction point
    for j = 1:3
        for i = 1:nx
            z_gd(j, i) =  2*z_gd(4,i) - z_gd(8-j,i) ;  % shift vertically
        end
    end
    
    if Grid_disp==1
        figure;
        plot(x_gd(1:5:end,1:5:end), z_gd(1:5:end,1:5:end), 'k')           % plot vertical lines
        hold on
        plot(x_gd(1:5:end,1:5:end)', z_gd(1:5:end,1:5:end)', 'k')         % plot horizontal lines
        axis equal tight
        xlabel('X (m)');
        ylabel('Z (m)');
        title('Curvilinear Grid (Physics)');
    end
    
    if Grid_disp==1
        figure;
        hold on
        
        % Plot vertical lines (along Z)
        for i = 1:nx
            plot(x_gd(1:5:end,i), z_gd(1:5:end,i), 'k');  % black
        end
        
        % Plot horizontal lines (along X)
        for j = 1:nz
            if j <= half_fd_stentil  % Top  horizontal layers
                plot(x_gd(j,1:5:end), z_gd(j,1:5:end), 'r', 'LineWidth', 1.5);  % red
            else
                plot(x_gd(j,1:5:end), z_gd(j,1:5:end), 'k');  % black
            end
        end
        
        axis equal tight
        xlabel('X (m)');
        ylabel('Z (m)');
        title('Curvilinear Grid (Top 3 Layers and Columns in Red)');
    end
    
elseif Flag_grid == 3
    % Code for Curvilinear Grid with finer grid in free surface
else
    for loop=1:4
        disp('Error: wrong grid type');
    end
    error('Error: wrong grid type');
end

%% minimun distance
d_diag1 = sqrt( (x_gd(2:end,2:end) - x_gd(1:end-1,1:end-1)).^2 + ...
    (z_gd(2:end,2:end) - z_gd(1:end-1,1:end-1)).^2 );
d_diag2 = sqrt( (x_gd(2:end,1:end-1) - x_gd(1:end-1,2:end)).^2 + ...
    (z_gd(2:end,1:end-1) - z_gd(1:end-1,2:end)).^2 );

d_diag = min(d_diag1, d_diag2);
dh = min(min(d_diag))/2;
dx=dh;dz=dh;

x_center = 0.5 * (x_gd(2:end,2:end) + x_gd(1:end-1,1:end-1));
z_center = 0.5 * (z_gd(2:end,2:end) + z_gd(1:end-1,1:end-1));


if Grid_disp==1
    figure;
    pcolor(x_center, z_center, d_diag);
    shading interp;  %
    axis equal tight;
    xlabel('x (m)');
    ylabel('z (m)');
    title('Minimun distance');
end