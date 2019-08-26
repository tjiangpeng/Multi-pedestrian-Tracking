% the initialization of output track
function tracks_output = init_outtracks()
tracks_output = struct(...
            'id', {}, ...  %ID
            'x',{},... % coordiante x
            'y',{},...;  % coordinate y
            'strat_frame',{}); % the frame number that the object appear 
end