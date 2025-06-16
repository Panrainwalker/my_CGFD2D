# CGFD2D (Learning Version) — 2D Finite Difference Solver for Elastic Waves

This repository contains 2D finite-difference solvers developed for learning and research purposes. 

## 📚 Purpose

The code is developed and maintained for learning and exploring numerical methods for seismic wave modeling. It includes several finite-difference schemes and serves as a simplified educational version of the CGFD3D method.


## Project Structure
.
├── addpaths.m    # Add all subdirectories to MATLAB path
├── boundarys     # Boundary condition implementations
├── diffs         # Finite difference stencil and operators
├── main_cart.m   # Main script for cartesian grid
├── main_curv.m   # Main script for curvilinear grid
├── preps         # Model, grid, and source initialization
├── README.md  
└── solvers       # Time integration and RHS solvers


##  Main Programs

| Script         | Description                        |
|----------------|------------------------------------|
| `main_cart.m`  | FD modeling on a Cartesian grid     |
| `main_curv.m`  | FD modeling on a curvilinear grid   |

Run either in MATLAB:

```matlab
>> main_cart
>> main_curv
```

##  Numerical Methods

- **MacCormack Scheme (MAC)**  

- **Operator Splitting (OS)**  

- **Central Difference Scheme (CTL)**  

- **Explicit Filtering (FLT)**  

**Time Integration**:  
All solvers use **classic 4th-order Runge-Kutta**. 


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
