%% Script only containing the lsqnonlin method
% Refers to the mValueEquation
%Reading excel file containing the data from the experiment.
filePath='SPCNoOutliers.xlsx';
num = xlsread(filePath); %reads the info of the excel file
measurements = size(num,1); %determines the number of measurements

%Assigning Measured currents and voltages to an array.
data.V=num(:,1);%saves the values of V
data.Iact=num(:,2);%Saves the values of I

k=1.38*10^(-23);
C=20;
q = 1.6*(10^(-19));

panel.Is=10^(-8);
panel.e=2.71828;
panel.Ur=(k*(C+273))/q;
panel.Isc=0.4;

m = lsqnonlin(@(m) mValueEquation(m,data,panel),1);
m
figure
ax1 = subplot(2,1,1);
ax2 = subplot(2,1,2);

Ipred = panel.Isc - (panel.Is*(panel.e.^(data.V/(panel.Ur*m*16))-1));
plot(ax1,data.V,data.Iact,'.r',data.V,Ipred,'--b')
xlabel(ax1,'Voltage [V]')
ylabel(ax1,'Current [A]')
title(ax1,'Theoretical vs Actual Graph I/V')
grid(ax1,'on')
grid(ax1,'minor')

plot(ax2,data.V,(data.V .* data.Iact),'.r',data.V,(data.V .* Ipred),'--b')
xlabel(ax2,'Voltage [V]')
ylabel(ax2,'Power [W]')
title(ax2,'Theoretical vs Actual P/V')
grid(ax2,'on')
grid(ax2,'minor')