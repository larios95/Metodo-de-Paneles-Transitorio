function [u,w] = v_total(x_c,z_c,u_inf,gammas_paneles,coord_vor,gammas_estela,coord_local_estela,iteracion)

%Función que proporciona la velocidad del campo fluido en un punto
%(x_c,z,c). La velocidad es la suma de la de la corriente exterior y la
%inducida por los vórtices del propio perfil así como de los de la estela


%x_c y z_c coordenadas del punto donde queremos hallar la velocidad
%inducida.(Collocation Point)


x_vor=coord_vor(:,1);
z_vor=coord_vor(:,2);

x_estela=coord_local_estela(:,1);
z_estela=coord_local_estela(:,2);


u=0;
w=0;

%velocidad inducida por vortices perfil
[uu,ww]=VOR2D(gammas_paneles,x_c,z_c,x_vor,z_vor);
u=u+uu;
w=w+ww;
%velocidad inducida por vortices estela
[uu,ww]=VOR2D(gammas_estela(1:iteracion),x_c,z_c,x_estela(1:iteracion),z_estela(1:iteracion));
u=u+uu;
w=w+ww;

%u=u+u_inf(1,1);
%w=w+u_inf(1,2);



end