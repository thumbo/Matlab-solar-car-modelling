%% main SSV model
% contains all parametes, runs simulations and generates plots

clear all      % clear functions and variables from memory
close all      % close all open figure windows

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% parameters car
%
car.mass = 0.9044;                  %[kg] mass of SSV
car.gearRatio = 18.3;               %[] gear ratio: input/output
car.dragCoefficient = 0.8;          %[] Drag coefficient
car.crossSectionArea = 0.0458;      %[m^2] Cross section area of vehicle in direction it is moving 0.0458 is an approximation using the Worst case scenario of the panel
car.wheelOuterRadius = 0.05;        %[m] Outer radius of the wheel
car.numberOfWheels = 3;             %[] Number of wheels on the car
car.mechanicalEff = 1;              %[] mechanical efficiency estimate
car.useSolar = 1;                   %[] boolean: describes whether or not to use solar panel, 1 means solar panel 0 is battery
car.batteryVoltage = 9;             %[V] voltage of the battery attached if there's no solar panel

% parameters solar panel
%
panel.Isc = 0.4;                    %[A] short circuit current
panel.Is = 10^(-8);                 %[A] reverse saturation current
panel.e = 2.71828;                  %[] natural number
panel.k = 1.38*10^(-23);            %[A] Boltzmann constant
panel.tempC = 18;                   %[C] temperature in Celsius
panel.tempK = 273+panel.tempC;      %[K] temperature in Kelvin
panel.q = 1.6*(10^(-19));           %[C] charge of an electron
panel.m = 1.2904;                   %[] diode factor
panel.N = 16;                       %[] number of solar cells in module


% parameters DC-motor
%
motor.R = 3.32;                     %[Ohm] terminal resistance
motor.stallTorque = 23.2/1000;      %[Nm] stall torque
motor.Kt = 8.55/1000;               %[Nm/A] torque constant
motor.Kv = 1120;                    %[rpm/V] speed constant
motor.eff = 0.84;                   %[]

% parameters track
%
track.angle = 2.1;                    %[°] slope of the track as an angle
track.length = 0;                   %[m] length of the track
track.airDensity = 1.225;           %[kg/m^3] density of the air around the track, typical value of 1.225 for air

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% simulate SSV movement on track with given parameters
% (add/remove comment for desired output)
%
 [tOut, POut] = raceSimulation(car,panel,motor,track);                       % simulate race
 finishLine = calc_finishLine(tOut,POut);                                    % calculate time, position, velocity and acceleration of SSV at finish line
 display(['Total track time: ',num2str(finishLine(1)),' s']);                % display total track time
 display(['Position at finish line: ',num2str(finishLine(2)),' m']);         % display position at finish line
 display(['Velocity at finish line: ',num2str(finishLine(3)),' m/s']);       % display velocity at finish line
 display(['Acceleration at finish line: ',num2str(finishLine(4)),' m/s^2']); % display acceleration at finish line
 plotRace(tOut,POut);                                                        % generate plots based on simulation


% (add/remove comment for desired output)
%
% optimal = calc_optimalParameters(car,panel,motor,track);                    % calculate optimal parameters
% energies=batteryEnergyBreakdown(car,panel,motor,track);                     %Runs the script for generating the energy analysis of the battery test runs

