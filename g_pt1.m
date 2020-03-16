function y = g_pt1(u, varargin)
%% y = g_pt1(u, varargin) 
% apply a first order filter to the input signal u
%
% y_k = a*y_k-1 + (1-a)*u_k
%
% varargin: 
% Option1:
%     x Tau -> filter timeconstant
% AND x Ts  -> sampling time 
% 
% Option2:
% x a -> coefficient of the filter
%
%% ##### parse input arguments
    p = inputParser;

    defaultTau    = -1;
    defaultCoeffA = -1;
    defaultTs     = 1;
    
    addRequired(p,'u',@isnumeric);
    addOptional(p,'Tau',defaultTau,@isnumeric)
    addOptional(p,'Ts',defaultTs,@isnumeric)
    addOptional(p,'a',defaultCoeffA,@isnumeric)

    parse(p,u,varargin{:})

    u      = p.Results.u;
    CoeffA = p.Results.a;
    Tau    = p.Results.Tau;    
    Ts     = p.Results.Ts;
    
    if ((Tau == defaultTau) && ...
        (CoeffA == defaultCoeffA))
        error('Tau or Coeff argument has to be specified')
    end
    
    if (Tau ~= defaultTau)
        % tau given
        CoeffA = exp(-Ts/Tau);
    end
    
%% ##### function core
    % filter keeps input size (TODO: initial condition and stuff)
    y = filter((1-CoeffA),[1 -CoeffA],u);
end