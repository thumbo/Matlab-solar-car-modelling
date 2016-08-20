%% SSV race plot
% generate the desired plots of the race (add/remove comments if necessary)

function generatePlots = plotRace(tOut,POut)

% input
% tOut:     array holding time information associated with all data in POut
% POut:     array holding position, velocity and acceleration associated with all times in tOut

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot position, velocity and acceleration of car all in one window
% (add/remove comment for desired output)

% plot position as function of time
subplot(2,2,1); plot(tOut,POut(:,1)); grid on; title('Position'); xlabel('Time [s]'); ylabel('Position [m]');
%plot velocity as function of time
subplot(2,2,2); plot(tOut,POut(:,2)); grid on; title('Velocity'); xlabel('Time [s]'); ylabel('Velocity [m/s]');
% plot velocity as function of position
subplot(2,2,3); plot(POut(:,1),POut(:,2)); grid on; title('Velocity'); xlabel('Position [m]'); ylabel('Velocity [m/s]');
% plot acceleration as function of position
subplot(2,2,4); plot(tOut,POut(:,3)); grid on; title('Acceleration'); xlabel('Time [s]'); ylabel('Acceleration [m/s^2]');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot separately position, velocity or acceleration in one window
% (add/remove comment for desired output)

% plot position as function of time
%f1=figure; plot(tOut,POut(:,1)); grid on; title('Position of the car on the track over time'); xlabel('Time [s]'); ylabel('Position [m]');

%plot velocity as function of time
%f2=figure; plot(tOut,POut(:,2)); grid on; title('Velocity of the car on the track over time'); xlabel('Time [s]'); ylabel('Velocity [m/s]');

% plot acceleration as function of position
%f3=figure; plot(tOut,POut(:,3)); grid on; title('Acceleration of the car on the track over time'); xlabel('Time [s]'); ylabel('Acceleration [m/s^2]');

end