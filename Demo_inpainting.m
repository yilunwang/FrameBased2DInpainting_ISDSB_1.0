% =========================================================================
% ISDSB for image denoising, Version 1.0
% Copyright(c) 2014 Liangtian He and Yilun Wang
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.

% This is an implementation of the algorithm for image inpainting
% 
% Please cite the following paper if you use this code:
%--------------------------------------------------------------------------
% Liangtian He, and Yilun Wang.,"Iterative Support Detection-Based Split 
% Bregman Method for Wavelet Frame-Based Image Inpainting", IEEE Trans. on
% Image Processing, vol. 23, no. 12, pp. 5470-5485, Dec. 2014.
%--------------------------------------------------------------------------

% Note: We give a demo in this implementation of version 1.0, we 
% point out that the parameters in this code should be manually tuned to 
% achieve the pleased performance;
% 
clc;
clear;
randn('seed',0);

% Loading the test image
img = double(imread('Cameraman256.bmp'));
img = img(:,:,1) ;
[m,n] = size(img) ;
SampleRate_Levels = [0.3 0.4 0.5 0.6]; 
Sigma_Levels = [5 10] ;

% Corrupting the test image
SampleRate = SampleRate_Levels(1) ;
Sigma = Sigma_Levels(1) ;
%--- # of random subsampling ---
nSamples = round(SampleRate*m*n); % sample rate 30% ;
%--- generate subsample mask ---
picks = randsample(m*n,nSamples);
picks = sort(picks);
pick = false(m,n); pick(picks) = true;
P = ones(m,n); P(pick) = 0 ; % Projection matrix
cimg = P.*img; 
cimg = cimg + Sigma*randn(size(img)) ; % adding GAUSS noise;

% Parameters setting
opts = [];
opts.Level=4;
opts.frame=1;
opts.tol = 5e-4;
opts.maxit = 50; 
opts.maxIt = 3 ; % the maximum stage number
opts.mu = 0.01 ;
opts.lambda = 2.0 ;
opts.gamma = 0;

% Main function
disp('The code is running, Please waiting for a minitue.....')
[rimg,Out] = ISDSBframe_Inpainting(img,cimg,P,opts);
disp('Running finished')
CSNR = snr(cimg,img); CSSIM = ssim_index(cimg,img) ;
RSNR = snr(rimg,img); RSSIM = ssim_index(rimg,img) ;

% Showing the recovered results
figure(1);
imshow(img,[]);title('Orignal image','fontsize',13);  
figure(2);
imshow(cimg,[]); title(sprintf('Corrupted image,SNR: %4.2fdB,SSIM: %4.4f',CSNR,CSSIM),'fontsize',13);
figure(3);
imshow(Out.rimg1,[]); title(sprintf('SB method,SNR: %4.2fdB,SSIM: %4.4f',Out.snr1,Out.ssim1),'fontsize',13);
figure(4);
imshow(rimg,[]); title(sprintf('ISDSB method,SNR: %4.2fdB,SSIM: %4.4f',RSNR,RSSIM),'fontsize',13);






