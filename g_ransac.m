function modelOut = g_ransac(X,y)
% X: nxp
% y: nx1
% 1. randomly sample from the observed data (inliers and outliers)
% --> fit model on sampled points (cardinality is sufficient for
% calculation of the points)
% --> check consistency of the dataset with the model (outlierdetection my
% some threshold OR loss function)::set of inliers called consnsus set
% TERMINATION: consensus set has enough inliers (rejection or refinement)
% 2. use a voting scheme to find the optimal fitting result
% 3. reestimating the model from final consensus set
% Idea: datapoints vote for models 
% --> noisy points will not vote consistently for a model (few outliers)
% --> enoguth points to vote for models (few missing data)

nIters = 20;
nData = length(y);
thresh = 0.1;

% find minimum cardinality of model (for regression it's the input space
% dimension
% TODO: allow more general model?
nSamplingPoints = size(X,2)+1;


numInliers = zeros(nIters,1);
idxInliers = cell(nIters,1);
models     = cell(nIters,1);

Xaug = [X, ones(size(X,1),1)];

for iter = 1:nIters
    % // sample
    % sample without replacement k-integer from 1:N
    samplesIdxs = randsample(nData,nSamplingPoints);
    samples_X = Xaug(samplesIdxs,:);
    samples_y = y(samplesIdxs,:);
    
    % // fit model
    % use linear regression here
    % TODO: maybe allow more general functions
    % TODO: what if error?
    theta = samples_X\samples_y;
    models{iter} = theta;
    
    % // consensus set
    % TODO: define/allow a distance function?
    mask = (abs(Xaug*theta-y) < thresh);
    idxInliers{iter} = mask;
    numInliers(iter) = sum(mask);
    
    % TODO: define a threshold to stop iterating
end

[~, idxMaxInliers] = max(numInliers);
% TODO: refit the model with all inliers?
mask = idxInliers{idxMaxInliers};
modelOut = Xaug(mask,:)\y(mask,:);
end