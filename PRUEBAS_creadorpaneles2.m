
n_paneles=500
[posiciones_local]=semicilinder()
plot(posiciones_local(:,1),posiciones_local(:,2))

[pos_paneles,long_paneles,coord_vor,coord_control,normales,tangentes]=creador_paneles(n_paneles,posiciones_local);

hold off
plot(posiciones_local(:,1),posiciones_local(:,2))
hold on
plot(pos_paneles(:,1),pos_paneles(:,2),'r')