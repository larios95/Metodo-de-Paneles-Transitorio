
%%%%ENTRADAS
x_oo=-6;
z_oo=-8;
theta_inst=(pi/180)*45;
u_inf=[1,1];
posiciones_global=[-6 -8;-5 -8;-4 -8];
dt=1;
%posiciones_estela=;
%%%%




posicion_bs_anterior_global=posiciones_global(numel(posiciones_global)/2,:);
n_posiciones=numel(posiciones_global)/2; %lo mismo en algún momento ya se podría quitar y dejarlo como variable en la subrutina principal.(contador igual en funcion actualiza_estela..)
ox_perfil=posiciones_global(n_posiciones,:)-posiciones_global(1,:);

theta_ant=theta_inst;


%theta_inst=acos(dot([1,0],ox_perfil)/(1*norm(ox_perfil))); por si OX fijo
%(arrastrado por el tunel) variara

if ox_perfil(1,2)>=0
    
    theta_inst=acos(ox_perfil(1)/norm(ox_perfil));
else
    theta_inst=pi-acos(ox_perfil(1)/norm(ox_perfil));
end

theta_dot=(theta_inst-theta_ant)/dt;


%Para calcular el movimiento 




x_oo=x_oo-u_inf(1,1)*dt;%Asegurarse que este signo esta bien. Mide desde los ejes globales a los del perfil en coordenadas globales
z_oo=z_oo-u_inf(1,2)*dt;



%MOVIMIENTO DEL PERFIL EN EJES GLOBALES

%Hacemos por ahora la chapucilla de trasladar+girar de manera sencilla con
%las velocidades aguas arriba. Hablar con Miguel.

dxYdz=zeros(n_posiciones,2);
dx=-u_inf(1,1)*dt;
dz=-u_inf(1,2)*dt;

for i=1:n_posiciones
    
    dxYdz(i,1)=dx;
    dxYdz(i,2)=dz;
    
end

posiciones_global=posiciones_global+dxYdz;

%posiciones_global=([cos(theta_inst-theta_ant) -sin(theta_inst-theta_ant);sin(theta_inst-theta_ant) cos(theta_inst-theta_ant)]*posiciones_global')';


%Se saca la posicion del borde de salida antes y después de que el perfil
%haya recorrido el diferencial de distancia, para así obtener la posicion
%en la que estará el último vórtice desprendido

posicion_bs_actual_global=posiciones_global(numel(posiciones_global)/2,:);


