%n_posiciones=numel(posiciones_local)/2; %lo mismo en algún momento ya se podría quitar y dejarlo como variable en la subrutina principal(contador igual en funcion actualiza_tray..)
n_paneles=numel(coord_vor)/2;
n_vortices_estela=numel(posiciones_estela_global)/2;
velocidades_estela=zeros(n_vortices_estela,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Actualización de la posición de los vórtices antes desprendidos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se calcula la velocidad en los puntos donde estan los vortices de la
%estela

for i=1:iteracion %recorremos el vector que contiene a todos los vortices desprendidos. Solo obviamente hasta el ultimo vortice desprendido,
    %ya que las demas componentes serán nulas
    
	%x_c=posiciones_estela(i,1);
	%z_c=posiciones_estela(i,2);
    x_c=-7.5;z_c=-9.375;
    
    
    for j=1:n_paneles %velocidad inducida debido a los vortices de los paneles
        
            %x_o=coord_vor(j,1);
            %z_o=coord_vor(j,2);
            x_o=0.1025;z_o=0.0308;
            
            [u,w]=VOR2D(1,x_c,z_c,x_o,z_o);
            velocidades_estela(i,:)=[u,w];
        
    end
    
    for k=1:iteracion %velocidad inducida por los vortices de la propia estela. Solo obviamente hasta el ultimo vortice desprendido,
    %ya que las demas componentes serán nulas ya que los vortices aun no
    %existen
        
            %x_o=posiciones_estela(k,1);
            %z_o=posiciones_estela(k,2);      
            x_o=-7.5;z_o=-9.375;

            [u,w]=VOR2D(1,x_c,z_c,x_o,z_o)
            velocidades_estela(i,:)=velocidades_estela(i,:)+[u,w]; %se suma la contribucion de los vortices del perfil            
            
        
    end
    

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Se actualiza posición de los vortices



%posiciones_estela=posiciones_estela+dt*velocidades_estela;






