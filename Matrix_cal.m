% -------------------------------------------------------------------------
% Matrix calculation g for CGFD2D
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 30, 2025
%
% Note: 
% -------------------------------------------------------------------------
%%%%%%
% inputs:
% x_gd : Physical grid  --> 2D vector
% z_gd : Physical grid  --> 2D vector

% xi_gd : computational grid  --> 2D vector
% zt_gd : computational grid  --> 2D vector

% mac_center_all_coef : Stencil 

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

%% 
% x_xi calculation
for i = 4:size(x_gd,1)-6 %nz
    for j= 4:size(x_gd,2)-6 %nx
        x_xi(i-3,j-3) = mac_center_all_coef(Stencil_flag,1)*x_gd(i,j-3)+...
            mac_center_all_coef(Stencil_flag,2)*x_gd(i,j-2)+...
            mac_center_all_coef(Stencil_flag,3)*x_gd(i,j-1)+...
            mac_center_all_coef(Stencil_flag,4)*x_gd(i,j-0)+...
            mac_center_all_coef(Stencil_flag,5)*x_gd(i,j+1)+...
            mac_center_all_coef(Stencil_flag,6)*x_gd(i,j+2)+...
            mac_center_all_coef(Stencil_flag,7)*x_gd(i,j+3);
    end
end

% z_xi calculation
for i = 4:size(x_gd,1)-6 %nz
    for j= 4:size(x_gd,2)-6 %nx
        z_xi(i-3,j-3) = mac_center_all_coef(Stencil_flag,1)*z_gd(i,j-3)+...
            mac_center_all_coef(Stencil_flag,2)*z_gd(i,j-2)+...
            mac_center_all_coef(Stencil_flag,3)*z_gd(i,j-1)+...
            mac_center_all_coef(Stencil_flag,4)*z_gd(i,j-0)+...
            mac_center_all_coef(Stencil_flag,5)*z_gd(i,j+1)+...
            mac_center_all_coef(Stencil_flag,6)*z_gd(i,j+2)+...
            mac_center_all_coef(Stencil_flag,7)*z_gd(i,j+3);
    end
end

% x_zt calculation
for i = 4:size(x_gd,1)-6 %nz
    for j= 4:size(x_gd,2)-6 %nx
        x_zt(i-3,j-3) = mac_center_all_coef(Stencil_flag,1)*x_gd(i-3,j)+...
            mac_center_all_coef(Stencil_flag,2)*x_gd(i-2,j)+...
            mac_center_all_coef(Stencil_flag,3)*x_gd(i-1,j)+...
            mac_center_all_coef(Stencil_flag,4)*x_gd(i-0,j)+...
            mac_center_all_coef(Stencil_flag,5)*x_gd(i+1,j)+...
            mac_center_all_coef(Stencil_flag,6)*x_gd(i+2,j)+...
            mac_center_all_coef(Stencil_flag,7)*x_gd(i+3,j);
    end
end

% z_zt calculation
for i = 4:size(x_gd,1)-6 %nz
    for j= 4:size(x_gd,2)-6 %nx
        z_zt(i-3,j-3) = mac_center_all_coef(Stencil_flag,1)*z_gd(i-3,j)+...
            mac_center_all_coef(Stencil_flag,2)*z_gd(i-2,j)+...
            mac_center_all_coef(Stencil_flag,3)*z_gd(i-1,j)+...
            mac_center_all_coef(Stencil_flag,4)*z_gd(i-0,j)+...
            mac_center_all_coef(Stencil_flag,5)*z_gd(i+1,j)+...
            mac_center_all_coef(Stencil_flag,6)*z_gd(i+2,j)+...
            mac_center_all_coef(Stencil_flag,7)*z_gd(i+3,j);
    end
end

% Jac calculation
Jac = x_xi.*z_zt - x_zt.*z_xi;

xi_x = (1./Jac) .* z_zt;
xi_z = -(1./Jac) .* x_zt;
zt_x = -(1./Jac) .* z_xi;
zt_z = (1./Jac) .* x_xi;

if Matrix_disp==1
    figure;
    imagesc(Jac)
    axis equal tight
    xlabel('x index');
    ylabel('z index');
    title('Matrix for Jac');
end

if Matrix_disp==1
    figure;
    imagesc(xi_z)
    axis equal tight
    xlabel('x index');
    ylabel('z index');
    title('Matrix for xi_z');
end














