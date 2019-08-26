function tracks = init_tracks()
tracks = struct(...
            'id', {}, ...  % trackID
            'mu', {}, ... % mean
            'sigma', {}, ... % covariance
            'R', {}, ... % 
            'Q', {}, ... % 
            'bbox', {}, ... % 
            'asbbox', {}, ... %
            'age', {}, ... % total number
            'trace', {}, ...
            'totalVisibleCount', {}, ... % visuable number
            'consecutiveInvisibleCount', {}); % invisuable number
end