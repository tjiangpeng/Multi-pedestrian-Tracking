%Inputs:
%           mu(t-1)    5 * M
%           R          4 * 4
%
%Outputs:
%           mu_bar     4 * M
function [S_bar] = Particle_Predict(S, R)

M = size(S,2);
dt = 1;

S_bar = zeros(5,M);
S_bar(1,:) = S(1,:) + dt * S(3,:);
S_bar(2,:) = S(2,:) + dt * S(4,:);
S_bar(3,:) = S(3,:);
S_bar(4,:) = S(4,:);

N_R = [normrnd(0, R(1,1), 1, M); normrnd(0, R(2,2), 1, M); 
       normrnd(0, R(3,3), 1, M); normrnd(0, R(4,4), 1, M)];    % diffusion 

N_R = [N_R; zeros(1,M)];

S_bar = S_bar + N_R;

end