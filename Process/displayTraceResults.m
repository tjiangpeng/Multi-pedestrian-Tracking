% display the result of trace
function displayTraceResults(frame, trace)
global video;

if ~isempty(trace)
frame = im2uint8(frame);

labels = cellstr(repmat('',size(trace,1),1));
frame = insertObjectAnnotation(frame, 'circle', trace, labels,...
    'Color', 'green');  

video.videoPlayer.step(frame);
end
end
