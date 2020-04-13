%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         Procrustes D Analysis                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% I want to reset my workspace and command window
close all; clear; clc;
% procrustes Procrustes Analysis
%     D = procrustes(X, Y) determines a linear transformation (translation,
%     reflection, orthogonal rotation, and scaling) of the points in the
%     matrix Y to best conform them to the points in the matrix X.  The
%     "goodness-of-fit" criterion is the sum of squared errors.  procrustes
%     returns the minimized value of this dissimilarity measure in D.  D is
%     standardized by a measure of the scale of X, given by
%  
%        sum(sum((X - repmat(mean(X,1), size(X,1), 1)).^2, 1))
%  
%     i.e., the sum of squared elements of a centered version of X.  However,
%     if X comprises repetitions of the same point, the sum of squared errors
%     is not standardized.
%  
%     X and Y are assumed to have the same number of points (rows), and
%     procrustes matches the i'th point in Y to the i'th point in X.  Points
%     in Y can have smaller dimension (number of columns) than those in X.
%     In this case, procrustes adds columns of zeros to Y as necessary.
%  
%     [D, Z] = procrustes(X, Y) also returns the transformed Y values.
%  
%     [D, Z, TRANSFORM] = procrustes(X, Y) also returns the transformation
%     that maps Y to Z.  TRANSFORM is a structure with fields:
%        c:  the translation component
%        T:  the orthogonal rotation and reflection component
%        b:  the scale component
%     That is, Z = TRANSFORM.b * Y * TRANSFORM.T + TRANSFORM.c.
%  
%     [...] = procrustes(..., 'Scaling',false) computes a procrustes solution
%     that does not include a scale component, that is, TRANSFORM.b == 1.
%     procrustes(..., 'Scaling',true) computes a procrustes solution that
%     does include a scale component, which is the default.
%  
%     [...] = procrustes(..., 'Reflection',false) computes a procrustes solution
%     that does not include a reflection component, that is, DET(TRANSFORM.T) is
%     1.  procrustes(..., 'Reflection','best') computes the best fit procrustes
%     solution, which may or may not include a reflection component, 'best' is
%     the default.  procrustes(..., 'Reflection',true) forces the solution to
%     include a reflection component, that is, DET(TRANSFORM.T) is -1.
%  
%     Examples:
%  
%        % Create some random points in two dimensions
%        n = 10;
%        X = normrnd(0, 1, [n 2]);
%  
%        % Those same points, rotated, scaled, translated, plus some noise
%        S = [0.5 -sqrt(3)/2; sqrt(3)/2 0.5]; % rotate 60 degrees
%        Y = normrnd(0.5*X*S + 2, 0.05, n, 2);
%  
%        % Conform Y to X, plot original X and Y, and transformed Y
%        [d, Z, tr] = procrustes(X,Y);
%        plot(X(:,1),X(:,2),'rx', Y(:,1),Y(:,2),'b.', Z(:,1),Z(:,2),'bx');

%% Load the file LVF
% load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\DownSaccRVF\DRVFIndividualClusters.mat')


%% Uncomment below to manually adjust path and P and other values
% % Manually adjust the load path for each 8 condition; copy into SPSS and
% % excel.

% load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccRVF\DRVFIndividualClusters.mat')
% 
% nSub = 35;
% 
% listD = [];
% listC = [];
% listB = [];
% listT = [];
% listA = [];
% 
% % How to find the rotation angle: a = atan2(TRANSFORM.T(1,2),TRANSFORM.T(1,1));
% 
% for i = 1:nSub
%     iSub = DRVF.iSub(:,:,i);
%     Xlvfp = [iSub(:,3),iSub(:,4)];
%     Ylvfp = [iSub(:,1),iSub(:,2)];
%     [D,Z,TRANSFORM] = procrustes(Xlvfp, Ylvfp);
%     a = atan2(TRANSFORM.T(1,2),TRANSFORM.T(1,1));
%     listD = [listD; D];
%     listC = [listC; TRANSFORM.c(1,:)];
%     listB = [listB; TRANSFORM.b];
%     listT = [listT, TRANSFORM.T];
%     listA = [listA; a];
% end
% 
% listCx = listC(:,1);
% listCy = listC(:,2);

