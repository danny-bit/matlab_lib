close all; clear all;

%% use a sum of sinusoids
w = 2*pi/0.010;
t = 0:0.001:(0.2-0.001);
x = 4*sin(w*t);

figure;
plot(t,x)
x_fft = g_fft(x,'N',100,'Ts',0.001, 'onesided', true);

figure;
plot(x_fft.freq,2*abs(x_fft.signal),'x')