function update_assigned_p_tracks(assignments, centroids, bboxes)
global tracks;
global tracks_output;

num_assigned_tracks = size(assignments, 1);

for i = 1:num_assigned_tracks
    track_id = assignments(i,1);
    detection_id = assignments(i,2);
    bbox = bboxes(detection_id, :);
    asbbox = bbox;
    % detected location of pedestrian as measurement
    z_t = centroids(detection_id, :);
    
    now_id = tracks(track_id).id;
    tracks_output(now_id).x(end+1) = z_t(1);
    tracks_output(now_id).y(end+1) = z_t(2);
   
    % Compute weights
    [tracks(track_id).S] = weight(tracks(track_id).S, z_t, tracks(track_id).Q);
    
    % Find the maximum weight
    S_temp = tracks(track_id).S;
    [~, index] = max(S_temp(5,:));
    tracks(track_id).mu = S_temp(1:4,index);
    
    % Resample 
    tracks(track_id).S = systematic_resample(tracks(track_id).S);
    
    mu_t = tracks(track_id).mu;
    asbbox(3) = int32(bboxes(detection_id, 3));
    asbbox(4) = int32(bboxes(detection_id, 4));    
    mu_xy = mu_t(1:2,1);
    tran_centroid = int32(mu_xy') - int32(bbox(1,3:4) / 2);
    tracks(track_id).bbox = [tran_centroid, bbox(1,3:4)];
    tracks(track_id).asbbox = [tran_centroid, asbbox(1,3:4)];
    tct = bbox(1:2) + bbox(3:4)/2;
    tracks(track_id).age = tracks(track_id).age + 1;
    tracks(track_id).trace = [tracks(track_id).trace, tct];
    
    tracks(track_id).totalVisibleCount = tracks(track_id).totalVisibleCount + 1;
    
    tracks(track_id).consecutiveInvisibleCount = 0;
    

end
end