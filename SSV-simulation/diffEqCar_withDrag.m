%% differential equations of the car: with drag
% returns the derivative of position and velocity of the car for a given
% input
% drag included, friction and rotation excluded

function dP = diffEqCar_withDrag(t,P,car,panel,motor,track)
 
% input
% t:            [] time
% P:            current value of the parameters we keep track of
%               the size of P = 2x1, P(1,1) is the position and P(2,1) the speed
% car:          structure containing parameters of the car
% panel:        structure containing parameters of the solar panel
% motor:        structure containing parameters of the motor
% track:        structure containing parameters of the track

% calculate new working point given current speed
dxp = P(2);
[Up,Ip]=calc_WP(dxp,car,panel,motor);

% current torque available for car acceleration
Tp = motor.Kt*Ip;
if motor.stallTorque<Tp
    Tp=motor.stallTorque;
end

%added (to check)
%Tp = Up * Ip / dxp;

% calculate current acceleration of the car
Fmotor_atLoad = car.mechanicalEff*(Tp * motor.eff*car.gearRatio)/(car.wheelOuterRadius); 
Fload_atLoad = car.mass*9.81060*sin(deg2rad(track.angle));
Fdrag_atLoad = 0.5*(P(2)^2)*track.airDensity*car.crossSectionArea*car.dragCoefficient;
ddxp = ((Fmotor_atLoad - Fload_atLoad - Fdrag_atLoad))/car.mass;

% output
dP(1,1) = P(2);         % current speed
dP(2,1) = ddxp;         % current acceleration

end
