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
T_total = 0.5;     % unit (s)

%%%%% Figure %%%%%
Grid_disp = 0;
Matrix_disp = 0;
Media_disp = 1;
%%%%% Stencil %%%%%
Stencil_flag = 3;


%%%%% grid %%%%%
% 1 Cartesian Grid
% 2 Curvilinear Grid
Flag_grid = 2;

%%%%% media %%%%%
% 1 Half-space model Grid
% 2 Two-layer model
Flag_media = 1;

%%%%% source %%%%%


%% Stencil 
Stencil_t;

%% Grid generation
Grid_init_t;

%% Metric calculation
Matrix_cal;

%% Media initial
Media_init_t;










