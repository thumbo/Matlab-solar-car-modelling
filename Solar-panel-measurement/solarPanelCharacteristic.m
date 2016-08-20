V=[0:0.01:10];

Is=10^(-8);
e=2.71828;
m=1 %1.93387; %input value

k=1.38*10^(-23);
C=20;
T=273+C;
q = 1.6*(10^(-19));
Ur=(k*T)/q;
Isc=1.03;


I=Isc-(Is*(e.^(V/(Ur*m))-1));
P=V.*I;

plot(V,I,V,P);grid;xlabel('Voltage (V)');ylabel('Current (A)');title(['Solar Panel characteristic m =', num2str(m)]);ylim([0,1.2]);
