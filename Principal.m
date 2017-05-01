%Subrutina principal

function  [L_total,L_teorica,Cl_total,Cl_teorica,tiempo]=Principal(n_paneles,dt,caso)


%clear all
%clc


%caso=3;
%1=flatplate
%2=semicilinder
%3=suddenaceleration (obviamente de una placa plana)






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SE DEFINEN LAS VARIABLES QUE SERÁN NECESARIAS PARA RESOLVER EL PROBLEMA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Variables comunes;
%n_paneles=(10)*(2);
tiempo_total=20;
alphad=5;%angulo de ataque en grados convencionales
u_inf=1*[cosd(alphad),sind(alphad)];%velocidad aguas arriba ¿¿¿¿¿VARIABLE O NO??????
%dt=(0.05/5)/(1);%Diferencial de tiempo. Calculado despues con Courant_number
%posiciones_global=[];%Posiciones inciales CUIDADOOOOOOOOO:ordenado de tal
%manera que la primera componente sea el borde de ataque y la ultima el
%borde de salida


if caso==1
    [posiciones_global]=flatplate2();
elseif caso==2
    [posiciones_global]=semicilinder();
elseif caso==3
    [posiciones_global]=flatplate2();
end  




posiciones_local=posiciones_global;
delta_x=abs(posiciones_global(1,1)-posiciones_global(numel(posiciones_global)/2,1))/n_paneles; %para numero de Courant
%en el primer instante de tiempo ambos sistemas coordenados coincidiran
%Courant_number=0.5;
%dt=(Courant_number*delta_x)/(norm(u_inf))
n_iteraciones=tiempo_total/dt;
 %AL FINAL DEL TODO. Hacer a esta variable una variable de entrada para todas las funciones. Así ahorraremos muchos calculos innecesarios
dposiciones_dt=zeros(n_paneles,1);%razón de deformación del perfil
posicion_bs_anterior_global=posiciones_global(numel(posiciones_global)/2,:);
posicion_bs_actual_global=posiciones_global(numel(posiciones_global)/2,:);
tiempo=zeros(n_iteraciones,1);
L_total=zeros(n_iteraciones,1);



%Método de Paneles:
u_inst=0;
w_inst=0;
rho=1.225;
x_oo=0;
z_oo=0;
theta_inst=0;

if caso==1%SI QUEREMOS PEFIL EN REGIMEN ESTACIONARIO
    sum_gammas=pi*1*norm(u_inf)*sind(alphad);%vorticidad total del perfil. Suma de cada una de los paneles. SI QUEREMOS CASO ESTACIONARIO
    
elseif caso==2
    sum_gammas=pi*1*norm(u_inf)*(1+alphad*(pi/180));%SI QUEREMOS SEMIARCO DE JOUKOWSKI EN REGIMEN ESTACIONARIO
    
elseif caso==3
    sum_gammas=0;%SI QUEREMOS SUDDEN ACELERATION
    
end


gammas_estela=zeros(n_iteraciones,1);%creo que se le va a poder quitar una componente. COMPROBAR al final del todo.
posiciones_estela_global=zeros(n_iteraciones,2); %creo que se le va a poder quitar una componente. COMPROBAR al final del todo.
gammas_paneles=zeros(n_paneles,1);
gammas_paneles_ant=zeros(n_paneles,1);
u_inst=zeros(n_paneles,1);
w_inst=zeros(n_paneles,1);

%Método de los Elementos finitos
E=100;%Módulo elástico






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%RESOLUCION DEL PROBLEMA NO-ESTACIONARIO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Courant_number=(norm(u_inf)*dt)/delta_x







reg=zeros(n_iteraciones,2);% %COMPROBACION, ELIMINAR AL TERMINAR CODIGO

for iteracion=1:n_iteraciones

tiempo(iteracion)=(iteracion-1)*dt;   
%posiciones_estela_global    
    
[posiciones_estela_global,theta_inst,theta_dot,x_oo,z_oo,posiciones_global]=actualizador_trayectoria(x_oo,z_oo,theta_inst,u_inf,posiciones_global,dt,posiciones_estela_global,iteracion);
 %MIRAR SI FUNCIONA BIEN EN LA PRIMERA ITERACION


