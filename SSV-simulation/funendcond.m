function [value,isterminal,direction] = funendcond(t,P)
%funendcond is a function describing end conditions of the ode45 function
value = max(P(1,:))-7;                                                     %Once the track is passed 7m stop the ode45 loop
isterminal = 1;                                                            %If the integration is to end at a 0 of this function, end at 0
direction = 1;                                                             %Which direction will the function create 0?
end

