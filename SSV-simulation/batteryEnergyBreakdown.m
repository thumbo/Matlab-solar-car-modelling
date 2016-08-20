%% Energy breakdown of a race: Battery powered race
% this function will give the energy ratios of a certain race and show
% the flow of energy against the time of the race
function [Energies] = batteryEnergyBreakdown(car,panel,motor,track)
% input
% car:          structure containing parameters of the car
% panel:        structure containing parameters of the solar panel
% motor:        structure containing parameters of the motor
% track:        structure containing parameters of the track

car.useSolar = 0;                                                           %Using battery so we set this to 0
mechanicalEfficiencies = findMechanicalEff(car,panel,motor,track);          %We find hypothetical mechanical efficiency ratios for the force
%mechanicalEfficiencies=effs;
datasize = max(size(mechanicalEfficiencies));                               %Creates a constant which will be used to see how many times we need to repeat a program

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializing variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
batteryEnergySupplied=zeros(1,datasize);
energyLossResistance=zeros(1,datasize);
energyLossAirFriction=zeros(1,datasize);
energyLossMechanical=zeros(1,datasize);
energyRace=zeros(1,datasize);
for racenum = 1:datasize                                                    %Creates loop for each race time we have
    car.mechanicalEff = mechanicalEfficiencies(racenum);                    
    [tOut,POut] = raceSimulation(car,panel,motor,track);
    t = calc_finishLine(tOut,POut);
    final = max(size(tOut));
    tOut(final) = t(1);
    positionCar = POut(:,1);
    positionCar(final) = t(2);
    velocityCar = POut(:,2);
    velocityCar(final) = t(3);    
    %accelerationCar = POut(:,3);
    motorCurrents = (9-(60./(motor.Kv.*2.*pi)).*(velocityCar.*car.gearRatio./(car.wheelOuterRadius)))/motor.R;
    pltbatteryEnergySupplied=zeros(1,final);
    pltenergyLossResistance=zeros(1,final);
    pltenergyLossAirFriction=zeros(1,final);
    pltenergyLossMechanical=zeros(1,final);
    pltenergyRace=zeros(1,final);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Pseudo integration
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for datapoint = 1:max(size(tOut))-1;
        pltbatteryEnergySupplied(datapoint+1)=pltbatteryEnergySupplied(datapoint) + (tOut(datapoint+1)-tOut(datapoint))*(motorCurrents(datapoint)+0.5*(motorCurrents(datapoint+1)-motorCurrents(datapoint)))*car.batteryVoltage;
        pltenergyLossResistance(datapoint+1)=pltenergyLossResistance(datapoint) + (tOut(datapoint+1)-tOut(datapoint))*(motorCurrents(datapoint)^2*motor.R+0.5*((motorCurrents(datapoint+1)^2-motorCurrents(datapoint)^2)*motor.R));
        pltenergyLossAirFriction(datapoint+1)=pltenergyLossAirFriction(datapoint) + ((0.25*(velocityCar(datapoint)^2)*track.airDensity*car.crossSectionArea*car.dragCoefficient)+(0.25*(velocityCar(datapoint+1)^2)*track.airDensity*car.crossSectionArea*car.dragCoefficient))*(positionCar(datapoint+1)-positionCar(datapoint));
        pltenergyRace(datapoint+1) = 0.5*velocityCar(datapoint)^2*car.mass;
        pltenergyLossMechanical(datapoint+1) = pltbatteryEnergySupplied(datapoint+1)-pltenergyLossResistance(datapoint+1)-pltenergyLossAirFriction(datapoint+1)-pltenergyRace(datapoint+1);
    end
    batteryEnergySupplied(racenum)=sum(pltbatteryEnergySupplied);
    energyLossResistance(racenum)=sum(pltenergyLossResistance);
    energyLossAirFriction(racenum)=sum(pltenergyLossAirFriction);
    energyLossMechanical(racenum)=sum(pltenergyLossMechanical);
    energyRace(racenum)=sum(pltenergyRace);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure()                                                                %Creates a new figure for each experimental time value
    plot(tOut,pltbatteryEnergySupplied,'-r',tOut,pltenergyRace,'-b',tOut,pltenergyLossResistance,'-g',tOut,pltenergyLossAirFriction,'-m',tOut,pltenergyLossMechanical,'-y')
    legend('Supplied','Velocity','Resistive Losses', 'Drag Losses', 'Mechanical Losses','Location','NorthWest')
    grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clearing variables for next iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear pltbatteryEnergySupplied
    clear pltenergyLossResistance
    clear pltenergyLossAirFriction
    clear pltenergyRace
    clear pltenergyLossMechanical
end
Energies=[batteryEnergySupplied;energyLossResistance;energyLossMechanical;energyLossAirFriction;energyRace];
end