function predict_New_State()
global tracks;
global A;

for i = 1:length(tracks)
    
    [mu_bar, Sigma_bar] = Kalman_Predict(tracks(i).mu, tracks(i).sigma, A, tracks(i).R);  % predict the current state of the track
    % shift the bounding box to the predicted location
  
    tracks(i).mu = mu_bar;
    tracks(i).sigma = Sigma_bar; 
end

end
