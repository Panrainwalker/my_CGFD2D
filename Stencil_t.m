% -------------------------------------------------------------------------
% Stencil for this CGFD2D
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 30, 2025
% -------------------------------------------------------------------------
%%%%%%

% 1 for 2nd order
% 2 for 4nd order
% 3 for 6nd order
%Stencil_flag = 1 / 2 / 3 


mac_center_all_coef = [
    -0.5,       0.0,        0.5,        0,      0,      0,      0;     % 2nd order
    0.08333333, -0.6666666, 0.0,      0.6666666, -0.08333333, 0, 0;   % 4th order
    -0.02084,   0.1667,    -0.7709,     0.0,     0.7709, -0.1667, 0.02084 % 6th order
];
