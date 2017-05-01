
%Se resuelve el sistema de ecuaciones y se obtienen los datos necesarios
%para posteriores cálculos



function [L_total,L,sum_gammas,gammas_estela,gammas_paneles,u_inst,w_inst,gammas_paneles_ant]=solverANDpostprocessor(A,RHS,rho,iteracion,gammas_estela,...
    tangentes,U_y_uw,long_paneles,sum_gammas,L_total,dt,coord_vor,posiciones_estela_global,x_oo,z_oo,theta_inst,u_inst,w_inst,u_inf,...
    gammas_paneles_ant,gammas_paneles,alphad)

matriz_giro=[cos(theta_inst) (-1)*sin(theta_inst);sin(theta_inst) cos(theta_inst)];%matriz de giro entre sistemas coordenados


n_paneles=numel(RHS)-1;
delta_presiones=zeros(n_paneles,1);
L=zeros(n_paneles,1);


  
gammas_paneles_ant=gammas_paneles;

gammas=A\RHS;

sum_gammas_anterior=sum_gammas;
sum_gammas=sum(gammas)-gammas(n_paneles+1);
dsumgammas_dt=(sum_gammas-sum_gammas_anterior)/dt;

gammas_estela(iteracion,1)=gammas(n_paneles+1);
gammas_paneles=gammas(1:n_paneles);

coord_local_estela=global_a_local(posiciones_estela_global,x_oo,z_oo,theta_inst);


if iteracion==1
    
    %coord_local_estela=global_a_local(posiciones_estela_global,x_oo,z_oo,theta_inst);
    for k=1:n_paneles
        
        x_c=coord_vor(k,1);
        z_c=coord_vor(k,2);
        
        
        %gammas_paneles
        %coord_vor
        %gammas_estela
        %coord_local_estela
        %u_inf
        
        [u,w]=v_total(x_c,z_c,u_inf,gammas_paneles,coord_vor,gammas_estela,coord_local_estela,iteracion);
        u1=(matriz_giro*(u_inf'))';
        u_inst(k,1)=u+u_inf(1);%OK
        w_inst(k,1)=w+u_inf(2);%OK
        
    end
    
elseif iteracion>1
    
    u_ant=u_inst;
    w_ant=w_inst;
    

    for k=1:n_paneles
        
        x_c=coord_vor(k,1);
        z_c=coord_vor(k,2);
        [u,w]=v_total(x_c,z_c,u_inf,gammas_paneles,coord_vor,gammas_estela,coord_local_estela,iteracion);
        u1=(matriz_giro*(u_inf'))';
        u_inst(k,1)=u+u1(1);%OK
        w_inst(k,1)=w+u1(2);%OK
        dgammas_dt=sum(gammas_paneles(1:k)-gammas_paneles_ant(1:k))/dt;
        
        %est=rho*u_ant(k,1)*gammas_paneles_ant(k,1)
        %tran=rho*long_paneles(k,1)*cosd(alphad)*dsumgammas_dt
        %rho
        %u_ant(k,1)
        %gammas_paneles_ant(k,1)
        %long_paneles(k,1)
        %cosd(alphad)
        %dsumgammas_dt
        
        

        
%         L(k,1)=rho*u_ant(k,1)*gammas_paneles_ant(k,1)+rho*long_paneles(k,1)*cosd(alphad)*dgammas_dt;%%si le restamos lo transitorio sale mas o menos
        
         delta_presiones(k,1)=rho*(([u_ant(k,1),w_ant(k,1)])*tangentes(k,:)')*(gammas_paneles_ant(k,1)/long_paneles(k,1))+dgammas_dt;
         L(k,1)=delta_presiones(k,1)*long_paneles(k,1)*tangentes(k,1);



% % %ORIGINAL
% %          delta_presiones(k,1)=rho*(([u_inst(k,1),w_inst(k,1)])*tangentes(k,:)')*(gammas(k,1)/long_paneles(k,1))+dsumgammas_dt;
% %          L(k,1)=delta_presiones(k,1)*long_paneles(k,1)*tangentes(k,1);
% %         
        
        
        
        
    end
    L_total(iteracion-1,1)=sum(L);
    
end





% for i=1:n_paneles
%     
%      delta_presiones(i,1)=rho*((U_y_uw(i,:)*tangentes(i,:)')*(gammas(i,1)/long_paneles(i,1))+dsumgammas_dt);
%     L(i,1)=delta_presiones(i,1)*long_paneles(i,1)*tangentes(i,1); %POSIBLE FUENTE DE ERROR: que realmente no haya que multiplicar por
%     %tangentes. No estoy 100% seguro de que cos(alpha) sea realmente esa
%     %componente, pero según veo en el libro si que lo es.
%     
%     
%        
%     
% 
% 
% end





end