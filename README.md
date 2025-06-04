# CGFD2D (Learning Version) — 2D Finite Difference Solver for Elastic Waves

This repository contains 2D finite-difference solvers developed for learning and research purposes. It is inspired by the 3D collocated-grid finite-difference method (CGFD3D) and adapted to Cartesian and curvilinear coordinate systems for seismic wave simulation.

## 📚 Purpose

The code is developed and maintained for learning and exploring numerical methods for seismic wave modeling. It includes several finite-difference schemes and serves as a simplified educational version of the CGFD3D method.

##  Main Features

- **2D elastic wave simulation** in isotropic media.
- Support for **Cartesian and curvilinear grids**.
- Multiple spatial schemes: 2nd-order central difference, explicit filtering, and MacCormack scheme.
- Runge-Kutta time integration.

##  Main Programs

- `main_cart_center.m`:  
  Central difference scheme on Cartesian grid (may suffer from odd-even decoupling).

- `main_cart_filter.m`:  
  Uses explicit filtering to improve solution quality.

- `main_cart_mac.m`:  
  Uses MacCormack scheme on Cartesian grid.

- `main_curv_mac.m`:  
  MacCormack scheme in curvilinear coordinates (if available).

##  Directory Structure

Essential scripts:
- `Add_source.m`, `fun_ricker.m`: Source term setup.
- `Media_init_t.m`, `Grid_init_t.m`, `Src_init_t.m`, `Stencil_t.m`: Model initialization.
- `cal_macF.m`, `cal_macB.m`, `cal_center.m`, `ass_rhs.m`: Numerical scheme operations.
- `sv_ctl_rk_cart_allstage.m`, `sv_mac_rk_cart_allstage.m`: Time stepping via RK4.

##  Usage

Run any of the main scripts in MATLAB:
```matlab
>> main_cart_mac
```

##  Citations

If you use or adapt this code in your work, please cite the following references:
```bibtex
@article{Zhang2006,
  author={W. Zhang and X.f. Chen},
  year=2006,
  title={Traction image method for irregular free surface boundaries in finite
         difference seismic wave simulation},
  journal={Geophysical Journal International},
  volume=167, pages={337–353}
}

@article{Zhang2010,
  author={W. Zhang and Y. Shen},
  year=2010,
  title={Unsplit complex frequency-shifted PML implementation using auxiliary
         differential equations for seismic wave modeling},
  journal={Geophysics},
  volume={75}, number={4}, pages={T141–T154}
}

@article{Zhang_Zhang_Chen_2012,
  author={Zhang, Wei and Zhang, Zhenguo and Chen, Xiaofei},
  title={Three-dimensional elastic wave numerical modelling in the presence of
         surface topography by a collocated-grid finite-difference method on curvilinear grids},
  journal={Geophysical Journal International},
  year={2012}, volume={190}, number={1}, pages={358–378}
}

@article{Jiang_Zhang_2021,
  author={Jiang, Luqian and Zhang, Wei},
  title={TTI equivalent medium parametrization method for the seismic waveform modelling
         of heterogeneous media with coarse grids},
  journal={Geophysical Journal International},
  year={2021}, volume={227}, number={3}, pages={2016–2043}
}
```
