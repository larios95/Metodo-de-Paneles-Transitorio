%Version mejorada V2


function [u,w]=VOR2D(gammas,x_c,z_c,x_o,z_o)

%x_c y z_c coordenadas del punto donde queremos hallar la velocidad
%inducida.(Collocation Point)
%x_o y z_o coordenadas del punto donde se encuentra el elemento, es
%decir el v�rtice elemental.

%r=sqrt((x_c-x_o)^2+(z_c-z_o)^2);

rx=x_c-x_o;
rz=z_c-z_o;
r=sqrt(rx.^2+rz.^2);

velocity=0.5./pi.*gammas./r;
%velocity=(gamma/(2*pi*r^2))*[0 1;-1 0]*[x_c-x_o;z_c-z_o];


u=velocity.*(rz./r);
w=velocity.*(-rx./r);

%u=velocity(1,1);
%w=velocity(2,1);


%u=(gamma/(2*pi*r))*(z_p-z_o);
%w=(gamma/(2*pi*r))*(x_p-x_o);

self_indices=find(r<=0.001); %Self-induced velocity eliminated
u(self_indices)=0;
w(self_indices)=0;


u=sum(u);
w=sum(w);

end