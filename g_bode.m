function [mag, phase, freqOut] = g_bode(G, freqRange, varargin)
%% y = g_bodeMag(u, varargin) 
% TODO
%% ##### parse input arguments
    p = inputParser;

    addRequired(p,'G');
    addRequired(p,'freqRange',@isnumeric)
    addOptional(p,'Units','Hz')

    parse(p,G,freqRange,varargin{:})

    G         = p.Results.G;
    units     = p.Results.Units;
    freqRange = p.Results.freqRange;
   
%% ##### function core

    % create frequency range
    Npoints = 10000;
    minFreq = freqRange(1);
    maxFreq = freqRange(2);
    
    if (strcmp(units,'Hz'))
        minFreq = freqRange(1)*2*pi;
        maxFreq = freqRange(2)*2*pi;
    end
    
    omegaRange = logspace(log10(minFreq), log10(maxFreq), Npoints);
    
    % calc bode plot
    [mag,phase,omega] = bode(G,omegaRange);
    mag = mag(:);
    
    % workaround to get the phase wrapping correct
    % don't know if there is something better
    phase = phase(:)*pi/180;
    x = mag.*cos(phase);
    y = mag.*sin(phase);
    phase = atan2(y,x)*180/pi;
    phase = unwrap(phase);
    
    omega = omega(:); % [rad/s]
    
    if (strcmp(units,'Hz'))
        freqOut = omega/(2*pi);  % [Hz]
    end
end