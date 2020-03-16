function [g_fft_out] = g_fft (signal, varargin)
%% [g_fft_out] = g_fft(signal, varargin) 
% caclulates fft with definition: 1/N sum signal * W_k
%
% varargin: 
% x N -> length fft (pos number)
% x Ts -> sampling time (pos number/ def = 1);
% x onesided -> trunace negative frequencies (bool / def=True)
%
% output:
% g_fft_out.signal
% g_fft_out.omega ([omega] = normalized angular frequencies / pi=nyquist)
% g_fft_out.freq  ([freq] = Hz)
%
% to get the amplitude of the contained frequencies
% magnitudes must be multiplied by a factor of 2
%
%% ##### parse input arguments
p = inputParser;

defaultTs = 1;
defaultN = -1;
defaultOnesided = true;

addRequired(p,'signal',@isnumeric);
addOptional(p,'Ts',defaultTs,@isnumeric)
addOptional(p,'N',defaultN,@isnumeric)
addOptional(p,'onesided',defaultOnesided,@islogical)

parse(p,signal,varargin{:})

N = p.Results.N;
Ts = p.Results.Ts;
signal = p.Results.signal;
onesided = p.Results.onesided;

% sampling frequency
fs = 1/Ts;             

% fft length
if N == -1
    N = length(signal);
end

%% ##### function core

% use the matlab implementation to calculate the fft
full_fft = 1/N*fft(signal,N);

if (onesided)
    Nfreq = floor(N/2); % TODO: really floor?
else
    Nfreq = N-1;
end

% calculate "normalized" angular frequencies: 
% (angular frequency) [rad/s] / fs [samples/s] = [rad/sample]
omega = (0:Nfreq)/N*pi;

% calculate frequencies: rad/sample * sample/s
freq = omega/pi*fs;

% cut-off negative frequencies (Nfreq +1 because indexing starts with one)
signal_fft = full_fft((0:Nfreq)+1);

%% ##### assign outputs
g_fft_out.signal = signal_fft;
g_fft_out.omega = omega;
g_fft_out.freq = freq;