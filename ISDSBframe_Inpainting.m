function [rimg,Out] = ISDSBframe_Inpainting(img,cimg,P,opts)
%-----Initial weights setting (All weights are set as 1,i.e., the implementation of split bregman method)-----%
[m,n] = size(img) ; frame = opts.frame ; Level = opts.Level ;
[D,R]=GenerateFrameletFilter(frame);nD=length(D);
W  = @(x) FraDecMultiLevel(x,D,Level); % Frame decomposition
WT = @(x) FraRecMultiLevel(x,R,Level); % Frame reconstruction
for ki=1:Level 
    for ji=1:nD-1
        for jj=1:nD-1    
            M{ki}{ji,jj} = ones(m,n);
        end
    end
end
maxIt = opts.maxIt ;  rimg = zeros(m,n) ;
%% Main Outer loop

for itr = 1:maxIt
    
    opts.M = M ;
    opts.rimg = rimg ; % warm-startting ;
    
    % =================================
    % Implementation of the inner loop
    % ================================= 
    
    rimg = Innerloop_ISDSBFrame_inpainting(rimg,img,cimg,P,opts) ;
     
    % ==================================================================================
    % Record the first stage result of (JL)ISDSB method (i.e., the output of SB method )
    % ==================================================================================   
    if itr==1
         Out.rimg1 = rimg ; 
         Out.snr1 = snr(rimg,img) ;
         Out.ssim1 = ssim_index(rimg,img) ;
    end
    
    % ==========================================================
    % Update the weights based on the currently recovered result
    % ==========================================================  
       M = computeM(itr,m,n,rimg,img,W,opts); % the implementation of ISD-SB
%      M = compute_jointlevel_M(itr,m,n,rimg,W); % the implementation of JLISD-SB 
end










