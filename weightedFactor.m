%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PCA Rotated Components to Factor to Individual Score -- Reconstruction %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% In this script, I will outline how I take the weights under the
% two components extracted from PCA and apply them to creating factors for
% each participant, then found individual factors for each condition per
% participant.

% Firstly, when I run PCA in SPSS, I exported the file to PCA.xlsx* so I
% can manually copy and paste the components into MATLAB and create a data
% file .mat containing the rotated components and the corresponding
% weights. The way I did that was by creating variable 1 which was
% firstComp = [], and then copied the list into the [] directly. The same
% thing was done for secondComp = []. I then created a dataframe called
% Components = [firstComp,secondComp] and saved it to my data files.
% See below (comented out) how it was done:

%% Creating Components data set

% firstComp = [0.892, 0.851, 0.918, 0.518, -0.669, 0.933, 0.057];
% firstComp = firstComp';
% secondComp = [0.1890, 0.2830, -0.0770, 0.7940, 0.7070, -0.2800, -0.9900];
% secondComp = secondComp';
% dataPCA.weights = [firstComp,secondComp];
% OR could just copy and paste the dataset as is in --> variable = [HERE]
% save('C:\Users\14169\Documents\EyeTracking Files\Principle Component Analysis Files\RotatedComponents.mat','dataPCA');

%% I have additional participants, now 3 components out of the PCA. 
% Below is the save path for new dataset
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\Comp2Fac.mat','dataPCA')


% Next, I want to save my dataset, which is the data from my PCA input into
% the Comp2Fac.mat file. 
% To do this, I created a variable, e.g. dataPCA.stdx = [list of values],
% then saved it using the same line of code used in creating components
% section. The same is done for all the other 6 conditions.

%% Load data 
% load(['C:\Users\14169\Documents\EyeTracking Files\Principle Component Analysis Files\RotatedComponents.mat']);

%% I now want to multiply the weights by the appropriate dependent value

% Initialize Variables
conditionNum = 7;

weightedOne = [];
weightedTwo = [];
weightedThree = [];

for i = 1:conditionNum
    
    % below chooses the particular factor's weight and multiplies it by the
    % factor's column of participant values for the factor
    
    % This is for component 1:
    wcompOne = dataPCA.weights(i,1) * dataPCA.components(:,i);
    weightedOne = [weightedOne,wcompOne];
    
    % This is for component 2:
    wcompTwo = dataPCA.weights(i,2) * dataPCA.components(:,i);
    weightedTwo = [weightedTwo, wcompTwo];
    
    % This is for component 3:
    wcompThree = dataPCA.weights(i,3) * dataPCA.components(:,i);
    weightedThree = [weightedThree, wcompThree];
    
end

% Then I sum up the values = the factor, and add the factors to a list
% of all the participant factors

subNum = 35;

ptcpFactorOne = [];
ptcpFactorTwo = [];
ptcpFactorThree = [];

for i = 1:subNum
    
    % This is for component 1
    factorOne = sum(weightedOne(i,:));
    ptcpFactorOne = [ptcpFactorOne;factorOne];
    
    % This is for component 2
    factorTwo = sum(weightedTwo(i,:));
    ptcpFactorTwo = [ptcpFactorTwo;factorTwo];
    
    % This is for component 3
    factorThree = sum(weightedThree(i,:));
    ptcpFactorThree = [ptcpFactorThree;factorThree];
    
end

% Below will combine the component one and component two in the same variable separated by columns
% The first compoent is ptcpFactorOne, and the second is ptcpFactorTwo

% dataPCA.factorptcp = [ptcpFactorOne,ptcpFactorTwo];

%save('C:\Users\14169\Documents\EyeTracking Files\Principle Component Analysis Files\RotatedComponents.mat','dataPCA');

%% Weighted conditions in stdx factor

% The following will use the the weight calculated from the PCA for stdx
% and multiply it by each stdx value for each participant for each
% condition.

% dataPCA.stdx
dataPCA.stdx(:,1)

% Component One (stdxOne) and Two (stdxTwo):
iterCondition = 8;
dataPCA.WeightedStdxOne = [];
dataPCA.WeightedStdxTwo = [];
dataPCA.WeightedStdxThree = [];

