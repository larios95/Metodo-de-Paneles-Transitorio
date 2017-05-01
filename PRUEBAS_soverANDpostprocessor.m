


n_paneles=numel(RHS);

gammas=A\RHS;

L=zeros(n_paneles,1);

for i=1:n_paneles
    
   L(i,1)=rho*norm(u_inf)*gammas(i); 
    
end