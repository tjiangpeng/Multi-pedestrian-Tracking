function create_new_tracks_p(unassignedDetections, centroids, bboxes)
 
global tracks;   
global frame_count;
global tracks_output;
global nextId;

centroids = centroids(unassignedDetections, :);
bboxes = bboxes(unassignedDetections, :);

for i = 1:size(centroids, 1)

    centroid = centroids(i,:);
    bbox = bboxes(i, :);

    M = 300;% number of particles
    
    % create a new track
    newTrack = struct(...
        'id', nextId, ...
        'S', [repmat(centroid',1,M); zeros(3,M)], ...
        'mu', [centroid'; 0; 0], ...
        'sigma', eye(6), ...
        'R', diag([20 20 20 20]), ...
        'Q', diag([30 30]), ...
        'bbox', bbox, ...
        'asbbox', bbox, ...
        'age', 1, ...
        'trace', {[]}, ...
        'totalVisibleCount', 1, ...
        'consecutiveInvisibleCount', 0);

    % add it to the array of tracks
    tracks(end + 1) = newTrack;
    tracks_output(nextId).id = nextId;
    tracks_output(nextId).x = centroid(1);
    tracks_output(nextId).y = centroid(2);
    tracks_output(nextId).strat_frame = frame_count;
    % increment the next id
    nextId = nextId + 1;
end
end