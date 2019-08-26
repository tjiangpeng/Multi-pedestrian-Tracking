%Inputs:
%           mu          5 * M
%           z_t         1 * 2
%           Q           2 * 2
%
%Outputs:
%           mu          5 * M
function mu = weight(mu, z_t, Q)

mu(5,:) = mvnpdf(mu(1:2,:)', z_t, Q);

M = size(mu,2);
if sum(mu(5,:)) == 0
    mu(5,:) = 1/M;
else
    mu(5,:) = mu(5,:) ./ sum(mu(5,:));
end
end