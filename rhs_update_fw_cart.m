% -------------------------------------------------------------------------
% update for right hand side (rhs) derivatives; forward
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




%% inner point (RHS)
% RHS derivatives
% assemble rhs

Vx=W(:,:,1);
Vz=W(:,:,2);
Txx=W(:,:,3);
Tzz=W(:,:,4);
Txz=W(:,:,5);

% Vx derivatives (Vx,xi ; Vx,zt)
% Vx_xi(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Vx(4:end-3,3:end-4)...
%     +mac_all_coef{4}{1}(2).*Vx(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Vx(4:end-3,5:end-2)...
%     +mac_all_coef{4}{1}(4).*Vx(4:end-3,6:end-1)...
%     +mac_all_coef{4}{1}(5).*Vx(4:end-3,7:end))  /   (xi_gd(2)-xi_gd(1))  ;
% Vx_zt(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Vx(3:end-4,4:end-3)...
%     +mac_all_coef{4}{1}(2).*Vx(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Vx(5:end-2,4:end-3)...
%     +mac_all_coef{4}{1}(4).*Vx(6:end-1,4:end-3)...
%     +mac_all_coef{4}{1}(5).*Vx(7:end  ,4:end-3))  /   abs(zt_gd(2)-zt_gd(1))  ;
% 
% % Vz derivatives (Vz,xi ; Vz,zt)
% Vz_xi(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Vz(4:end-3,3:end-4)...
%     +mac_all_coef{4}{1}(2).*Vz(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Vz(4:end-3,5:end-2)...
%     +mac_all_coef{4}{1}(4).*Vz(4:end-3,6:end-1)...
%     +mac_all_coef{4}{1}(5).*Vz(4:end-3,7:end  ))  /   (xi_gd(2)-xi_gd(1))  ;
% Vz_zt(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Vz(3:end-4,4:end-3)...
%     +mac_all_coef{4}{1}(2).*Vz(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Vz(5:end-2,4:end-3)...
%     +mac_all_coef{4}{1}(4).*Vz(6:end-1,4:end-3)...
%     +mac_all_coef{4}{1}(5).*Vz(7:end,4:end-3  ))  /   abs(zt_gd(2)-zt_gd(1))  ;
% 
% % Txx derivatives
% Txx_xi(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Txx(4:end-3,3:end-4)...
%     +mac_all_coef{4}{1}(2).*Txx(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Txx(4:end-3,5:end-2)...
%     +mac_all_coef{4}{1}(4).*Txx(4:end-3,6:end-1)...
%     +mac_all_coef{4}{1}(5).*Txx(4:end-3,7:end  ))  /   (xi_gd(2)-xi_gd(1))  ;
% Txx_zt(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Txx(3:end-4,4:end-3)...
%     +mac_all_coef{4}{1}(2).*Txx(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Txx(5:end-2,4:end-3)...
%     +mac_all_coef{4}{1}(4).*Txx(6:end-1,4:end-3)...
%     +mac_all_coef{4}{1}(5).*Txx(7:end  ,4:end-3))  /   abs(zt_gd(2)-zt_gd(1))  ;
% 
% % Tzz derivatives
% Tzz_xi(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Tzz(4:end-3,3:end-4)...
%     +mac_all_coef{4}{1}(2).*Tzz(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Tzz(4:end-3,5:end-2)...
%     +mac_all_coef{4}{1}(4).*Tzz(4:end-3,6:end-1)...
%     +mac_all_coef{4}{1}(5).*Tzz(4:end-3,7:end  ))  /   (xi_gd(2)-xi_gd(1))  ;
% Tzz_zt(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Tzz(3:end-4,4:end-3)...
%     +mac_all_coef{4}{1}(2).*Tzz(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Tzz(5:end-2,4:end-3)...
%     +mac_all_coef{4}{1}(4).*Tzz(6:end-1,4:end-3)...
%     +mac_all_coef{4}{1}(5).*Tzz(7:end  ,4:end-3))  /   abs(zt_gd(2)-zt_gd(1))  ;
% 
% % Txz derivatives
% Txz_xi(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Txz(4:end-3,3:end-4)...
%     +mac_all_coef{4}{1}(2).*Txz(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Txz(4:end-3,5:end-2)...
%     +mac_all_coef{4}{1}(4).*Txz(4:end-3,6:end-1)...
%     +mac_all_coef{4}{1}(5).*Txz(4:end-3,7:end  ))  /   (xi_gd(2)-xi_gd(1))  ;
% Txz_zt(4:end-3,4:end-3) = (mac_all_coef{4}{1}(1).*Txz(3:end-4,4:end-3)...
%     +mac_all_coef{4}{1}(2).*Txz(4:end-3,4:end-3)...
%     +mac_all_coef{4}{1}(3).*Txz(5:end-2,4:end-3)...
%     +mac_all_coef{4}{1}(4).*Txz(6:end-1,4:end-3)...
%     +mac_all_coef{4}{1}(5).*Txz(7:end  ,4:end-3))  /   abs(zt_gd(2)-zt_gd(1))  ;


Vx_xi(4:end-3,4:end-3) = (Vx(4:end-3,4:end-3)-Vx(4:end-3,5:end-2))/ (xi_gd(2)-xi_gd(1))  ;
Vx_zt(4:end-3,4:end-3) = (Vx(4:end-3,4:end-3)-Vx(5:end-2,4:end-3))/  abs(zt_gd(2)-zt_gd(1))  ;

% Vz derivatives (Vz,xi ; Vz,zt)
Vz_xi(4:end-3,4:end-3) = (Vz(4:end-3,4:end-3)-Vz(4:end-3,5:end-2))/ (xi_gd(2)-xi_gd(1))  ;
Vz_zt(4:end-3,4:end-3) = (Vz(4:end-3,4:end-3)-Vz(5:end-2,4:end-3))/  abs(zt_gd(2)-zt_gd(1))  ;

% Txx derivatives
Txx_xi(4:end-3,4:end-3) = (Txx(4:end-3,4:end-3)-Txx(4:end-3,5:end-2))/ (xi_gd(2)-xi_gd(1))  ;
Txx_zt(4:end-3,4:end-3) = (Txx(4:end-3,4:end-3)-Txx(5:end-2,4:end-3))/  abs(zt_gd(2)-zt_gd(1))  ;

% Tzz derivatives
Tzz_xi(4:end-3,4:end-3) = (Tzz(4:end-3,4:end-3)-Tzz(4:end-3,5:end-2))/ (xi_gd(2)-xi_gd(1))  ;
Tzz_zt(4:end-3,4:end-3) = (Tzz(4:end-3,4:end-3)-Tzz(5:end-2,4:end-3))/  abs(zt_gd(2)-zt_gd(1))  ;

% Txz derivatives
Txz_xi(4:end-3,4:end-3) = (Txz(4:end-3,4:end-3)-Txz(4:end-3,5:end-2))/ (xi_gd(2)-xi_gd(1))  ;
Txz_zt(4:end-3,4:end-3) = (Txz(4:end-3,4:end-3)-Txz(5:end-2,4:end-3))/  abs(zt_gd(2)-zt_gd(1))  ;



% for moment equation
Vx_t = (1./rho).*(Txx_xi + Txx_zt + Txz_xi + Txz_zt);
Vz_t = (1./rho).*(Txz_xi + Txz_zt + Tzz_xi + Tzz_zt);


% for Hooke's equatoinTzz_xi
Txx_t = lam2mu.*(Vx_xi) + lam2mu.*(Vx_zt)...
    +lam.*Vz_xi + lam.*Vz_zt    ;
Tzz_t = lam.*(Vx_xi) + lam.*(Vx_zt)...
    +lam2mu.*Vz_xi + lam2mu.*Vz_zt    ;
Txz_t = mu.*(Vx_xi + Vz_xi) + mu.*(Vx_zt + Vz_zt)  ;

% assemble rhs
W = cat(3, Vx, Vz, Txx, Tzz, Txz);

% assemble time derivative rhs
tdW = cat(3, Vx_t, Vz_t, Txx_t, Tzz_t, Txz_t);