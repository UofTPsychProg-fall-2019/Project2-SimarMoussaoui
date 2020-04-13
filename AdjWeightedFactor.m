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

%% I have additional participants, now 3 components out of the PCA. 
% Below is the save path for new dataset
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\AdjComp2Fac.mat','adjPCA')


% Next, I want to save my dataset, which is the data from my PCA input into
% the Comp2Fac.mat file. 
% To do this, I created a variable, e.g. adjPCA.stdx = [list of values],
% then saved it using the same line of code used in creating components
% section. The same is done for all the other 6 conditions.

%% Load data 
% load(['C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\AdjComp2Fac.mat']);

%% I now want to multiply the weights by the appropriate dependent value

% Initialize Variables
conditionNum = 7;

weightedOne = [];
weightedTwo = [];

for i = 1:conditionNum
    
    % below chooses the particular factor's weight and multiplies it by the
    % factor's column of participant values for the factor
    
    % This is for component 1:
    wcompOne = adjPCA.weights(i,1) * adjPCA.components(:,i);
    weightedOne = [weightedOne,wcompOne];
    
    % This is for component 2:
    wcompTwo = adjPCA.weights(i,2) * adjPCA.components(:,i);
    weightedTwo = [weightedTwo, wcompTwo];
    
end

% Then I sum up the values = the factor, and add the factors to a list
% of all the participant factors

subNum = 35;

ptcpFactorOne = [];
ptcpFactorTwo = [];

for i = 1:subNum
    
    % This is for component 1
    factorOne = sum(weightedOne(i,:));
    ptcpFactorOne = [ptcpFactorOne;factorOne];
    
    % This is for component 2
    factorTwo = sum(weightedTwo(i,:));
    ptcpFactorTwo = [ptcpFactorTwo;factorTwo];
    
    
end

% Below will combine the component one and component two in the same variable separated by columns
% The first compoent is ptcpFactorOne, and the second is ptcpFactorTwo

% adjPCA.factorptcp = [ptcpFactorOne,ptcpFactorTwo];

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\AdjComp2Fac.mat','adjPCA')

%% Weighted conditions in stdx factor

% The following will use the the weight calculated from the PCA for stdx
% and multiply it by each stdx value for each participant for each
% condition.

% sanity check: adjPCA.stdx first condition
adjPCA.stdx(:,1)

% Component One (stdxOne) and Two (stdxTwo):
iterCondition = 8;
adjPCA.WeightedStdxOne = [];
adjPCA.WeightedStdxTwo = [];

for i = 1:iterCondition 
    
    % Iterating through each condition and multiplying by the appropriate
    % weight
    stdxOne = adjPCA.weights(1) * adjPCA.stdx(:,i);
    stdxTwo = adjPCA.weights(8) * adjPCA.stdx(:,i);
    
    adjPCA.WeightedStdxOne = [adjPCA.WeightedStdxOne,stdxOne];
    adjPCA.WeightedStdxTwo = [adjPCA.WeightedStdxTwo,stdxTwo];

end

% NOW I must create a weighted ___ One, Two and Three for each condition:

iterCondition = 8;

adjPCA.WeightedStdyOne = []; adjPCA.WeightedStdyTwo = [];

adjPCA.WeightedRotationOne = []; adjPCA.WeightedRotationTwo = [];

adjPCA.WeightedTranslationxOne = []; adjPCA.WeightedTranslationxTwo = []; 

adjPCA.WeightedTranslationyOne = []; adjPCA.WeightedTranslationyTwo = []; 

adjPCA.WeightedDOne = []; adjPCA.WeightedDTwo = [];

adjPCA.WeightedScalingOne = []; adjPCA.WeightedScalingTwo = [];  

