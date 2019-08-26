function update_unassigned_tracks(unassignedTracks)
global tracks;
global tracks_output;

for i = 1:length(unassignedTracks)
    ind = unassignedTracks(i);
    tracks(ind).age = tracks(ind).age + 1;
    tracks(ind).consecutiveInvisibleCount = ...
    tracks(ind).consecutiveInvisibleCount + 1;

    now_id = tracks(ind).id;

    tracks_output(now_id).x(end+1) = tracks_output(now_id).x(end);
    tracks_output(now_id).y(end+1) = tracks_output(now_id).y(end);
end