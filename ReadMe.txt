******************************************************************************
            ISD-SB: Iterative Support Detection based Split Bregman (version 1)
******************************************************************************
Copyright (C) 2014 Liangtian He, Yilun Wang

1). Get Started
===================

  Before running the code, users have to make sure that all folders are in the MATLAB working paths (add paths mannually). Then, Run the demo code: Demo_inpainting

2). Introduction
====================
  ISDSB refers to Iterative Support Detection based Split Bregman and is a wavelet frame
based image inpainting package. 

  ISDSB aims at solving the ill-possed inverse problem: approximately 
recover image ubar from

                   f = A*ubar + omega,                              (1)

where ubar is an original image, A is a projection matrix, omega 
is addtive Gassian noise and f is the missed and noised observation of ubar. 

      
3). Usage
====================
  ISDSB is called in the following way:

               [rimg,Out] = ISDSBframe_Inpainting(img,cimg,P,opts)
where 

     img   -- original clean image,
     cimg  -- a missed and noised observation,
     P     -- the projection matrix/mask,
     opts  -- a structure with some fields,
     rimg  -- recovered image,
     Out   -- a structure containing some outputs of first stage

% opts -- a structure containing algorithm parameters {default}
     * opst.frame:   Piecewise Linear Framelet {1} 
     * opst.Level:   Framelet decomposition level {4}
     * opts.tol:     Stoppoing tolerence {5e-4} 
     * opts.maxIt:   Maximum outer stage number {3}
     * opts.mait:    Maximum inner iteration number {50}
     * opts.mu:      a positive constant in range (0.005,0.1) {0.02}
     * opts.lambda:  a positive constant in range (0.1,5.0) {1.0}

We point out that the parameters in this code should be manually tuned to 
achieve the pleased performance; In addition, In the M-file ISDSBframe_Inpainting(img,cimg,P,opts),the usage of computeM(itr,m,n,rimg,img,W,opts) is the
implementation of ISD-SB method in the paper, the usage of M-file: compute_jointlevel_M(itr,m,n,rimg,W) is the implementation of JLISD-SB method in the paper.


4). References
====================
[1], B. Dong and Y. Zhang, ¡°An efficient algorithm for L0 minimization
in wavelet frame based image restoration,¡± J. Sci. Comput., vol. 54,
nos. 2¨C3, pp. 350¨C368, 2013.

[2], L. He, and Y. Wang.,"Iterative Support Detection-Based Split 
% Bregman Method for Wavelet Frame-Based Image Inpainting", IEEE Trans. on
% Image Processing, vol. 23, no. 12, pp. 5470-5485, Dec. 2014.

5). Contact Information
=======================
Please feel free to e-mail the following authors with any comments 
or suggestions:

Liangtian He, Depart. Math., UESTC Univ.,  <liangtian.he@qq.com>
Yilun.wang, Depart. Math., UESTC Univ.,  <yilun.wang@gmail.com>

6).  Copyright Notice
====================  
 ISDSB is free software; you can redistribute it and/or modify it under 
the terms of the GNU General Public License as published by the Free 
Software Foundation; either version 3 of the License, or (at your option) 
any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details at
<http://www.gnu.org/licenses/>. 





  

