
tiempor=tiempo(1:1400);
Lr=L_total(1:1400);

plot(tiempor,Lr)

hold on

c=polyfit(tiempor,Lr,5);

xp=linspace(0,25,80);
yp=polyval(c,xp);


plot(xp,yp,'r')

hold off


% tiempor=tiempo(1:1400);
% gammasr=gammas_estela(1:1400);
% 
% plot(tiempor,gammasr)
% 
% hold on
% 
% c=polyfit(tiempor,gammasr,6);
% 
% xp=linspace(0,15,800);
% yp=polyval(c,xp);
% 
% 
% plot(xp,yp,'r')
% 
% hold off