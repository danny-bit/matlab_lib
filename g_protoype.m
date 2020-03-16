function y = g_protoype(u, varargin)
%% y = g_protoype(u, varargin) 
    % TODO
    
%% ##### parse input arguments
    % TODO
    p = inputParser;
    
    addRequired(p,'G');
    %addOptional(p,'opt',defaultOpt,@isnumeric)

    parse(p,u,varargin{:})

    u    = p.Results.G;
    %opt = p.Results.opt;

%% ##### function core
    % TODO
end