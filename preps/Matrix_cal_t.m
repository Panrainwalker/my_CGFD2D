% -------------------------------------------------------------------------
% Matrix calculation g for CGFD2D
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: Jun 4, 2025
%
% Note: 
% -------------------------------------------------------------------------
%%%%%%
% outputs:
% x_xi : partial derivative of x with respect to ξ (xi)  --> 2D vector [nz,nx]
% z_xi : partial derivative of z with respect to ξ (xi)  --> 2D vector [nz,nx]
% x_zt : partial derivative of x with respect to ζ (zt)  --> 2D vector [nz,nx]
% z_zt : partial derivative of z with respect to ζ (zt)  --> 2D vector [nz,nx]

% xi_x : partial derivative of xi with respect to x  --> 2D vector [nz-3, nx-6]
% zt_x : partial derivative of zt with respect to x  --> 2D vector [nz-3, nx-6]
% xi_z : partial derivative of xi with respect to z  --> 2D vector [nz-3, nx-6]
% zt_z : partial derivative of zt with respect to z  --> 2D vector [nz-3, nx-6]
% jac  : Jacobian matirx 


x_xi = zeros(nz,nx);
x_zt = zeros(nz,nx);
z_xi = zeros(nz,nx);
z_zt = zeros(nz,nx);

Jac = zeros(nz,nx);
xi_x = zeros(nz,nx);
xi_z = zeros(nz,nx);
zt_x = zeros(nz,nx);
zt_z = zeros(nz,nx);
%% 
% x_xi calculation
for i = 4:size(x_gd,1)-3 %nz
    for j= 4:size(x_gd,2)-3 %nx
        x_xi(i,j) = (mac_center_all_coef(Stencil_flag,:)*x_gd(i,j-3:j+3)')/(xi_gd(2)-xi_gd(1));
    end
end

% z_xi calculation
for i = 4:size(x_gd,1)-3 %nz
    for j= 4:size(x_gd,2)-3 %nx
        z_xi(i,j) = (mac_center_all_coef(Stencil_flag,:)*z_gd(i,j-3:j+3)')/(zt_gd(2)-zt_gd(1));
    end
end

% x_zt calculation
for i = 4:size(x_gd,1)-3 %nz
    for j= 4:size(x_gd,2)-3 %nx
        x_zt(i,j) = (mac_center_all_coef(Stencil_flag,:)*x_gd(i-3:i+3,j))/(xi_gd(2)-xi_gd(1));
    end
end

% z_zt calculation
for i = 4:size(x_gd,1)-3 %nz
    for j= 4:size(x_gd,2)-3 %nx
        z_zt(i,j) = (mac_center_all_coef(Stencil_flag,:)*z_gd(i-3:i+3,j))/(zt_gd(2)-zt_gd(1));
    end
end

% Jac calculation
Jac(4:end-3,4:end-3) = x_xi(4:end-3,4:end-3).*z_zt(4:end-3,4:end-3) - x_zt(4:end-3,4:end-3).*z_xi(4:end-3,4:end-3);

xi_x(4:end-3,4:end-3) = (1./Jac(4:end-3,4:end-3)) .* z_zt(4:end-3,4:end-3);
xi_z(4:end-3,4:end-3) = -(1./Jac(4:end-3,4:end-3)) .* x_zt(4:end-3,4:end-3);
zt_x(4:end-3,4:end-3) = -(1./Jac(4:end-3,4:end-3)) .* z_xi(4:end-3,4:end-3);
zt_z(4:end-3,4:end-3) = (1./Jac(4:end-3,4:end-3)) .* x_xi(4:end-3,4:end-3);

if Matrix_disp==1
    figure;
    pcolor(x_gd, z_gd, Jac);
    shading flat;
    axis equal tight
    xlabel('x index');
    ylabel('z index');
    title('Matrix for Jac');
end

