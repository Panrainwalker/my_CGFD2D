% -------------------------------------------------------------------------
% solver of acoustic using cartesian grid
% all stage forward calculation for right hand side (rhs)
%
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 31, 2025
% -------------------------------------------------------------------------
%%%%%%

%% predefine
it = 0;

hWz = zeros(nz,nx,3); % rhs : [Vx_z Vz_z P_z]
hWx = zeros(nz,nx,3); % rhs : [Vx_x Vz_x P_x]
hW = zeros(nz,nx,3);  % rhs : [Vx_t Vz_t P_t]
W = zeros(nz,nx,3);   % rhs : [Vx Vz P]
tW = zeros(nz,nx,3);   % middle variance
mW = zeros(nz,nx,3);   % middle variance


while 1

    it = it + 1
    if it > nt
        break
    end
    mW = W;

    % Stage 1
    W = mW;
    apply_abs_ac
    % prep_free_cart;

    % for inner point
    cal_macF
    % for free surface
    % apply_free_srf_cart
    ass_rhs_cart_ac;

    Add_source;
    k1 = hW;


    % Stage 2
    W = mW + RK4a(2) * k1;
    apply_abs_ac
    %prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    %apply_free_srf_cart
    ass_rhs_cart_ac;
    Add_source;
    k2 = hW;


    % Stage 3
    W = mW + RK4a(3) * k2;
    apply_abs_ac
    %prep_free_cart;
    % for inner point
    cal_macF
    % for free surface
    %apply_free_srf_cart
    ass_rhs_cart_ac;
    Add_source;

    k3 = hW;



    % Stage 4
    W = mW + RK4a(4) * k3;
    apply_abs_ac
    %prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    %apply_free_srf_cart
    ass_rhs_cart_ac;
    Add_source;

    k4 = hW;


    % Final RK4 combination
    W = mW + RK4b(1) * k1 + RK4b(2) * k2 + RK4b(3) * k3 + RK4b(4) * k4;
    apply_abs_ac

    Vxr(it) = W(staz  ,stax,1);
    Vzr(it) = W(staz  ,stax,2);

    it = it + 1
    if it > nt
        break
    end
    mW = W;


    % Stage 1
    W = mW;
    apply_abs_ac
    %prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    %apply_free_srf_cart
    ass_rhs_cart_ac;

    % for free surface

    Add_source;
    k1 = hW;


    % Stage 2
    W = mW + RK4a(2) * k1;
    apply_abs_ac
    %prep_free_cart;
    % for inner point
    cal_macF
    % for free surface
    %apply_free_srf_cart
    ass_rhs_cart_ac;
    Add_source;

    k2 = hW;


    % Stage 3
    W = mW + RK4a(3) * k2;
    apply_abs_ac
    %prep_free_cart;
    % for inner point
    cal_macB
    % for free surface
    %apply_free_srf_cart
    ass_rhs_cart_ac;
    Add_source;

    k3 = hW;


    % Stage 4
    W = mW + RK4a(4) * k3;
    apply_abs_ac
    %prep_free_cart;
    % for inner point
    cal_macF
    % for free surface
    %apply_free_srf_cart
    ass_rhs_cart_ac;
    Add_source;

    k4 = hW;


    % Final RK4 combination
    W = mW + RK4b(1) * k1 + RK4b(2) * k2 + RK4b(3) * k3 + RK4b(4) * k4;
    apply_abs_ac


    Vxr(it) = W(staz  ,stax,1);
    Vzr(it) = W(staz  ,stax,2);


    if flag_snap == 1 && mod(it, 10) == 0
        %% ------------------ 绘图部分 ------------------
        figure(99); clf;  % 避免创建多个 figure
        pcolor(x_gd, z_gd, W(:,:,1));
        shading interp;
        colorbar;
        set(gca, 'YDir', 'reverse');
        title(['Vx: ', num2str(it * dt), ' s']);
        % caxis([-1e0 1e0]);
        axis equal;
        hold on;

        plot(x_gd(1, stax), z_gd(staz, 1), 'kp', 'MarkerSize', 10, 'MarkerFaceColor', 'y');


        legend({'Wavefield', 'Station', 'Source'}, 'Location', 'southoutside');
        hold off;
        drawnow;

    end
end