%% Below is averaged procrustes value across particpants... LLVF
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccLVF\LLVFProcrustes.mat')

% segment data according to response or actual location of each stimulus

Xlvfp = [LLVFP.Resp(:,3),LLVFP.Resp(:,4)];
Ylvfp = [LLVFP.Resp(:,1),LLVFP.Resp(:,2)];
D = procrustes(Xlvfp, Ylvfp);
[D, Z] = procrustes(Xlvfp, Ylvfp);

% red Xs are the actual location, blue is the response

% make the list of the Xx coordinates that are actual 

Xlvfp1 = Xlvfp(2,:);
Xlvfp2 = Xlvfp(1,:);
Xlvfp3 = Xlvfp(3,:);
Xlvfp4 = Xlvfp(4,:);

Xx = [Xlvfp1;Xlvfp2;Xlvfp3;Xlvfp4;Xlvfp1];

% Make a list of the response

Ylvfp1 = Ylvfp(2,:);
Ylvfp2 = Ylvfp(1,:);
Ylvfp3 = Ylvfp(3,:);
Ylvfp4 = Ylvfp(4,:);

Yy = [Ylvfp1;Ylvfp2;Ylvfp3;Ylvfp4;Ylvfp1];

% Make a list of the transformed data

Zlvfp1 = Z(2,:);
Zlvfp2 = Z(1,:);
Zlvfp3 = Z(3,:);
Zlvfp4 = Z(4,:);

Zz = [Zlvfp1;Zlvfp2;Zlvfp3;Zlvfp4;Zlvfp1];

% Plot the data into trapezoids
figure(1)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('LLVF')

% Repeat for the rest of the 7 conditions

%% Below is averaged procrustes value across particpants... LRVF trapezoid
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccRVF\LRVFProcrustes.mat')


Xlrvf = [LRVFP.Resp(:,3),LRVFP.Resp(:,4)];
Ylrvf = [LRVFP.Resp(:,1),LRVFP.Resp(:,2)];
D = procrustes(Xlrvf, Ylrvf);
[D, Z] = procrustes(Xlrvf, Ylrvf);

% red Xs are the actual location, blue 
Xlrvf1 = Xlrvf(2,:);
Xlrvf2 = Xlrvf(1,:);
Xlrvf3 = Xlrvf(3,:);
Xlrvf4 = Xlrvf(4,:);

Xx = [Xlrvf1;Xlrvf2;Xlrvf3;Xlrvf4;Xlrvf1];

Ylrvf1 = Ylrvf(2,:);
Ylrvf2 = Ylrvf(1,:);
Ylrvf3 = Ylrvf(3,:);
Ylrvf4 = Ylrvf(4,:);

Yy = [Ylrvf1;Ylrvf2;Ylrvf3;Ylrvf4;Ylrvf1];

Zlrvf1 = Z(2,:);
Zlrvf2 = Z(1,:);
Zlrvf3 = Z(3,:);
Zlrvf4 = Z(4,:);

Zz = [Zlrvf1;Zlrvf2;Zlrvf3;Zlrvf4;Zlrvf1];

figure(2)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('LRVF')

%% Below is averaged procrustes value across particpants... RLVF trapezoid
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccLVF\RLVFProcrustes.mat')

Xrlvf = [RLVFP.Resp(:,3),RLVFP.Resp(:,4)];
Yrlvf = [RLVFP.Resp(:,1),RLVFP.Resp(:,2)];
D = procrustes(Xrlvf, Yrlvf);
[D, Z] = procrustes(Xrlvf, Yrlvf);

% red Xs are the actual location, blue 
Xrlvf1 = Xrlvf(2,:);
Xrlvf2 = Xrlvf(1,:);
Xrlvf3 = Xrlvf(3,:);
Xrlvf4 = Xrlvf(4,:);

