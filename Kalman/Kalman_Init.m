function [A, C] = Kalman_Init()

dt = 1; % discrete time

A = [1,0,dt,0,0,0;
     0,1,0,dt,0,0;
     0,0,1,0,0,0;
     0,0,0,1,0,0;
     0,0,0,0,1,0;
     0,0,0,0,0,1]; % State transition matrix

C = eye(6); % Measurement - State mapping

end
