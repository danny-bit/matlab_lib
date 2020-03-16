subplot1(2,2,'Gap',[0.03 0.03])
plot_num = 0;
for i=1:2
for j=1:2
plot_num = plot_num + 1;
subplot1(plot_num);
plot(randn(100,1),randn(100,1),'k.')
axis([-3 3 -3 3])
axis square
end
end