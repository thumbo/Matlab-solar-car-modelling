%% Energy breakdown of a race: Battery powered race
%findMechanicalEff creates a loop to make an estimate of the force lost due
%to mechanical losses
function [mechanicalEffs] = findMechanicalEff(car,panel,motor,track)
% input
% car:          structure containing parameters of the car
% panel:        structure containing parameters of the solar panel
% motor:        structure containing parameters of the motor
% track:        structure containing parameters of the track

times = xlsread('times.xlsx'); %reads the info of an excel file with all times
amountoftimes = size(times);                                %creating size of loops
mechanicalEffs = zeros(amountoftimes);                      %Initialising variables
for i = 1:amountoftimes(1)
    car.mechanicalEff = 1;
    while max(raceSimulation(car,panel,motor,track))<times(i)
        car.mechanicalEff = car.mechanicalEff - 0.01;
    end
    mechanicalEffs(i)=car.mechanicalEff;
end

end