for i = 1:iterCondition 
    
    stdxOne = dataPCA.weights(1) * dataPCA.stdx(:,i);
    stdxTwo = dataPCA.weights(8) * dataPCA.stdx(:,i);
    stdxThree = dataPCA.weights(15) * dataPCA.stdx(:,i);
    
    dataPCA.WeightedStdxOne = [dataPCA.WeightedStdxOne,stdxOne];
    dataPCA.WeightedStdxTwo = [dataPCA.WeightedStdxTwo,stdxTwo];
    dataPCA.WeightedStdxThree = [dataPCA.WeightedStdxThree,stdxThree];

end

% NOW I must create a weighted ___ One, Two and Three for each condition:

iterCondition = 8;

dataPCA.WeightedStdyOne = []; dataPCA.WeightedStdyTwo = []; dataPCA.WeightedStdyThree = [];

dataPCA.WeightedRotationOne = []; dataPCA.WeightedRotationTwo = []; dataPCA.WeightedRotationThree = [];

dataPCA.WeightedTranslationxOne = []; dataPCA.WeightedTranslationxTwo = []; dataPCA.WeightedTranslationxThree = [];

dataPCA.WeightedTranslationyOne = []; dataPCA.WeightedTranslationyTwo = []; dataPCA.WeightedTranslationyThree = [];

dataPCA.WeightedDOne = []; dataPCA.WeightedDTwo = []; dataPCA.WeightedDThree = [];

dataPCA.WeightedScalingOne = []; dataPCA.WeightedScalingTwo = [];  dataPCA.WeightedScalingThree = [];


for i = 1:iterCondition 
    
    % Weighted stdy values per component
    
    stdyOne = dataPCA.weights(2) * dataPCA.stdy(:,i);
    stdyTwo = dataPCA.weights(9) * dataPCA.stdy(:,i);
    stdyThree = dataPCA.weights(16) * dataPCA.stdy(:,i);
    
    dataPCA.WeightedStdyOne = [dataPCA.WeightedStdyOne,stdyOne];
    dataPCA.WeightedStdyTwo = [dataPCA.WeightedStdyTwo,stdyTwo];
    dataPCA.WeightedStdyThree = [dataPCA.WeightedStdyThree,stdyThree];
    
    % Weighted rotation values per component
    
    rotationOne = dataPCA.weights(3) * dataPCA.rotation(:,i);
    rotationTwo = dataPCA.weights(10) * dataPCA.rotation(:,i);
    rotationThree = dataPCA.weights(17) * dataPCA.rotation(:,i);
    
    dataPCA.WeightedRotationOne = [dataPCA.WeightedRotationOne,rotationOne];
    dataPCA.WeightedRotationTwo = [dataPCA.WeightedRotationTwo,rotationTwo];
    dataPCA.WeightedRotationThree = [dataPCA.WeightedRotationThree,rotationThree];
    
    % Weighted translationx values per component
    
    translationxOne = dataPCA.weights(4) * dataPCA.translationx(:,i);
    translationxTwo = dataPCA.weights(11) * dataPCA.translationx(:,i);
    translationxThree = dataPCA.weights(18) * dataPCA.translationx(:,i);
    
    dataPCA.WeightedTranslationxOne = [dataPCA.WeightedTranslationxOne,translationxOne];
    dataPCA.WeightedTranslationxTwo = [dataPCA.WeightedTranslationxTwo,translationxTwo];
    dataPCA.WeightedTranslationxThree = [dataPCA.WeightedTranslationxThree,translationxThree];
    
    % Weighted translationy values per component
    
    translationyOne = dataPCA.weights(5) * dataPCA.translationy(:,i);
    translationyTwo = dataPCA.weights(12) * dataPCA.translationy(:,i);
    translationyThree = dataPCA.weights(19) * dataPCA.translationy(:,i);
    
    dataPCA.WeightedTranslationyOne = [dataPCA.WeightedTranslationyOne,translationyOne];
    dataPCA.WeightedTranslationyTwo = [dataPCA.WeightedTranslationyTwo,translationyTwo];
    dataPCA.WeightedTranslationyThree = [dataPCA.WeightedTranslationyThree,translationyThree];
    
    % Weighted dVal values per component
    
    dvalOne = dataPCA.weights(6) * dataPCA.d(:,i);
    dvalTwo = dataPCA.weights(13) * dataPCA.d(:,i);
    dvalThree = dataPCA.weights(20) * dataPCA.d(:,i);
    
    dataPCA.WeightedDOne = [dataPCA.WeightedDOne,dvalOne];
    dataPCA.WeightedDTwo = [dataPCA.WeightedDTwo,dvalTwo];
    dataPCA.WeightedDThree = [dataPCA.WeightedDThree,dvalThree];
    
    % Weighted scaling values per component
    
    scalingvalOne = dataPCA.weights(7) * dataPCA.scaling(:,i);
    scalingvalTwo = dataPCA.weights(14) * dataPCA.scaling(:,i);
    scalingvalThree = dataPCA.weights(21) * dataPCA.scaling(:,i);
    
    dataPCA.WeightedScalingOne = [dataPCA.WeightedScalingOne,scalingvalOne];
    dataPCA.WeightedScalingTwo = [dataPCA.WeightedScalingTwo,scalingvalTwo];
    dataPCA.WeightedScalingThree = [dataPCA.WeightedScalingThree,scalingvalThree];
    
