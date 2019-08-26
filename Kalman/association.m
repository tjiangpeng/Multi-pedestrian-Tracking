function [assignments, unassignedTracks, unassignedDetections] = association(centroids, bboxes)
global tracks;
lambda = 1.5;
nTracks = length(tracks);
nDetections = size(centroids, 1);

% compute the cost of assigning each detection to each track. 
cost = zeros(nTracks, nDetections);

for i = 1:nTracks
    Kmu = tracks(i).mu';
    cost(i, :) = distance(Kmu(1:2), centroids);
    cost_xy = cost(i, :);
    Kbbox = tracks(i).bbox;
    cost(i, :) = distance(single(Kbbox(3:4)), single(bboxes(:,3:4)));
    cost(i, :) = (0.5*cost(i, :) + lambda * cost_xy);
end

% solve the assignment problem
cost_NonAssignment = 40;
[assignments, unassignedTracks, unassignedDetections] = ...
assignDetectionsToTracks(cost, cost_NonAssignment); % use Hungarian algorithm for data association

end