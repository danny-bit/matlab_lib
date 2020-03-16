function [PhiMat, qout, eout] = g_klinreg(X,y,s)
%% g_klinreg(X,y,s)
%
% inputs:
% X ... regression vectors [uk,...,yk] in input space
% y ... outputs
% s ... number of modes

y = y(:);
N = size(X,1); % number of data points
d = size(X,2); % dimension of input data

% // settings
max_iter = 100; 
% stop when number of classified points is lower than this threshold
Nchanged_terminate = ceil(N*0.01); 
% number of restarts (there is a optimal number of restarts, here a fixed
% number is used)
restarts = 20;

% // restart loop
% perform multiple restarts with random initial conditions

PhiTensor = zeros(restarts,d,s);
qkMat     = zeros(restarts,N);
criterion = zeros(restarts,1);

for i = 1:restarts
    [PhiMat, e, qk] = perform_klinreg();
    
    PhiTensor(i,:,:) = PhiMat;
    qkMat(i,:) = qk;
    criterion(i) = sum(e);
end

% take best result
[~, idxMin] = min(criterion);
PhiMat = PhiTensor(idxMin,:,:);
PhiMat = reshape(PhiMat,d,s); % tensor -> matrix
eout = criterion(idxMin);
qout = qkMat(idxMin,:);
	
    function [PhiMat, e, qk] = perform_klinreg()
        % mode of every data point 
        qk = zeros(N,1); 

        % weights for each mode (arranged in columns)
        % initialize randomly
        PhiMat =  randn(d,s); 

        % for loop is terminated by different criterias, but performs at most
        % max_iter iterations
        for iter = 1:max_iter

            % ### assign the modes ("label the data")
            % #######################################
            % compute residuals for each mode, ek: N x s
            ek = y*ones(1,s) - X*PhiMat; 

            % assign the mode yielding the smallest squared error
            % qk: N x 1 ... index
            qk_old = qk;
            [~, qk] = min(ek.*ek,[],2);

            Nchanged = sum(qk~=qk_old);
            if (Nchanged < Nchanged_terminate)
                disp("terminate")
                break;
            end

            % ### estimate the submodels
            % #######################################

            for j = 1:s
                mask = (qk == j);
                N_mode = sum(mask);
                if (N_mode < 2)
                    disp("not enough data points to estimate mode")
                    break;
                end

                PhiMat(:,j) = X(mask,:)\y(mask);
            end
        end

        ek = y*ones(1,s) - X*PhiMat; 
		[e,qk] = min(ek.*ek,[],2);
    end
end