Xx = [Xrlvf1;Xrlvf2;Xrlvf3;Xrlvf4;Xrlvf1];

Yrlvf1 = Yrlvf(2,:);
Yrlvf2 = Yrlvf(1,:);
Yrlvf3 = Yrlvf(3,:);
Yrlvf4 = Yrlvf(4,:);

Yy = [Yrlvf1;Yrlvf2;Yrlvf3;Yrlvf4;Yrlvf1];

Zrlvf1 = Z(2,:);
Zrlvf2 = Z(1,:);
Zrlvf3 = Z(3,:);
Zrlvf4 = Z(4,:);

Zz = [Zrlvf1;Zrlvf2;Zrlvf3;Zrlvf4;Zrlvf1];

figure(3)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('RLVF')

%% Below is averaged procrustes value across particpants... RRVF trapezoid
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccRVF\RRVFProcrustes.mat')


Xrrvf = [RRVFP.Resp(:,3),RRVFP.Resp(:,4)];
Yrrvf = [RRVFP.Resp(:,1),RRVFP.Resp(:,2)];
D = procrustes(Xrrvf, Yrrvf);
[D, Z] = procrustes(Xrrvf, Yrrvf);

% red Xs are the actual location, blue 
Xrrvf1 = Xrrvf(2,:);
Xrrvf2 = Xrrvf(1,:);
Xrrvf3 = Xrrvf(3,:);
Xrrvf4 = Xrrvf(4,:);

Xx = [Xrrvf1;Xrrvf2;Xrrvf3;Xrrvf4;Xrrvf1];

Yrrvf1 = Yrrvf(2,:);
Yrrvf2 = Yrrvf(1,:);
Yrrvf3 = Yrrvf(3,:);
Yrrvf4 = Yrrvf(4,:);

Yy = [Yrrvf1;Yrrvf2;Yrrvf3;Yrrvf4;Yrrvf1];

Zrrvf1 = Z(2,:);
Zrrvf2 = Z(1,:);
Zrrvf3 = Z(3,:);
Zrrvf4 = Z(4,:);

Zz = [Zrrvf1;Zrrvf2;Zrrvf3;Zrrvf4;Zrrvf1];

figure(4)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('RRVF')

%% Below is averaged procrustes value across particpants... ULVF trapezoid
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccLVF\ULVFProcrustes.mat')


Xulvf = [ULVFP.Resp(:,3),ULVFP.Resp(:,4)];
Yulvf = [ULVFP.Resp(:,1),ULVFP.Resp(:,2)];
D = procrustes(Xulvf, Yulvf);
[D, Z] = procrustes(Xulvf, Yulvf);

% red Xs are the actual location, blue 
Xulvf1 = Xulvf(2,:);
Xulvf2 = Xulvf(1,:);
Xulvf3 = Xulvf(3,:);
Xulvf4 = Xulvf(4,:);

Xx = [Xulvf1;Xulvf2;Xulvf3;Xulvf4;Xulvf1];

Yulvf1 = Yulvf(2,:);
Yulvf2 = Yulvf(1,:);
Yulvf3 = Yulvf(3,:);
Yulvf4 = Yulvf(4,:);

Yy = [Yulvf1;Yulvf2;Yulvf3;Yulvf4;Yulvf1];

Zulvf1 = Z(2,:);
Zulvf2 = Z(1,:);
Zulvf3 = Z(3,:);
Zulvf4 = Z(4,:);

Zz = [Zulvf1;Zulvf2;Zulvf3;Zulvf4;Zulvf1];


figure(5)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('ULVF')

%% Below is averaged procrustes value across particpants... URVF trapezoid
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccRVF\URVFProcrustes.mat')


Xurvf = [URVFP.Resp(:,3),URVFP.Resp(:,4)];
Yurvf = [URVFP.Resp(:,1),URVFP.Resp(:,2)];
D = procrustes(Xurvf, Yurvf);
[D, Z] = procrustes(Xurvf, Yurvf);

