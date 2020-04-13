%% Plotting my PCA results: ysing scatter3(x,y,z)

% Loading in my data
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\Comp2Fac.mat');
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\AdjComp2Fac.mat');
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\concatComp2Fac.mat');
% load the Comp2Fac.mat file uploaded

x = dataPCA.weights(:,1)';
y = dataPCA.weights(:,2)';
z = dataPCA.weights(:,3)';

xx = adjPCA.weights(:,1)';
yy = adjPCA.weights(:,2)';

xxx = concatPCA.weights(:,1)';
yyy = concatPCA.weights(:,2)';
zzz = concatPCA.weights(:,3)';

% Below sets the colours for my plot, in the order of Red, Blue, Green,
% Purple, Orange, Yellow, Brown, Pink, Grey.
[colours,~,~] = brewermap(length(xxx),'Set1'); %Change 'Paired' to something else if you want.
% [others,~,~] = brewermap(length(x),'Greys'); %Change 'Greys' to something else if you want.
% In this plot, stdx = Red; stdy = Blue; d = Green; rotation = Purple;
% scaling = Orange, translationx = Yellow, translationy = Brown
% scatter3(x,y,z,20,colours,'filled');
% title('Component Plot in Rotated Space');
% xlabel('Component 1');
% ylabel('Component 2');
% zlabel('Component 3');
% set(gca,'XLim',[-1 1],'YLim',[-1 1],'ZLim',[-1 1])

nCondition = 7;

for i = 1:nCondition
    scatter3(x(i),y(i),z(i),'filled')
    set(gca,'XLim',[-1 1],'YLim',[-1 1],'ZLim',[-1 1])
    hold on
end

%add a legend (which is in order of input in x, y and z:
legend([{'stdx'},{'stdy'},{'d'},{'rotation'},{'scaling'},{'translationx'},{'translationy'}])
title('Component Plot in Rotated Space');
xlabel('Component 1');
ylabel('Component 2');
zlabel('Component 3');

hold off

% Plotting the second plot for adjusted data 

figure(2)

scatter(xx(1),yy(1), 'filled')
hold on
scatter(xx(2),yy(2), 'filled')
hold on
scatter(xx(3),yy(3), 'filled')
hold on
scatter(xx(4),yy(4),'filled')
hold on
scatter(xx(5),yy(5),'filled')
hold on
scatter(xx(6),yy(6),'filled')
hold on
scatter(xx(7),yy(7),'filled')

legend([{'stdx'},{'stdy'},{'d'},{'rotation'},{'scaling'},{'translationx'},{'translationy'}])
title('Component Plot in Rotated Space');
xlabel('Component 1');
ylabel('Component 2');


%% Below is the plot for the rectified+unrectified data
nCondition = 10;

labels ={'stdx','stdy','d','rotation','scaling','translationx','translationy','absRotation','abstransx','abstransY'};

figure(3)

for i = 1:nCondition
    scatter3(xxx(i),yyy(i),zzz(i),40,colours(i),'filled')
    hold on
    textscatter3(xxx(i),yyy(i),zzz(i),labels(i))
    set(gca,'XLim',[-1 1],'YLim',[-1 1],'ZLim',[-1 1])
    hold on
end

% scatter3(xxx(1),yyy(1),zzz(1), colours(1), 'filled')
% hold on
% scatter3(xxx(2),yyy(2),zzz(2), colours(2),'filled')
% hold on
% scatter3(xxx(3),yyy(3),zzz(3), colours(3),'filled')
% hold on
% scatter3(xxx(4),yyy(4),zzz(4),colours(4),'filled')
% hold on
% scatter3(xxx(5),yyy(5),zzz(5),colours(5),'filled')
% hold on
% scatter3(xxx(6),yyy(6),zzz(6),colours(6),'filled')
% hold on
% scatter3(xxx(7),yyy(7),zzz(7),colours(7),'filled')
% hold on
% scatter3(xxx(8),yyy(8),zzz(8),colours(8),'filled')
% hold on
% scatter3(xxx(9),yyy(9),zzz(9),colours(9),'filled')
% hold on
% scatter3(xxx(10),yyy(10),zzz(10),colours(10),'filled')

%add a labels (which is in order of input in x, y and z):
title('Component Plot in Rotated Space');
xlabel('Component 1');
ylabel('Component 2');
zlabel('Component 3');
