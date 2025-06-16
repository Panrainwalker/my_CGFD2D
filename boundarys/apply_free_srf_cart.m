% -------------------------------------------------------------------------
% Apply free surface condition in cartesian gird
%
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: Jun 7, 2025
% -------------------------------------------------------------------------
%%%%%%

% calculate Vx,zt and Vz,z at free surface 
hWz(nk2,ixvec,1) = -hWx(nk2,ixvec,2); % Vx,z = -Vz,x
hWz(nk2,ixvec,2) = (-lam(nk2,ixvec)/lam2mu(nk2,ixvec)).*hWx(nk2,ixvec,1); % Vz,z = -lam/lam2mu Vz,x

% calculate Vx,zt and Vz,z in top 2 layers using lower order scheme



% if mod(kkk, 2) == 1
% hWz(nk2-2:nk2-1,ixvec,1:2) =  (W(nk2-2:nk2-1,ixvec,1:2)-W(nk2-3:nk2-2,ixvec,1:2))/dx;

% hWz(nk2-2:nk2-1,ixvec,1:2) =  (W(nk2-2:nk2-1,ixvec,1:2)-...
%                             4*W(nk2-3:nk2-2,ixvec,1:2)+...
%                               W(nk2-4:nk2-3,ixvec,1:2))./(2*dx);


% end









% hW(nk2,:,4:5) = 0.0; %  Tzz,t = 0; & Txz,t=0;
%
% hW(nk2,:,3) =  lam2mu(nk2,:) .* hWx(nk2,:,1) ...
%              - lam(nk2,:).^2 ./ lam2mu(nk2,:) .*hWx(nk2,:,1);
%
% hW(nk2,:,3) =  lam2mu(nk2,:) .* hWx(nk2,:,1) ...
%              - lam(nk2,:).^2 ./ lam2mu(nk2,:) .*hWx(nk2,:,1);





