
clear all
clc



u_inf=1;
caso=2;
Courant_number=0.5;




n_paneles=50;
[L_total,L_teorica,Cl_total,Cl_teorica,tiempo]=Principal(n_paneles,0.25/2,caso);

Cl_teoricav(1:159)=Cl_teorica;

plot(tiempo(1:79),Cl_teoricav(1:79),'b','DisplayName','Te�rico')
%legend('Te�rico')
hold on
grid on
plot(tiempo(1:79),Cl_total(1:79),'r','DisplayName','M�todo de Paneles')
hold off
%legend('Te�rico','M�todo de Paneles')
legend('show')
title('Placa plana en r�gimen estacionario')
xlabel('Tiempo')
ylabel('C_L')