end

% save('C:\Users\14169\Documents\EyeTracking Files\Principle Component Analysis Files\RotatedComponents.mat','dataPCA');


%% Now I want to find an individual factor per condition per participant
%%% After multiplying the weighted value by the corresponding matrix %%%
% Using dataPCA.stdx, dataPCA.stdyVal, dataPCA.procrustesDval,
% dataPCA.translatexVal, dataPCA.translateyVal, dataPCA.scalingVal
% and dataPCA.rotationVal matrices, I will add up all the matrices to
% calculate individual factor scores.

dataPCA.factorOne = dataPCA.WeightedStdxOne + dataPCA.WeightedStdyOne + dataPCA.WeightedRotationOne + dataPCA.WeightedTranslationxOne + dataPCA.WeightedTranslationyOne + dataPCA.WeightedDOne + dataPCA.WeightedScalingOne;

dataPCA.factorTwo = dataPCA.WeightedStdxTwo + dataPCA.WeightedStdyTwo + dataPCA.WeightedRotationTwo + dataPCA.WeightedTranslationxTwo + dataPCA.WeightedTranslationyTwo + dataPCA.WeightedDTwo + dataPCA.WeightedScalingTwo;

dataPCA.factorThree = dataPCA.WeightedStdxThree + dataPCA.WeightedStdyThree + dataPCA.WeightedRotationThree + dataPCA.WeightedTranslationxThree + dataPCA.WeightedTranslationyThree + dataPCA.WeightedDThree + dataPCA.WeightedScalingThree;

% save('C:\Users\14169\Documents\EyeTracking Files\Principle Component Analysis Files\RotatedComponents.mat','dataPCA');

% What I did first was I multiplied the weight from the rotated components
% by the corresponding matrix condition (e.g. the weight for stdx from the
% PCA by the stdx matrix containing the standard deviation x for all 8
% conditions separately, for each participant (35X8 matrix). Then, I added
% the weighted matrices (e.g weight*stdx + weight*stdy...) to get 8 factor
% scores (separate factors for each experimental condition) for each
% participant (such that there is a 35X8 matrix of factors for each
% component. Then I conducted an ANOVA for the 3 factors' matrices.

nSub = 35;

fOne = [];
fTwo = [];
fThree = [];

for i = 1:nSub
    averageOne = mean(dataPCA.factorOne(i,:));
    averageTwo = mean(dataPCA.factorTwo(i,:));
    averageThree = mean(dataPCA.factorThree(i,:));
    
    fOne = [fOne;averageOne];
    fTwo = [fTwo;averageTwo];
    fThree = [fThree;averageThree];
end

dataPCA.factoredData = [fOne,fTwo,fThree];

% save('C:\Users\14169\Documents\EyeTracking Files\Principle Component Analysis Files\RotatedComponents.mat','dataPCA');
