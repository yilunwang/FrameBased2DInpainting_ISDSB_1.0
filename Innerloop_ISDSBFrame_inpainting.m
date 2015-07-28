function u = Innerloop_ISDSBFrame_inpainting(u,img,f,P,opts) ;
%%%%%%%%%% Load the opts parameters and new Weights %%%%%%%%%%%%%%%%%%
Level = opts.Level ;
frame = opts.frame ;
tol = opts.tol ;
maxit = opts.maxit ;
lambda = opts.lambda ;
mu = opts.mu ;
gamma = opts.gamma ;
M = opts.M ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[D,R]=GenerateFrameletFilter(frame);nD=length(D);
W  = @(x) FraDecMultiLevel(x,D,Level); % Frame decomposition
WT = @(x) FraRecMultiLevel(x,R,Level); % Frame reconstruction
% muLevel=getwThresh(2*lambda/mu,wLevel,Level,D);
FT = @(x)fft2(x);
IFT = @(x)ifft2(x);
normg=norm(f,'fro');normW=cellnorm(W(f));

%initialization
u = opts.rimg ;% warm-startting ;
b=W(u);
d = b ;

for nstep=1:maxit
    
    %%%%%%%%% solve u subproblem %%%%%%%%%%%%%%%%
    uprev = u ;
    C=CoeffOper('-',d,b);
    u=(mu*WT(C)+P.*f+gamma*u)./(P.^2+(mu+gamma));
    u(u>255)=255; u(u<0)=0;

    %%%%%%%%% solve d subproblem %%%%%%%%%%%%%%%%
    C=W(u);
    Cpb=CoeffOper('+',C,b);
%   d=CoeffOper('l0',Cpb,muLevel);
    d=DALHT_ISD(Cpb,d,lambda,mu,gamma,M,frame);
   
    %%%%%%%%% update b subproblem %%%%%%%%%%%%%%%
    deltab=CoeffOper('-',C,d);
    b=CoeffOper('+',b,deltab);
 
    % Check the STOPPING CRETERION 
    error1 = norm(u-uprev,'fro')/norm(u,'fro') ;
    error2 = norm(P.*u-f,'fro')/norm(f,'fro');
    
 disp(['error on step ' num2str(nstep) ' is ' num2str(error1) ', SSIM is ' num2str(ssim_index(u,img)),', and SNR is ' num2str(snr(u,img))]);

    if min(error1,error2) < tol 
         break;
    end
end

% function muLevel=getwThresh(mu,wLevel,Level,D)
% nfilter=1;
% nD=length(D);
% if wLevel<=0
%     for ki=1:Level
%         for ji=1:nD-1
%             for jj=1:nD-1
%                 muLevel{ki}{ji,jj}=mu*nfilter*norm(D{ji})*norm(D{jj});
%             end
%         end
%         nfilter=nfilter*norm(D{1});
%     end
% else
%     for ki=1:Level
%         for ji=1:nD-1
%             for jj=1:nD-1
%                 if ji==1 && jj==1
%                     muLevel{ki}{ji,jj}=0;
%                 else
%                     muLevel{ki}{ji,jj}=mu*nfilter;
%                 end
%             end
%         end
%         %         muLevel{ki}{1,2}=0;muLevel{ki}{2,1}=0;
%         %         muLevel{ki}{2,2}=0;
%         %muLevel{ki}{2,3}=0;muLevel{ki}{3,2}=0;
%         %muLevel{ki}{3,3}=0;
%         nfilter=nfilter*wLevel;
%     end
% end