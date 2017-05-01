   
i=1;
pos_paneles=[1 0;0 0];

T=(pos_paneles(i+1,:)-pos_paneles(i,:));
modulo_T=norm(T);
t=((pos_paneles(i+1,:)/modulo_T)-(pos_paneles(i,:))/modulo_T);



normales(i,:)=[-t(1,2),t(1,1)]
tangentes(i,:)=t

tangentes*normales'