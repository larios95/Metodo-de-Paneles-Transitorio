
%MUY IMPORTANTE: VAMOS A NECESITAR COMO ENTRADA YA ESTELA ACTUALIZADA, ES
%DECIR, QUE DEBERIAMOS HABER EJECUTADO AL MENOS UNA VEZ CREO
%actualizador_estela. 
%SISI DEFINITIVAMENTE, vamos a tener que haberlo
%ejecutado porque sino es imposible obtener los terminos de la columna de
%la derecha del todo de la matriz A. Debemos saber para ellas pues, el
%valor de la posicion del vortice desprendido. 
%NOTA FINAL: la posicion del
%ultimo vortice desprendido al final se saca de actualizador_trayectoria


function [A,RHS,U_y_uw]=CreadorMatricesANDRHS(coord_vor,coord_control,normales,u_inf,sum_gammas,iteracion,posiciones_estela_global,theta_inst,theta_dot,x_oo,z_oo,posiciones_local,dposiciones_dt,gammas_estela)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Cálculo Matriz de coeficientes de influencia A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%i=contador de collocation points
%j=contador de vortex points

n_paneles=(numel(coord_vor))/2;%numero de paneles
A=ones(n_paneles+1);%aparecen las columna y fila extra para el ultimo vortice de la estela
%con el ones ya tendremos posteriormente todos los 1 correspondientes a la
%fila del último vórtice de la estela
RHS=zeros(n_paneles+1,1);
U_y_uw=zeros(n_paneles,2);
u1=zeros(1,2);
u2=zeros(1,2);
matriz_giro=[cos(theta_inst) (-1)*sin(theta_inst);sin(theta_inst) cos(theta_inst)];%matriz de giro entre sistemas coordenados

for i=1:n_paneles
    
    normal=normales(i,:);
    x_c=coord_control(i,1);
    z_c=coord_control(i,2);
    
    for j=1:n_paneles
        
        
        x_o=coord_vor(j,1);
        z_o=coord_vor(j,2);
        
        [u,w]=VOR2D(1,x_c,z_c,x_o,z_o);
        
        a=[u,w]*(normal');
        
        A(i,j)=a;
        
        
    end
    
    
    %Ultima columna. Debido a último vortice desprendido.
    
    
    
    x_o=posiciones_estela_global(iteracion,1); %Asegurarse que es esta componente del vector la que hay que tomar o (iteracion-1)
    z_o=posiciones_estela_global(iteracion,2);
    
    vector(1)=x_o;vector(2)=z_o;
    [vector]=global_a_local(vector,x_oo,z_oo,theta_inst);
    x_o=vector(1);
    z_o=vector(2);
    
    [u,w]=VOR2D(1,x_c,z_c,x_o,z_o);
    
    a=[u,w]*(normal');
    
    A(i,n_paneles+1)=a;
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calculo del vector de terminos independientes RHS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    %RHS(i,1)=-u_inf*normal';
    
    u1=(matriz_giro*(-u_inf'))'+[-theta_dot*coord_control(i,2), theta_dot*coord_control(i,1)-dposiciones_dt(i,1)];
    %componente de la velocidad cinemática en el punto. La tenemos que
    %girar para que se vea en coordenadas locales y no globales, ya que
    %para A y RHS siempre trabajamos en locales!!!!!!
    
    
    %Falta la correspondiente a la estela que se calcula
    %posteriormente
    
    if (iteracion)>1 %si hay vórtices en la estela diferentes al último desprendido. Es decir si ha habido instantes de tiempo anteriores
        
        u2=zeros(1,2);
        for k=1:(iteracion-1) %solo recorremos los vórtices antes desprendidos
            
            x_o=posiciones_estela_global(k,1);
            z_o=posiciones_estela_global(k,2);
            
            vector(1)=x_o;vector(2)=z_o;
            [vector]=global_a_local(vector,x_oo,z_oo,theta_inst);
            x_o=vector(1);
            z_o=vector(2);
            
            %[u,w]=VOR2D(1,x_c,z_c,x_o,z_o);
            [u,w]=VOR2D(gammas_estela(k),x_c,z_c,x_o,z_o);
            
            u2=u2+[u, -w];
            
            
        end
        
    end
    
    u1_norm=u1*normal';
    u2_norm=u2*normal';
    
    RHS(i,1)=(u1+u2)*normal';
    U_y_uw(i,:)=(u1+u2);%casualmente este término nos será necesario en la funcion solverANDpostprocessor. Nos da la velocidad total en el punto del perfil
    
    
    
    
    
    
    
end




RHS(n_paneles+1,1)=sum_gammas;









end









