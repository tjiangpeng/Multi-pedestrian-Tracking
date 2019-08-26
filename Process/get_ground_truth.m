% get the ground truth of a video
fileName = 'Video.avi';
obj = VideoReader(fileName);
numFrames = obj.NumberOfFrames;

for k = 1 : numFrames
    I = read(obj, k);
    imshow(I);
    
    [x,y] = ginput(1);
    track(k,1) = int16(x(1));
    track(k,2) = int16(y(1));
end
save('track2.mat','track');