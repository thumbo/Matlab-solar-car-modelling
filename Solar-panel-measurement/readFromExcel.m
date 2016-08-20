filePath='C:\Users\George\Desktop\george.xlsx'

num = xlsread(filePath); %reads the info of the excel file
measurements = size(num,1); %determines the number of measurements

for i = 1:measurements
V(i)=num(i,1);%saves the values of V
I(i)=num(i,2);%Saves the values of I
end
plot(V,I);grid;xlabel('Voltage');ylabel('Current');
title('Plot of measured values of the solar panel');
clear filePath i measurements num
 