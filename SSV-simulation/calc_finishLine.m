%% calculate data at finish line
% returns the time, position, velocity and acceleration of the car at the
% end of the track

function f = calc_finishLine(tOut,POut)

% input
% tOut:     array holding time information associated with all data in POut
% POut:     array holding position, velocity and acceleration associated with all times in tOut

i = 1;                      % initialise index

while POut(i,1) < 7
    b(1) = tOut(i);         % holds current time
    b(2:4) = POut(i,1:3);   % holds current position, velocity and acceleration
    i = i+1;
    a(1) = tOut(i);         % holds time after 7m limit
    a(2:4) = POut(i,1:3);   % holds position, velocity and acceleration after 7 second limit
end

deltas= b-a;                        % An array containing the deltas of all
adjs = 7-b(2);                      % Interpolation adjustment to go from the position from before 7m to 7m
adjt = adjs*deltas(1)/deltas(2);    % Multiplying the slope to get required adjustment for time
adjv = adjt*deltas(3)/deltas(1);    % Multiplying the slope by the adjustment in time to get the adjustment in velocity
adja = adjt*deltas(4)/deltas(1);    % Multiplying the slope by the adjustment in time for adjustment in acceleration

% Adding all the adjustments to the before final value to reach their end
% point values
f(1)=b(1)+adjt;
f(2)=b(2)+adjs;
f(3)=b(3)+adjv;
f(4)=b(4)+adja;

% output
% f         array holding time, position, velocity and acceleration
% f(1)      time at finish line
% f(2)      position at finish line
% f(3)      velocity at finish line
% f(4)      acceleration at finish line

end