function [lineHandleMag, lineHandlePhase, axisHandleMag, axisHandlePhase] = g_bodePlot(G, freqRange, varargin)
%% y = g_bodePlot(u, varargin) 
% TODO
%% ##### parse input arguments
    p = inputParser;

    addRequired(p,'G');
    addRequired(p,'freqRange',@isnumeric)
    addOptional(p,'Units','Hz')
    addOptional(p,'axisHandleMag',-1,@isnumeric)
    addOptional(p,'axisHandlePhase',-1,@isnumeric)

    parse(p,G,freqRange,varargin{:})

    G = p.Results.G;
    units = p.Results.Units;
    freqRange = p.Results.freqRange;
    ahMag = p.Results.axisHandleMag;
    ahPhase = p.Results.axisHandlePhase;
   
%% ##### function core

    if (ahMag == -1 || ahPhase == -1)
        ahMag = subplot(211);
        ahPhase = subplot(212);
    end
    [mag, phase, freq] = g_bode(G, freqRange, 'Units', units);

    lineHandleMag = plot(ahMag, freq, mag); 
    hold(ahMag, 'on');
    lineHandlePhase = plot(ahPhase, freq, phase);
    hold(ahPhase, 'on');
    
    set(ahMag, 'XScale', 'log')
    set(ahMag, 'YScale', 'log')
    grid(ahMag, 'on')

    set(ahPhase, 'XScale', 'log')
    grid(ahPhase, 'on')
    
    linkaxes([ahMag,ahPhase],'x')
    xlim(ahPhase,freqRange)
    
    axisHandleMag = ahMag;
    axisHandlePhase = ahPhase;
end