[pos_paneles,long_paneles,coord_vor,coord_control,normales,tangentes]=creador_paneles(n_paneles,posiciones_local); %se llama a la función creador_paneles para que los defina en el nuevo instante de tiempo
%CUIDADO1: se deben meter las coordenadas locales del perfil!!!
%CUIDADO2: X debe de ir de 0 a 1, por definicion del perfil en la funcion!


[A,RHS,U_y_uw]=CreadorMatricesANDRHS(coord_vor,coord_control,normales,u_inf,sum_gammas,iteracion,posiciones_estela_global,theta_inst,theta_dot,x_oo,z_oo,posiciones_local,dposiciones_dt,gammas_estela); %se define el sistema de ecuaciones a resolver

[L_total,L,sum_gammas,gammas_estela,gammas_paneles,u_inst,w_inst,gammas_paneles_ant]=solverANDpostprocessor(A,RHS,rho,iteracion,gammas_estela,tangentes,U_y_uw,long_paneles,sum_gammas,L_total,dt,coord_vor,posiciones_estela_global,x_oo,z_oo,theta_inst,u_inst,w_inst,u_inf,gammas_paneles_ant,gammas_paneles,alphad);%Se obtiene la fuerza de sustentación en cada panel

[posiciones_estela_global]=actualizador_estela(iteracion,posiciones_estela_global,posiciones_local,x_oo,z_oo,theta_inst,pos_paneles,coord_vor,coord_control,normales,dt,gammas_paneles,u_inf,gammas_estela);


















%EN EL MEF SE DEBEN RECOLOCAR EL VECTOR DE POSICIONES LOCALES TAL QUE LA
%LINEA QUE UNE EL BORDE DE ATAQUE Y EL BORDE DE SALIDA QUEDE EN EL EJE OX, Y EL PERFIL SIEMPRE DEBE QUEDAR ENTRE X=0 Y X=1, A VER COMO LO HACEMOS.
%Y SE DEBE TAMBIEN ACTUALIZAR EL VECTOR DE POSICIONES GLOBALES, ESTO VA  A
%SER ESENCIAL TAMBIEN








if iteracion==n_iteraciones/2
    
    fprintf('YA VOY POR LA MITAAAD\n')
    
elseif iteracion==2*n_iteraciones/3

    fprintf('YA VOY POR 2/3\n')
    
end






end



Cl_total=L_total/(0.5*rho*norm(u_inf)^2*1);

%plot(tiempo,L_total)
%plot(tiempo,gammas_estela)
%plot(posiciones_estela_global(:,1),posiciones_estela_global(:,2),'*');


%Estudios del Cl


if caso==1 %placa plana regimen estacionario
    Cl_teorica=2*pi*sind(alphad);
    L_teorica=pi*rho*1*norm(u_inf)^2*alphad*(pi/180);%cuerda=1
    ratio=(L_teorica-L_total(n_iteraciones-1))/L_total(n_iteraciones-1);error=ratio*100
    
elseif caso==2 %semicirculo de joukowski estacionario
    Cl_teorica=2*pi*(1+alphad*(pi/180));
    L_teorica=0.5*rho*norm(u_inf)^2*1*Cl_teorica;%cuerda=1
    ratio=(Cl_teorica-Cl_total(numel(Cl_total)-1))/Cl_teorica;error=ratio*100
    
elseif caso==3 %sudden aceleration de placa plana
    L_teorica=zeros(n_iteraciones,1);
    L_teorica(:,1)=2*pi*0.5*rho*norm(u_inf)*(norm(u_inf)*sind(alphad))*(1-0.165*exp(-0.041*(norm(u_inf)*tiempo(:,1)/0.5))-0.335*exp(-0.32*(norm(u_inf)*tiempo(:,1)/0.5)));
    Cl_teorica=2*L_teorica/(rho*1*norm(u_inf)^2)
%     plot(tiempo,L_total)
%     hold on
%     plot(tiempo,L_teorica,'r')
    %hold off  
    ratio=(L_teorica(n_iteraciones-1)-L_total(n_iteraciones-1))/L_total(n_iteraciones-1);error=ratio*100
    
end






if ratio>-3 && ratio<3
    
    fprintf('Panelitus funsioooooooooooonannnnn :)))))) \n')
    
end



end
