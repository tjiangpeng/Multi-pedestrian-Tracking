function [mu, sigma] = update_Kalman(mu, sigma, z_t, C, Q)
% Kalman gain
K = sigma * C' / (C * sigma * C' + Q);

mu = mu + K * (z_t - C * mu);

sigma = sigma - K * C * sigma;

end
