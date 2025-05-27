% -------------------------------------------------------------------------
% 2D grid generation for CGFD2D
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 27, 2025
% -------------------------------------------------------------------------
%%%%%%
% inputs:
% x_grid : computational grid locations in x dimension --> 1D vector
% z_grid : computational grid locations in z dimension --> 1D vector
%
% topo : free surface topography [Default: flat layer] --> 1D vector


clc;clear;close all;



% 0 Cartesian Grid
% 1 Cartesian Grid with finer grid in free surface
% 2 Curvilinear Grid
Flag_grid = 2;

if Flag_grid == 0
    % Code for Cartesian Grid
    nz=50;
    nx=100;
    length_z=100;
    length_x=200; % length of x: 200m

    topo = 100 + zeros(1, nx); % topography flat 100m

    % computational grid
    x_gd = linspace(1,length_x,nx); % 100 points
    z_gd = linspace(1,length_z,nz);

    % physical grid
    x_gdp = linspace(0,length_x,nx);
    z_gdp = topo - linspace(0,length_z,nz);

    [X, Z] = meshgrid(x_gdp, z_gdp);

    figure;
    plot(X, Z, 'k')           % plot vertical lines
    hold on
    plot(X', Z', 'k')         % plot horizontal lines
    axis equal tight
    xlabel('X (m)');
    ylabel('Z (m)');
    title('Cartesian Grid');


elseif Flag_grid == 1
    % Code for Cartesian Grid with finer grid in free surface

elseif Flag_grid == 2
    % Grid dimensions
    nz = 50;
    nx = 100;
    length_z = 100;
    length_x = 200;

    % Generate computational grid
    x_grid = linspace(0, length_x, nx);    % horizontal positions
    z_grid = linspace(0, length_z, nz);    % depth levels

    % Parameters for the Gaussian hill
    A = 30;                                         % Peak height (in meters)
    x0 = mean(x_grid);                              % Hill center
    sigma = (max(x_grid) - min(x_grid)) / 10;       % Width

    % Generate Gaussian topography (elevation at each x)
    topo = A * exp(-((x_grid - x0).^2) / (2 * sigma^2));

    topo_bottom =  0.* topo - length_z;

    % Create curvilinear grid
    [X, ] = meshgrid(x_grid, z_grid);   % X: horizontal

    
    Z(1,1:nx) = topo;
    for j = 2:nz
        for i = 1:nx
            Z(j, i) =  Z(j-1,i) - (topo(i)-topo_bottom(i))/nz ;  % shift vertically
        end
    end

    % Plot  grid
    figure;
    plot(X, Z, 'k')           
    hold on
    plot(X', Z', 'k')      
    axis equal tight
    xlabel('X (m)');
    ylabel('Z (m)');
    title('Curvilinear Grid');


elseif Flag_grid == 3
    % Code for Curvilinear Grid with finer grid in free surface
else
    error('Error: wrong grid type');
end



