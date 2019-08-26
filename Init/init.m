function video = init(filename)
% set up object for detection

video.reader = vision.VideoFileReader(filename);    %read video
video.videoPlayer = vision.VideoPlayer('Position', [200, 0, 1300, 900]);   %set video player
video.detector = vision.ForegroundDetector('NumGaussians', 3, ...   % foreground detection
            'NumTrainingFrames', 200, 'MinimumBackgroundRatio', 0.7); 
video.blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...  %output centroid and bounding box
            'AreaOutputPort', true, 'CentroidOutputPort', true, ...
            'MinimumBlobArea', 40,'MaximumBlobArea',100000);        
end