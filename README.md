# CGFD2D (MATLAB Version)

This repository contains a MATLAB implementation of the **Collocated-grid Finite-Difference (CGFD)** method for 2D elastic wave propagation simulation in isotropic media.

This implementation is based on the numerical frameworks developed by Prof. Wei Zhang and his collaborators. The code is being developed as part of my independent effort to learn, implement, and understand seismic wave modeling.

> ⚠️ Note: This version does **not** implement curvilinear grids.

---

## 🧠 Overview

This package simulates elastic wave propagation in 2D media using a collocated-grid finite-difference approach. It is suitable for educational and research purposes, especially for learning seismic wave numerical modeling.

For more advanced 3D versions with curvilinear grids and full features, please refer to the official CGFD3D repository by Prof. Wei Zhang:  
👉 [https://github.com/zw-sustech/CGFD3D](https://github.com/zw-sustech/CGFD3D)

If you use or modify this code in your own research, please cite the following foundational papers:


If you use this code in your research, please **cite the following references**:
```plaintext
@article{Zhang2006,
author={W. Zhang and X.f. Chen},
year=2006,
title={Traction image method for irregular free surface boundaries in finite
difference seismic wave simulation},
journal={Geophysical Journal International},
volume=167, pages={337-353}
}

@article{Zhang2010,
author={W. Zhang and Y. Shen},
year=2010,
title={Unsplit complex frequency-shifted PML implementation using auxiliary
differential equations for seismic wave modeling},
journal={Geophysics},
volume={75}, number={4}, pages={T141-T154}
}

@article{Zhang_Zhang_Chen_2012,
author={Zhang, Wei and Zhang, Zhenguo and Chen, Xiaofei},
title={Three-dimensional elastic wave numerical modelling in the presence of
surface topography by a collocated-grid finite-difference method on curvilinear grids},
journal={Geophysical Journal International},
year={2012}, volume={190}, number={1}, pages={358–378}
}

@article{Jiang_Zhang_2024,
author={Jiang, Luqian and Zhang, Wei},
title={Efficient implementation of equivalent medium parametrization in finite-difference
seismic wave simulation methods},
journal={Geophysical Journal International},
year={2024}, volume={239}, number={1}, pages={675–693}
}
```
