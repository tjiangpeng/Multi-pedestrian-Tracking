function predict_pNew_State()
global tracks;

for i = 1:length(tracks)
    
    [tracks(i).S] = Particle_Predict(tracks(i).S, tracks(i).R);  % predict the current state of the track
    % shift the bounding box to the predicted location
  
end

end
