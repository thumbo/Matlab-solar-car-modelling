%% raceSimulation
% contains the ode45 function
function [tOut, POut] = raceSimulation(car,panel,motor,track)
% input
% car:          structure containing parameters of the car
% panel:        structure containing parameters of the solar panel
% motor:        structure containing parameters of the motor
% track:        structure containing parameters of the track

%output
% tOut:         Array containing all the times of the car
% POut:         Array containing position, velocity, and acceleration of the SSV

% initial conditions
ic.x0 = 0;                                     %[m] position at the start
ic.dx0 = 0;                                    %[m/s] velocity at the start
ic.startTime = 0;                              %[s] starting time of simulation
ic.endTime = Inf;                              %[s] Can be set to infinity due to ode45 options

options = odeset('Events',@funendcond);        % Creates the options for the ode45 function based on the funendcond function

[tOut,POut]=ode45(@(t,P)diffEqCar_withDrag(t,P,car,panel,motor,track),[ic.startTime ic.endTime],[ic.x0 ic.dx0],options);

for i=1:length(POut)                                                        %Loop in order to store acceleration
    dPOut = diffEqCar_withDrag(tOut(i),POut(i,:),car,panel,motor,track);
    POut(i,3) = dPOut(2);
end


end