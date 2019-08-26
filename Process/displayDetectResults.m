% display the detected result
function displayDetectResults(frame, bboxes)
global video;

% convert the frame to uint8 RGB 
frame = im2uint8(frame);

labels = cellstr(repmat('M',size(bboxes,1),1));
frame = insertObjectAnnotation(frame, 'rectangle', bboxes, labels,...
    'Color', 'yellow');

video.videoPlayer.step(frame);
end
