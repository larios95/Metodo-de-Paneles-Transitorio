
theta_inst=0;
coord_global=[1 1];
x_oo=2;
z_oo=2;

matriz_giro=[cos(theta_inst) sin(theta_inst);-sin(theta_inst) cos(theta_inst)];

coord_local=(matriz_giro\(coord_global'-[x_oo; z_oo]))'

