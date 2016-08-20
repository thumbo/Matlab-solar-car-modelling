%% calculate the working point
% returns the voltage and current at the working point between solar panel
% and motor characteristics

function [Uwp, Iwp] = calc_WP(v, car, panel, motor)
% input
% v:        [m/s] the speed of the car
% car:      structure containing parameters of the car
% panel:	structure containing parameters of the solar panel
% motor:	structure containing parameters of the motor

% equations used: solar panel and motor characteristics
% I = panel.Isc - panel.Is*(panel.e.^(U/(panel.m*((panel.k*panel.tempK)/panel.q)*panel.N))-1);
% U = (60/(motor.Kv*2*pi))*(v*car.gearRatio/(car.wheelOuterRadius)) + motor.R*I;

% output

%%%%%%%
%Solar Panel
%%%%%%%
if car.useSolar == 1
    fun = @(U) (60/(motor.Kv*2*pi))*(v*car.gearRatio/(car.wheelOuterRadius)) + motor.R*(panel.Isc - panel.Is*(panel.e.^(U/(panel.m*((panel.k*panel.tempK)/panel.q)*panel.N))-1)) - U;
    Uwp = fzero(fun, 9);        % voltage at working point
    Iwp = panel.Isc - panel.Is*(panel.e.^(Uwp/(panel.m*((panel.k*panel.tempK)/panel.q)*panel.N))-1);   % current at working point

%%%%%%%
%Battery
%%%%%%%
else
    fun = @(I) (60/(motor.Kv*2*pi))*(v*car.gearRatio/(car.wheelOuterRadius)) + motor.R*(I) - car.batteryVoltage;
    Iwp = fzero(fun, 9);        % voltage at working point
    Uwp = car.batteryVoltage;   % current at working point
end
end


