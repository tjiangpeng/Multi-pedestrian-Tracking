function create_new_tracks(unassignedDetections, centroids, bboxes)
global tracks;   
global frame_count;
global tracks_output;
global nextId;

centroids = centroids(unassignedDetections, :);
bboxes = bboxes(unassignedDetections, :);

for i = 1:size(centroids, 1)

    centroid = centroids(i,:);
    bbox = bboxes(i, :);

    % create a new track
    newTrack = struct(...
        'id', nextId, ...
        'mu', [centroid'; 0; 0;double(bbox(3));double(bbox(4))], ...
        'sigma', eye(6), ...
        'R', diag([0.3 0.3 0.3 0.3 5 5]), ...
        'Q', diag([5 5 5 5 0.3 0.3]), ...
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
%     frame_count
    % increment the next id
    nextId = nextId + 1;
end
end