% red Xs are the actual location, blue 
Xurvf1 = Xurvf(2,:);
Xurvf2 = Xurvf(1,:);
Xurvf3 = Xurvf(3,:);
Xurvf4 = Xurvf(4,:);

Xx = [Xurvf1;Xurvf2;Xurvf3;Xurvf4;Xurvf1];

Yurvf1 = Yurvf(2,:);
Yurvf2 = Yurvf(1,:);
Yurvf3 = Yurvf(3,:);
Yurvf4 = Yurvf(4,:);

Yy = [Yurvf1;Yurvf2;Yurvf3;Yurvf4;Yurvf1];

Zurvf1 = Z(2,:);
Zurvf2 = Z(1,:);
Zurvf3 = Z(3,:);
Zurvf4 = Z(4,:);

Zz = [Zurvf1;Zurvf2;Zurvf3;Zurvf4;Zurvf1];


figure(6)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('URVF')

%% Below is averaged procrustes value across particpants... DLVF trapezoid
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccLVF\DLVFProcrustes.mat')


Xdlvf = [DLVFP.Resp(:,3),DLVFP.Resp(:,4)];
Ydlvf = [DLVFP.Resp(:,1),DLVFP.Resp(:,2)];
D = procrustes(Xdlvf, Ydlvf);
[D, Z] = procrustes(Xdlvf, Ydlvf);

% red Xs are the actual location, blue 
Xdlvf1 = Xdlvf(2,:);
Xdlvf2 = Xdlvf(1,:);
Xdlvf3 = Xdlvf(3,:);
Xdlvf4 = Xdlvf(4,:);

Xx = [Xdlvf1;Xdlvf2;Xdlvf3;Xdlvf4;Xdlvf1];

Ydlvf1 = Ydlvf(2,:);
Ydlvf2 = Ydlvf(1,:);
Ydlvf3 = Ydlvf(3,:);
Ydlvf4 = Ydlvf(4,:);

Yy = [Ydlvf1;Ydlvf2;Ydlvf3;Ydlvf4;Ydlvf1];

Zdlvf1 = Z(2,:);
Zdlvf2 = Z(1,:);
Zdlvf3 = Z(3,:);
Zdlvf4 = Z(4,:);

Zz = [Zdlvf1;Zdlvf2;Zdlvf3;Zdlvf4;Zdlvf1];

figure(7)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('DLVF')

%% Below is averaged procrustes value across particpants... DRVF trapezoid
load('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccRVF\DRVFProcrustes.mat')


Xdrvf = [DRVFP.Resp(:,3),DRVFP.Resp(:,4)];
Ydrvf = [DRVFP.Resp(:,1),DRVFP.Resp(:,2)];
D = procrustes(Xdrvf, Ydrvf);
[D, Z] = procrustes(Xdrvf, Ydrvf);

% red Xs are the actual location, blue 
Xdrvf1 = Xdrvf(2,:);
Xdrvf2 = Xdrvf(1,:);
Xdrvf3 = Xdrvf(3,:);
Xdrvf4 = Xdrvf(4,:);

Xx = [Xdrvf1;Xdrvf2;Xdrvf3;Xdrvf4;Xdrvf1];

Ydrvf1 = Ydrvf(2,:);
Ydrvf2 = Ydrvf(1,:);
Ydrvf3 = Ydrvf(3,:);
Ydrvf4 = Ydrvf(4,:);

Yy = [Ydrvf1;Ydrvf2;Ydrvf3;Ydrvf4;Ydrvf1];

Zdrvf1 = Z(2,:);
Zdrvf2 = Z(1,:);
Zdrvf3 = Z(3,:);
Zdrvf4 = Z(4,:);

Zz = [Zdrvf1;Zdrvf2;Zdrvf3;Zdrvf4;Zdrvf1];

figure(8)

plot(Xx(:,1),Xx(:,2),'rx-', Yy(:,1), Yy(:,2), 'b.-', Zz(:,1),Zz(:,2),'bx--')

axis equal
title('DRVF')