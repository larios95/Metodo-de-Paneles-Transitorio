clear all
clc

x_c=2;
z_c=7;
u_inf=[1,5];Uinf=u_inf;
gammas_paneles=[0.2655 .3333 0.45665 5.6351 0.1]';vortices_g=gammas_paneles';
coord_vor=[1 1;2 1; 3 3;4 0;85 6];
vortices_x=coord_vor(:,1)';
vortices_z=coord_vor(:,2)';
gammas_estela=[1 2 3 6 55 ]';wake_g=gammas_estela';
coord_local_estela=[1 1;2 5;44 5;23 6;45 0];
wake_x=coord_local_estela(:,1)';
wake_z=coord_local_estela(:,2)';
iteracion=5;
limit_vortices_wake=5;



[u1,w1] = v_total(x_c,z_c,u_inf,gammas_paneles,coord_vor,gammas_estela,coord_local_estela,iteracion)



[u2,w2] = VFIELD(x_c,z_c,Uinf,vortices_g,vortices_x,vortices_z,wake_g,wake_x,wake_z,limit_vortices_wake)