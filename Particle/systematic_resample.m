% This function performs systematic re-sampling
% Inputs:   
%           S_bar(t):       5XM
% Outputs:
%           S(t):           5XM
function S = systematic_resample(S_bar)

cdf = cumsum(S_bar(5,:));
M = size(S_bar,2);
S = zeros(5,M);
r_0 = rand / M;
for m = 1 : M
    i = find(cdf >= r_0,1,'first');
    S(:,m) = S_bar(:,i);
    r_0 = r_0 + 1/M;
end
S(5,:) = 1/M*ones(1,M);

end