%Obtención de gráficas

clear all
clc
hold off

u_inf=1;
caso=3;%caso de Wagner
Courant_number=0.5;




n_paneles=1;
[L_total_1,L_teorica,Cl_total_1,tiempo]=Principal(n_paneles,Courant_number*(1/n_paneles)*(1/u_inf),caso);

limite=numel(tiempo)-1;

plot(tiempo(1:limite),L_teorica(1:limite),'b')
hold on
plot(tiempo(1:limite),L_total_1(1:limite),'r')




n_paneles=2;
[L_total_2,L_teorica,Cl_total_2,tiempo]=Principal(n_paneles,Courant_number*(1/n_paneles)*(1/u_inf),caso);

limite=numel(tiempo)-1;
plot(tiempo(1:limite),L_total_2(1:limite),'g')




n_paneles=6;
[L_total_3,L_teorica,Cl_total_3,tiempo]=Principal(n_paneles,Courant_number*(1/n_paneles)*(1/u_inf),caso);

limite=numel(tiempo)-1;
plot(tiempo(1:limite),L_total_3(1:limite),'y')

comprobacion(:,1)=L_teorica;comprobacion(:,2)=L_total_3;







    




    
    
    
    
    
    
    
    
    
    
    