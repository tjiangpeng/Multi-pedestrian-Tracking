function [assignments, unassignedTracks, unassignedDetections] = association_p(centroids, bboxes)
global tracks;

nTracks = length(tracks);
nDetections = size(centroids, 1);

% compute the cost of assigning each detection to each track. 
cost = zeros(nTracks, nDetections);

for i = 1:nTracks
    Kmu = tracks(i).S';
    M = size(Kmu,1);
    for j = 1:M
        cost(i, :) = cost(i, :) + distance(Kmu(j,1:2), centroids)';
    end
    cost(i,:) = cost(i,:) / M;
end

% solve the assignment problem
cost_NonAssignment = 30;
[assignments, unassignedTracks, unassignedDetections] = ...
assignDetectionsToTracks(cost, cost_NonAssignment); % data associiation through hungrian algorithm

end