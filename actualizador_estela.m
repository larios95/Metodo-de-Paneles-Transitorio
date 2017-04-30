

%CUIDADO: mirar donde debemos meter la posicion del nuevo vortice
%vortice, que no se si es en iteracion o (iteracion +/- 1)



function [posiciones_estela_global]=actualizador_estela(iteracion,posiciones_estela_global,posiciones_local,x_oo,z_oo,theta_inst,pos_paneles,coord_vor,coord_control,normales,dt,gammas_paneles,u_inf,gammas_estela)
%n_posiciones=numel(posiciones_local)/2; %lo mismo en algún momento ya se podría quitar y dejarlo como variable en la subrutina principal(contador igual en funcion actualiza_tray..)
n_paneles=numel(coord_vor)/2;
n_vortices_estela=numel(posiciones_estela_global)/2;
velocidades_estela_global=zeros(n_vortices_estela,2);
matriz_giro=inv([cos(theta_inst) (-1)*sin(theta_inst);sin(theta_inst) cos(theta_inst)]);%matriz de giro entre sistemas coordenados






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se calcula la velocidad en los puntos donde estan los vortices de la
%estela
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[coord_local_estela]=global_a_local(posiciones_estela_global,x_oo,z_oo,theta_inst);
    
for i=1:iteracion %recorremos el vector que contiene a todos los vortices desprendidos. Solo obviamente hasta el ultimo vortice desprendido,
    %ya que las demas componentes serán nulas
    
   
    x_c=coord_local_estela(i,1);
    z_c=coord_local_estela(i,2);
    
    
    [u,w] = v_total(x_c,z_c,u_inf,gammas_paneles,coord_vor,gammas_estela,coord_local_estela,iteracion);
    velocidad_local=[u w];
    velocidad_global=(matriz_giro*(velocidad_local'))';
    u=velocidad_global(1);
    w=velocidad_global(2);
    
    velocidades_estela_global(i,:)=[u,w];
    
            
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se actualiza posición de los vortices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




end

posiciones_estela_global=posiciones_estela_global+dt*velocidades_estela_global;

end