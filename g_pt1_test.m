clear all; close all;

t = 0:0.001:1;
w = 2*pi/0.1;
x = sin(w*t);

figure; hold all;
plot(t, x)
plot(t, g_pt1(x,'Tau',1/w,'Ts',0.001))

figure; hold all;
plot(t, x)
plot(t, g_pt1(x,'a',0.9))

