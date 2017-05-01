n=100;
n_paneles=n;
x_perfil=posiciones(:,1);
z_perfil=posiciones(:,2);

x_paneles=0:(1/n_paneles):1;

z_paneles=spline(x_perfil,z_perfil,x_paneles); 
z_paneles(1)=0;z_paneles(n_paneles+1)=0;

pos_paneles=[x_paneles; z_paneles]';
long_paneles=zeros(n_paneles,1);

for i=1:n_paneles
    
    long_paneles(i)=sqrt((pos_paneles(i+1,1)-pos_paneles(i,1))^2+(pos_paneles(i+1,2)-pos_paneles(i,2))^2);
    
end




coord_vor=zeros(n,2);
coord_control=zeros(n,2);
T=zeros(1,2);
normales=zeros(n,2);
for i=1:(n)
    
   T=(pos_paneles(i+1,:)-pos_paneles(i,:));
   modulo_T=norm(T);
   t=((pos_paneles(i+1,:)/modulo_T)-(pos_paneles(i,:))/modulo_T);
   normales(i,:)=[t(1,2),t(1,1)];
   coord_vor(i,:)= pos_paneles(i,:)+(1/4)*T; 
   coord_control(i,:)= pos_paneles(i,:)+(3/4)*T;
        
end


