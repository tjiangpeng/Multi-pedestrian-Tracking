function tracks = init_tracks()
tracks = struct(...
            'id', {}, ...  % trackID
            'S', {}, ... % particles & weights
            'mu', {}, ... % mean  4 * 1
            'sigma', {}, ... % covariance
            'R', {}, ... % 
            'Q', {}, ... % 
            'bbox', {}, ... % 
            'asbbox', {}, ... %
            'age', {}, ...% total number
            'trace', {}, ...
            'totalVisibleCount', {}, ...% visuable number
            'consecutiveInvisibleCount', {}); % invisuable number
end