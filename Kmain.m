%% main function for Kalman filter
function Kmain(videoName)

%% global variable
global video;
global tracks;
global tracks_output;
global frame_count; 
global nextId; 
global A C;
global colormap;
global kismap;
global v;
global Vheight;
global Vwidth;
global preLoca;
global TC1;
global TC2;
%% initial global variable
saveName = videoName;
videoName = strcat('\Video\',videoName,'.avi');
video = init(videoName);
tracks = init_tracks();        
tracks_output = init_outtracks();
frame_count = 1;
nextId = 1;
[A, C] = Kalman_Init();
colormap = init_colormap();
kismap = init_idsmap();
Vheight = 0;
Vwidth = 0;
preLoca = zeros(100,2);
saveName = strcat('result_',saveName,'.avi');
v = VideoWriter(saveName,'Uncompressed AVI');
v.FrameRate = 10;  % Default 30
TC1 = [];
TC2 = [];
%% main loop
open(v);
while ~isDone(video.reader)
    
    %% Read a Video Frame
    frame = read_Frame(); 
	
    if frame_count == 1
        [Vheight, Vwidth, ~] = size(frame);
    end
    
	%% Detect Pedestrian
    [centroids, bboxes] = detect_Pedestrian(frame);
	
	%% Predict the new tracks
    predict_New_State();
	
	%% Association, match measurements and tracks, return assigned tracks and unassigned tracks
    [assignments, unassignedTracks, unassignedDetections] = ...
        association(centroids, bboxes); % use Hungarian algorithm for data association
    %% Update tracks
	update_assigned_tracks(assignments, centroids, bboxes);
    update_unassigned_tracks(unassignedTracks);
   
    %% Delete lost tracks
	delete_lost_tracks();
	
    %% Create new tracks
    create_new_tracks(unassignedDetections, centroids, bboxes);
	
    %% Display results
    
    [tn, tk] = displayTrackingResults(frame, bboxes);
    
	frame_count = frame_count + 1;
%     if(length(tk)==2)
%         trace1 = tk(1).trace;
%         trace2 = tk(2).trace;
%     end
end

%% record trace
% 
% save('trace1.mat', 'trace1');
% save('trace2.mat', 'trace2');
close(v);

end