%Obtención de gráficas

clear all
clc
hold off

u_inf=1;
caso=3;%caso de Wagner
Courant_number=0.5;




n_paneles=1;
[L_total_1,L_teorica,Cl_total_1,Cl_teorica,tiempo]=Principal(n_paneles,Courant_number*(1/n_paneles)*(1/u_inf),caso);

limite=numel(tiempo)-1;

plot(tiempo(1:limite),Cl_teorica(1:limite),'b','DisplayName','Teórico')
hold on
plot(tiempo(1:limite),Cl_total_1(1:limite),'r','DisplayName','N_{paneles} = 1')




n_paneles=2;
[L_total_2,L_teorica,Cl_total_2,Cl_teorica,tiempo]=Principal(n_paneles,Courant_number*(1/n_paneles)*(1/u_inf),caso);

limite=numel(tiempo)-1;
plot(tiempo(1:limite),Cl_total_2(1:limite),'g','DisplayName','N_{paneles} = 2')




n_paneles=6;
[L_total_3,L_teorica,Cl_total_3,Cl_teorica,tiempo]=Principal(n_paneles,Courant_number*(1/n_paneles)*(1/u_inf),caso);

limite=numel(tiempo)-1;
plot(tiempo(1:limite),Cl_total_3(1:limite),'y','DisplayName','N_{paneles} = 6')

comprobacion(:,1)=L_teorica;comprobacion(:,2)=L_total_3;


grid on
legend('show')
legend('Location','southeast')
title('Placa plana en régimen transitorio. Aceleración instantánea')
xlabel('Tiempo')
ylabel('L')



    




    
    
    
    
    
    
    
    
    
    
    