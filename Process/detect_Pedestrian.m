function [centroids, bboxes] = detect_Pedestrian(frame)
%global video;
        
% % detect foreground
% mask = step(video.detector,frame);
%         
% % apply morphological operations to remove noise and fill in holes
% mask = imopen(mask, strel('rectangle', [3,3])); % opening
% mask = imclose(mask, strel('rectangle', [15, 15])); % closing
% mask = imfill(mask, 'holes'); % fill hole
%         
% % perform blob analysis to find connected components,xi
% [~, centroids, bboxes] = video.blobAnalyser.step(mask);

detector = peopleDetectorACF;
[bboxes,scores] = detect(detector,frame);

centroids = bboxes(:,1:2) + bboxes(:,3:4) / 2;

end