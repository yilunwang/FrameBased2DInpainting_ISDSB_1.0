function  M = compute_jointlevel_M(itr,m,n,u,W)

   C = W(u);
   Level=length(C);
   [nD,nD1]=size(C{1});

   
   for ki=1:Level 
    for ji=1:nD
        for jj=1:nD    
            M{ki}{ji,jj} = ones(m,n);
        end
    end
   end
  
    for ji=1:nD
        for jj=1:nD    
            T{ji,jj} = ones(m,n);
        end
    end

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for ji=1:nD
        for jj=1:nD    
           D{ji,jj} = C{1}{ji,jj}.^2 + C{2}{ji,jj}.^2 + C{3}{ji,jj}.^2 + C{4}{ji,jj}.^2 ;
        end
    end
    Vec = [D{1,1}(:),D{1,2}(:),D{1,3}(:),D{2,1}(:),D{2,2}(:),D{2,3}(:),D{3,1}(:),D{3,2}(:),D{3,3}(:)] ;
    Vec = Vec(:) ;
    
    threshold = max(max(abs(Vec))) ;
  
   
    for ji=1:nD
        for jj=1:nD    
         logical{ji,jj} = D{ji,jj} >= threshold/11^(itr+1) ; 
         T{ji,jj}( logical{ji,jj}) = 0 ;    
        end
    end
    
for ki=1:Level 
    for ji=1:nD
        for jj=1:nD    
            M{ki}{ji,jj} = T{ji,jj};
        end
    end
end
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    