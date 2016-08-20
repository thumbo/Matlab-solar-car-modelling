function m = calculateIdealityFactor(Vin,Iin)


Is=10^(-8);
e=2.71828;
k=1.38*10^(-23);
C=20;
T=273+C;
q = 1.6*(10^(-19));
Ur=(k*T)/q;
Isc=1.03;


%I=Isc-(Is*(e.^(V/(Ur*m))-1));
%5m = (Vin./Ur) *(log(Is)./(log(Isc)-log(Iin)+log(Is)));
m= (Vin./(Ur*log(((Isc-Iin)/Is)+1)));
