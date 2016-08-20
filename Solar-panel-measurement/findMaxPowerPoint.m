function [maxPower currentForMaxPower voltageForMaxPower] = findMaxPowerPoint(V,I)
%the function outputs the maximum power for a set of Currents and voltages 
%and returns the maximum power, the voltage of the operating point and the
%current of the operating poing

P=V.*I; %calculation of power
[maxPower,maxIndex]= max(P); %find maximum Power and index of it
currentForMaxPower = V(maxIndex); %use index to find the operationg point voltage
voltageForMaxPower = I(maxIndex); %use index to find the operating point current
