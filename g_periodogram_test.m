close all; clear all;

%% use a sum of sinusoids
w = 2*pi/0.010;
t = 0:0.001:10;
x = randn(length(t),1);

% generate PRBS signal (use full sequence length to get meaningfull output)
x = idinput(16381,'prbs',[0 1],[-2 2]);

pgram = g_periodogram(x,'Ts',0.001);

figure;
subplot(211)
plot(x)
subplot(212)
plot(pgram.omega,abs(pgram.signal),'x')
