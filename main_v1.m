% -------------------------------------------------------------------------
% 2D Elastic Wave Simulation in an Isotropic Medium
% This script simulates elastic wave propagation using a collocated-grid 
% finite-difference method in a 2D isotropic medium. 
% Note: Curvilinear grid implementation is not included in this version.
%
% Author: Yuxing Pan (panyx2023@mail.sustech.edu.cn)
% Affiliation: Southern University of Science and Technology (SUSTech)
% Date: May 16, 2025
% -------------------------------------------------------------------------
clc;clear;close all;

%% parameters (Stencil, grid, media, source)
%%%%% Time %%%%%
T_total = 0.1;     % unit (s)

%%%%% Figure %%%%%
Grid_disp = 0;
Matrix_disp = 0;
Media_disp = 0;
Src_disp = 0;
%%%%% Stencil %%%%%
Stencil_flag = 3; % for matrix 



%%%%% grid %%%%%
% 1 Cartesian Grid
% 2 Curvilinear Grid
Flag_grid = 1;

%%%%% media %%%%%
% 1 Half-space model Grid
% 2 Two-layer model
Flag_media = 1;

%%%%% source %%%%%
src_ix = 50; % source index
src_iz = 20; 

src_t_end=0.05;
fc = 100 ; %Hz
t0 = 0.01  ; %s


%% Stencil 
Stencil_t;

%% Grid generation
Grid_init_t;

%% Metric calculation
Matrix_cal;

%% Media initial
Media_init_t;


%% Source initial
Src_init_t;


%% solver
sv_rk_curv_col_allstage;












