% -------------------------------------------------------------------------
% update for right hand side (rhs) derivatives; backward
%
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 31, 2025
% -------------------------------------------------------------------------
%%%%%%

tdW(src_iz,src_ix,1) = tdW(src_iz,src_ix,1) + stf(it)*1;
tdW(src_iz,src_ix,2) = tdW(src_iz,src_ix,2) + stf(it)*1;

% hW(M.izs,M.ixs,3) = hW(M.izs,M.ixs,3) - M.stf(it)*M.mxx;
% hW(M.izs,M.ixs,4) = hW(M.izs,M.ixs,4) - M.stf(it)*M.mzz;
% hW(M.izs,M.ixs,5) = hW(M.izs,M.ixs,5) - M.stf(it)*M.mxz;

