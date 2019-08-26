% Read the next video frame from the video file.
function frame = read_Frame()
global video;

frame = video.reader.step(); % activate the function of read frame    

end