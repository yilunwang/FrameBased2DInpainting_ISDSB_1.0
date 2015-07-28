function c=DALHT_ISD(alpha,beta,lambda,mu,gamma,M,frame)
Level=length(alpha);lambda0=lambda;
[nD,nD1]=size(alpha{1});c=alpha;
for ki=1:Level
    for ji=1:nD
        for jj=1:nD
alpha{ki}{ji,jj} = mu/(mu+gamma)*alpha{ki}{ji,jj} ; 
beta{ki}{ji,jj} = gamma/(mu+gamma)*beta{ki}{ji,jj} ; 
        end
    end
end

for ki = 1:Level 
    switch frame
        case 0 ; 
            V{ki} = sqrt((M{ki}{1,2}.*(alpha{ki}{1,2}+beta{ki}{1,2})).^2+(M{ki}{2,1}.*(alpha{ki}{2,1}+beta{ki}{2,1})).^2+(M{ki}{2,2}.*(alpha{ki}{2,2}+beta{ki}{2,2})).^2);
            V{ki}(V{ki}==0) = 1;
        case 1 ;
            V{ki} = sqrt((M{ki}{1,2}.*(alpha{ki}{1,2}+beta{ki}{1,2})).^2+(M{ki}{1,3}.*(alpha{ki}{1,3}+beta{ki}{1,3})).^2+(M{ki}{2,1}.*(alpha{ki}{2,1}+beta{ki}{2,1})).^2+(M{ki}{2,2}.*(alpha{ki}{2,2}+beta{ki}{2,2})).^2+(M{ki}{2,3}.*(alpha{ki}{2,3}+beta{ki}{2,3})).^2+(M{ki}{3,1}.*(alpha{ki}{3,1}+beta{ki}{3,1})).^2+(M{ki}{3,2}.*(alpha{ki}{3,2}+beta{ki}{3,2})).^2+(M{ki}{3,3}.*(alpha{ki}{3,3}+beta{ki}{3,3})).^2);
            V{ki}(V{ki}==0) = 1;        
        case 3 ;
            V{ki} = sqrt((M{ki}{1,2}.*(alpha{ki}{1,2}+beta{ki}{1,2})).^2+(M{ki}{1,3}.*(alpha{ki}{1,3}+beta{ki}{1,3})).^2+(M{ki}{1,4}.*(alpha{ki}{1,4}+beta{ki}{1,4})).^2+(M{ki}{1,5}.*(alpha{ki}{1,5}+beta{ki}{1,5})).^2+(M{ki}{2,1}.*(alpha{ki}{2,1}+beta{ki}{2,1})).^2+(M{ki}{2,2}.*(alpha{ki}{2,2}+beta{ki}{2,2})).^2+(M{ki}{2,3}.*(alpha{ki}{2,3}+beta{ki}{2,3})).^2+(M{ki}{2,4}.*(alpha{ki}{2,4}+beta{ki}{2,4})).^2+(M{ki}{2,5}.*(alpha{ki}{2,5}+beta{ki}{2,5})).^2+(M{ki}{3,1}.*(alpha{ki}{3,1}+beta{ki}{3,1})).^2+(M{ki}{3,2}.*(alpha{ki}{3,2}+beta{ki}{3,2})).^2+(M{ki}{3,3}.*(alpha{ki}{3,3}+beta{ki}{3,3})).^2+(M{ki}{3,4}.*(alpha{ki}{3,4}+beta{ki}{3,4})).^2+(M{ki}{3,5}.*(alpha{ki}{3,5}+beta{ki}{3,5})).^2+(M{ki}{4,1}.*(alpha{ki}{4,1}+beta{ki}{4,1})).^2+(M{ki}{4,2}.*(alpha{ki}{4,2}+beta{ki}{4,2})).^2+(M{ki}{4,3}.*(alpha{ki}{4,3}+beta{ki}{4,3})).^2+(M{ki}{4,4}.*(alpha{ki}{4,4}+beta{ki}{4,4})).^2+(M{ki}{4,5}.*(alpha{ki}{4,5}+beta{ki}{4,5})).^2+(M{ki}{5,1}.*(alpha{ki}{5,1}+beta{ki}{5,1})).^2+(M{ki}{5,2}.*(alpha{ki}{5,2}+beta{ki}{5,2})).^2+(M{ki}{5,3}.*(alpha{ki}{5,3}+beta{ki}{5,3})).^2+(M{ki}{5,4}.*(alpha{ki}{5,4}+beta{ki}{5,4})).^2+(M{ki}{5,5}.*(alpha{ki}{5,5}+beta{ki}{5,5})).^2);
            V{ki}(V{ki}==0) = 1;
        otherwise ; error('we have not yet use this wavelet frame') ;  
    end
end


for ki=1:Level
    for ji=1:nD
        for jj=1:nD
            if (ji~=1 || jj~=1)
                lambda=lambda0*(0.25)^(ki-1); 
                c{ki}{ji,jj} = max(V{ki}-M{ki}{ji,jj}.*(lambda)/(mu+gamma),0)./V{ki};                               
                c{ki}{ji,jj} =  c{ki}{ji,jj}.*(alpha{ki}{ji,jj}+beta{ki}{ji,jj}) ;                
           else  
                  c{ki}{ji,jj}=alpha{ki}{ji,jj}+beta{ki}{ji,jj};
            end
        end
    end
end

