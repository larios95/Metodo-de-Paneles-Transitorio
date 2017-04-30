
%los vectores entran y salen como [a | b] (horizontal) y lo debemos trasponer para
%ponerlo en la forma que aquí se trabaja que es como [a; b] (vertical)



function [coord_global]=local_a_global(coord_local,x_oo,z_oo,theta_inst)

matriz_giro=[cos(theta_inst) sin(theta_inst);-sin(theta_inst) cos(theta_inst)];

n_coor_v=numel(coord_local)/2;
vv=zeros(2,n_coor_v);
vv(1,:)=x_oo;
vv(2,:)=z_oo;


coord_global=(matriz_giro*coord_local'+vv)';


end