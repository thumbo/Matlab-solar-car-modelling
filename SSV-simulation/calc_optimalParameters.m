%% calculate optimal SSV parameters
% calculate optimal parameters for the car with different track slopes

function optimal = calc_optimalParameters(car,panel,motor,track)

% input
% car:          structure containing parameters of the car
% panel:        structure containing parameters of the solar panel
% motor:        structure containing parameters of the motor
% track:        structure containing parameters of the track

% parameters range to test
% N.B. these values can be chosen
%
initialMass = 0.9;          % initial car mass to test
finalMass = 1.0;              % final car mass to test
deltaMass = 0.05;            % increment of mass during test
initialWheelRadius = 0.01;     %%% initial wheel radius to test 
finalWheelRadius = 0.1;       %%% final wheel radius to test
deltaWheelRadius = 0.01;       %%% increment of wheel radius to test 

% initialise variables
track.angle = -4.2;
optimal = zeros(5,4);

% create arrays to generate 3d plot
massToPlot = initialMass:deltaMass:finalMass;
wheelRadiusToPlot = initialWheelRadius:deltaWheelRadius:finalWheelRadius; 
timeToPlot = zeros(length(wheelRadiusToPlot),length(massToPlot)); 

for i = 1 : 5                                                               % test all 5 track slopes
    
    % initialise variables
    bestTime = 60;
    car.mass = initialMass;
    optimalMass = 0;
    optimalWheelRadius = 0; 
    j=1;
    
    while car.mass <  finalMass+0.0001;                                     % test all car masses within the range
        
        car.wheelOuterRadius = initialWheelRadius;
        k=1;
        
        while car.wheelOuterRadius <  finalWheelRadius+0.0001;                       % test all car wheel radii within the range
            try
            [tOut, POut] = raceSimulation(car,panel,motor,track);           % run simulation
            finishLine = calc_finishLine(tOut,POut);                        % calculate time to finish the track
            finishLineTime = finishLine(1);
            timeToPlot(k,j) = finishLineTime;
            
            if finishLineTime < bestTime                                    % check if time is optimal
                bestTime = finishLineTime;                                  % update optimal time
                optimalWheelRadius = car.wheelOuterRadius;                           % update optimal wheel radius
                optimalMass = car.mass;                                     % update optimal mass
            end
            
            end
            car.wheelOuterRadius = car.wheelOuterRadius + deltaWheelRadius;                 % increment wheel radius to test
            k = k+1;
            
        end
        
        car.mass = car.mass + deltaMass;                                    % increment mass to test
        j = j+1;
        
    end
    
    % update optimal values
    optimal(i,:) = [track.angle, bestTime, optimalMass, optimalWheelRadius];
    
    % display optimal values
    display(['Optimal values for track slope ',num2str(optimal(i,1)),'°     Time: ', num2str(optimal(i,2)) ,' s      Mass: ', num2str(optimal(i,3)),' kg      Wheel Radius: ', num2str(optimal(i,4))]);
    
    % generate 3d plot for corresponding track slope
    subplot(3,2,i);
    surf(massToPlot,wheelRadiusToPlot,timeToPlot);
    title(strcat('Track slope',{' '},num2str(track.angle),{'°'}));
    xlabel('Mass [kg]');
    ylabel('Wheel radius [m]');
    zlabel('Time [s]');

    % increment track angle to test
    track.angle = track.angle + 2.1;                                        
    
end

% output
% optimal:	array containing track angle, time required to finish the
% track, optimal mass and wheel radius used

end