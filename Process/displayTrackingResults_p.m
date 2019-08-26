function [tn, tk] = displayTrackingResults(frame, bboxes)
global video;
global tracks; 
global colormap;
global kismap;

% convert the frame and the mask to uint8 RGB 
frame = im2uint8(frame);
  
minVisibleCount = 8;
if ~isempty(tracks)

    % noisy detections 
    reliableTrackInds = ...
        [tracks(:).totalVisibleCount] > minVisibleCount;
    reliableTracks = tracks(reliableTrackInds);

    % display the objects. 
    tnum = 0;
    if ~isempty(reliableTracks) %If not been detected
        % get bounding boxes
        nboxes = cat(1, reliableTracks.asbbox);

        % get ids
        ids = int32([reliableTracks(:).id]);
        trace = [];
        tnum = length(ids);
        
        % create labels for objects
        ltid = length(ids);
        kisi =  kismap(1:ltid);
        
        labels = cellstr(int2str(ids'));
        predictedTrackInds = ...
            [reliableTracks(:).consecutiveInvisibleCount] > 0;
        isPredicted = cell(size(labels));
        isPredicted(predictedTrackInds) = {' predicted'}; % display predicted bounding box.
        labels = strcat(labels, isPredicted);

        % draw on the frame
        frame = insertObjectAnnotation(frame, 'rectangle', ...
            nboxes, ids, 'color', 'red');
        
        for k=1:tnum
            trace = [{reliableTracks(k).trace}];
            index = ids(k);
%             index = k;
            frame = insertShape(frame,'Line',trace,'color', colormap(index));
            
            % draw particles
            particle_set = reliableTracks(k).S;% cell,position: x,y,radius
            M = size(particle_set,2);
            particle_set = [particle_set(1:2,:); ones(1,M)]';
            particle_set = cat(1, particle_set);
            labels = cellstr(repmat('',size(M,1),1));
            frame = insertObjectAnnotation(frame, 'circle', ...
            particle_set, labels, 'color', colormap(index));
        end
        
    else
        trace = [];
    end
else
    trace = [];
end
labels = cellstr(repmat('',size(bboxes,1),1));
    frame = insertObjectAnnotation(frame, 'rectangle', bboxes, labels,...
    'Color', 'blue');

video.videoPlayer.step(frame);
recoadVideo(frame);
if ~isempty(tracks)
    tk = reliableTracks;
    tn = tnum;
else
    tn = [];
    tk = [];
end
end