u_inf=[23.1615 16.6564];




%i=contador de collocation points
%j=contador de vortex points

n=(numel(coord_vor))/2;
A=ones(n);
B=zeros(n);%era para pruebas
RHS=zeros(n,1);
C=zeros(n,1);%era para pruebas


for i=1:n
   
    normal=normales(i,:);
    
    for j=1:n
        
       % if j>i
            
            x_c=coord_control(i,1);
            z_c=coord_control(i,2);
            x_o=coord_vor(j,1);
            z_o=coord_vor(j,2);
            
            [u,w]=VOR2D(1,x_c,z_c,x_o,z_o);
            
            a=[u,w]*(normal');
                     
            A(i,j)=a;  
            
            %  end

    end

    RHS(i,1)=-u_inf*normal';
    
    
end



Gammas=A\RHS;

