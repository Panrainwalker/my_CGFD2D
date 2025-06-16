% -------------------------------------------------------------------------
% Prepare for the free surface condition in cartesian gird
%
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: Jun 7, 2025
% -------------------------------------------------------------------------
%%%%%%


W(nk2,:,4) = 0; % free surface Tzz =0

for n = 0 : half_fd_stentil-1
    W(nk2+1+n,:,4) = -W(nk2-1-n,:,4);  % traction imaging Tzz(n-i) = -T(n+i);
end

%-- v-zero at ghost
W(nk2+1:nz,:,1:2) = 0.0; 