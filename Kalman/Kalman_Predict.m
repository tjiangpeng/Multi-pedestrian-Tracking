function [mu_bar, Sigma_bar] = Kalman_Predict(mu, Sigma, A, R)

mu_bar = A * mu; % Predicted mean for simpler model
Sigma_bar = A * Sigma * A' + R; % Predicted covariance 

end