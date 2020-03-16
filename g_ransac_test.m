%%
nSamples = 50;
x = -3 + 6*rand(nSamples,1);

a = 2;
b = 1;
y = a*x+b;

nOutliers = ceil(nSamples*0.3);
y_noise = -3 + 6 * rand(nOutliers,1);
x_noise = min(x) + (max(x)-min(x)) * rand(nOutliers,1);

x = [x; x_noise];
y = [y; y_noise];

figure;
plot(x,y,'x')

%%
w = g_ransac(x,y)
hold on;
plot(x,[x,ones(size(x,1),1)]*w,'k--')