for i = 1:iterCondition 
    
    % Weighted stdy values per component
    
    stdyOne = adjPCA.weights(2) * adjPCA.stdy(:,i);
    stdyTwo = adjPCA.weights(9) * adjPCA.stdy(:,i);
    
    adjPCA.WeightedStdyOne = [adjPCA.WeightedStdyOne,stdyOne];
    adjPCA.WeightedStdyTwo = [adjPCA.WeightedStdyTwo,stdyTwo];
    
    % Weighted rotation values per component
    
    rotationOne = adjPCA.weights(3) * adjPCA.rotation(:,i);
    rotationTwo = adjPCA.weights(10) * adjPCA.rotation(:,i);
    
    adjPCA.WeightedRotationOne = [adjPCA.WeightedRotationOne,rotationOne];
    adjPCA.WeightedRotationTwo = [adjPCA.WeightedRotationTwo,rotationTwo];
    
    % Weighted translationx values per component
    
    translationxOne = adjPCA.weights(4) * adjPCA.translationx(:,i);
    translationxTwo = adjPCA.weights(11) * adjPCA.translationx(:,i);
    
    adjPCA.WeightedTranslationxOne = [adjPCA.WeightedTranslationxOne,translationxOne];
    adjPCA.WeightedTranslationxTwo = [adjPCA.WeightedTranslationxTwo,translationxTwo];
    
    % Weighted translationy values per component
    
    translationyOne = adjPCA.weights(5) * adjPCA.translationy(:,i);
    translationyTwo = adjPCA.weights(12) * adjPCA.translationy(:,i);
    
    adjPCA.WeightedTranslationyOne = [adjPCA.WeightedTranslationyOne,translationyOne];
    adjPCA.WeightedTranslationyTwo = [adjPCA.WeightedTranslationyTwo,translationyTwo];
    
    % Weighted dVal values per component
    
    dvalOne = adjPCA.weights(6) * adjPCA.d(:,i);
    dvalTwo = adjPCA.weights(13) * adjPCA.d(:,i);
    
    adjPCA.WeightedDOne = [adjPCA.WeightedDOne,dvalOne];
    adjPCA.WeightedDTwo = [adjPCA.WeightedDTwo,dvalTwo];
    
    % Weighted scaling values per component
    
    scalingvalOne = adjPCA.weights(7) * adjPCA.scaling(:,i);
    scalingvalTwo = adjPCA.weights(14) * adjPCA.scaling(:,i);
    
    adjPCA.WeightedScalingOne = [adjPCA.WeightedScalingOne,scalingvalOne];
    adjPCA.WeightedScalingTwo = [adjPCA.WeightedScalingTwo,scalingvalTwo];
    
end

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\AdjComp2Fac.mat','adjPCA')


%% Now I want to find an individual factor per condition per participant
%%% After multiplying the weighted value by the corresponding matrix %%%
% Using adjPCA.stdx, adjPCA.stdyVal, adjPCA.procrustesDval,
% adjPCA.translatexVal, adjPCA.translateyVal, adjPCA.scalingVal
% and adjPCA.rotationVal matrices, I will add up all the matrices to
% calculate individual factor scores.

adjPCA.factorOne = adjPCA.WeightedStdxOne + adjPCA.WeightedStdyOne + adjPCA.WeightedRotationOne + adjPCA.WeightedTranslationxOne + adjPCA.WeightedTranslationyOne + adjPCA.WeightedDOne + adjPCA.WeightedScalingOne;

adjPCA.factorTwo = adjPCA.WeightedStdxTwo + adjPCA.WeightedStdyTwo + adjPCA.WeightedRotationTwo + adjPCA.WeightedTranslationxTwo + adjPCA.WeightedTranslationyTwo + adjPCA.WeightedDTwo + adjPCA.WeightedScalingTwo;

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\AdjComp2Fac.mat','adjPCA')

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
    averageOne = mean(adjPCA.factorOne(i,:));
    averageTwo = mean(adjPCA.factorTwo(i,:));
    
    fOne = [fOne;averageOne];
    fTwo = [fTwo;averageTwo];
end

adjPCA.factoredData = [fOne,fTwo];

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\PCA\AdjComp2Fac.mat','adjPCA')
