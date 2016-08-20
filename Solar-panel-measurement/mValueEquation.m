%% Calculate difference between predicted and actual currents.

function f = mValueEquation(m,data,panel)
%Input
% m: m value for the solar panel.

%Output
% f: difference between the predicted value and the actual value

%Predicted value according to the mathematical model
Ipred = panel.Isc - (panel.Is*(panel.e.^(data.V/(panel.Ur*m*16))-1));

%Returning the difference between the predicted and the actual value
f = data.Iact-Ipred;
end