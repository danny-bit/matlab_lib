x = -3:0.1:3;
x = x(:);
N = length(x)
X = [x, ones(size(x))];

phi1 = [2 1]';
phi2 = [-1 2]';

y1 = X*phi1;
y2 = X*phi2;
y1n = y1+randn(size(y1));
y2n = y2+randn(size(y2));

figure; hold all;
plot(x,y1,'r')
plot(x,y2,'b')
plot(x,y1n,'or')
plot(x,y2n,'ob')

% plot the sampled data
figure; hold all;
plot(x,y1,'--r')
plot(x,y2,'--b')

% sample randomly from the two classes
ytemp = [y1n;y2n];
XX = [X;X];
xx = [x;x];

rng(0) % set a fixed seed for debugging
[y, idx] = datasample(ytemp,N,'Replace',false);
X = XX(idx,:);
x = xx(idx,:);

plot(x,y,'kx')

%%
[PhiMat,q] = g_klinreg(X, y, 2);

disp("Phi - PhiEst")
[phi1, PhiMat(:,1)]
[phi2, PhiMat(:,2)]

plot(xx(q==1),XX(q==1,:)*PhiMat(:,1),'or')
plot(xx(q==2),XX(q==2,:)*PhiMat(:,2),'ob')