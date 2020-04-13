%%    Segmenting Data per condition to submit to Procrustes D  - Left    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% I want to reset my workspace and command window
close all; clear; clc;
% fprintf

%% Initialize variables
subs = [2,4,5,7,8,9,11,14,15,23,26,30,32,34,35,36,37,38,39,41,42,43,44,48,50,52,53,54,57,58,59,60,65,68,71];
%subs = [2,4,5,7,8,9,11,14,15,23,26,30,32,34,35,36,37,38,39,41,42,43,44];
%subs = [42];
nSubs = length(subs);
outlier_thresh = 3;

%% Conditional variables
do_plot = 0; %1 if plot, 0 if no plot.
vh_plot = 0; %1 if plot vorh for clusters, 0 if no plot vorh
rl_plot = 0; %1 if plot LorR, 0 if no plot

%% Segment data into clusters and conditions
for iSub = 1:nSubs
    % Need to loop through 3 blocks:
    blocks = [1,2,3];

    for iBlock = 1:length(blocks)
        %% Load data
        load(['C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\SMptcp',num2str(subs(iSub)),'\block',num2str(blocks(iBlock)),'\TSWM.mat']);
        %% Remove Jitter & integrate X and Y to create 8 unique location identifier array
        theData.StimLocNoJitterX = theData.selXingsX - theData.stimJitterX;
        theData.StimLocNoJitterY = theData.selXingsY - theData.stimJitterY;
        theData.RespLocNoJitterX = theData.responseX - theData.stimJitterX;
        theData.RespLocNoJitterY = theData.responseY - theData.stimJitterY;
        % Below gives each coordinate for every trial a unique value in order
        % to separate out the clusters:
        theData.uniqueLocXY = round(sqrt((theData.StimLocNoJitterX.^2) + (theData.StimLocNoJitterY.^2)),2);
        
        uniqueLocs = unique(theData.uniqueLocXY);
        [colours,~,~] = brewermap(length(uniqueLocs),'Set1'); %Change 'Set1' to something else if you want.
        [others,~,~] = brewermap(length(uniqueLocs),'Greys'); %Change 'Greys' to something else if you want.
        
        for i = 1:length(uniqueLocs)
            
            % plot a specific response cluster
            iClusterX = theData.RespLocNoJitterX(theData.uniqueLocXY==uniqueLocs(i));
            iClusterY = theData.RespLocNoJitterY(theData.uniqueLocXY==uniqueLocs(i));
            
            %%%%%%%%%%%%%%%%%%%% LEFT SACCADES RVF LVF %%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % leftVal is all the unique values for leftwards saccades
            % (denoted 1 in variable LorR)
            leftVal = theData.uniqueLocXY(theData.LorR == 1);
            % ileftClusterX finds the responses in theData that include left saccades 
            ileftClusterX = theData.RespLocNoJitterX(theData.LorR == 1); %Response
            iLCx = ileftClusterX(leftVal == uniqueLocs(i)); % separated per cluster
            
            ileftClusterY = theData.RespLocNoJitterY(theData.LorR == 1);
            iLCy = ileftClusterY(leftVal == uniqueLocs(i));
            
            % Find the actual stimulus location for the above selected
            % points
            iXcluster = theData.StimLocNoJitterX(theData.LorR == 1); %Actual location
            ilClusterX = iXcluster(leftVal == uniqueLocs(i)); %separated per cluster
            
            iYcluster = theData.StimLocNoJitterY(theData.LorR == 1); %Actual location
            ilClusterY = iYcluster(leftVal == uniqueLocs(i)); %separated per cluster
            
            % Creating variables LVF and RVF for Left Saccades
            LVFlx = []; LVFly = [];RVFlx = []; RVFly = []; %creating an empty
            % list for all the below variables because it wont plot if the
            % variable doesnt exist first.
            LVFactualx = []; LVFactualy = []; RVFactualx = []; RVFactualy = [];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
            %%%%%%%%%%%%%%%%%%%% RIGHT SACCADE RVF LVF %%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % rightVal is all the unique values for leftwards saccades
            % (denoted 1 in variable LorR)
            rightVal = theData.uniqueLocXY(theData.LorR == -1);
            % ileftClusterX finds the responses in theData that include left saccades 
            irightClusterX = theData.RespLocNoJitterX(theData.LorR == -1); %Response
            iRCx = irightClusterX(rightVal == uniqueLocs(i)); % separated per cluster
            
            irightClusterY = theData.RespLocNoJitterY(theData.LorR == -1);
            iRCy = irightClusterY(rightVal == uniqueLocs(i));
            
            % Find the actual stimulus location for the above selected
            % points
            irXcluster = theData.StimLocNoJitterX(theData.LorR == -1); %Actual location
            irClusterX = irXcluster(rightVal == uniqueLocs(i)); %separated per cluster
            
            irYcluster = theData.StimLocNoJitterY(theData.LorR == -1); %Actual location
            irClusterY = irYcluster(rightVal == uniqueLocs(i)); %separated per cluster
            
            % Creating variables LVF and RVF for Right Saccades
            LVFrx = []; LVFry = [];RVFrx = []; RVFry = []; %creating an empty
            % list for all the below variables because it wont plot if the
            % variable doesnt exist first.
            LVFactualrx = []; LVFactualry = []; RVFactualrx = []; RVFactualry = [];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            if i == 1
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                LVFly = ileftClusterY(leftVal == uniqueLocs(i));
                LVFactualx = ilClusterX; %might be redundant but I want to
                %manipulate iCluster differently depending on VF
                LVFactualy = ilClusterY;
                %Below, save the data for each cluster in a variable
                respClOneLVFx = LVFlx;
                respClOneLVFy = LVFly;
                actClOneLVFx = LVFactualx;
                actClOneLVFy = LVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFrx = irightClusterX(rightVal == uniqueLocs(i));
                LVFry = irightClusterY(rightVal == uniqueLocs(i));
                LVFactualrx = irClusterX; %might be redundant but I want to
                %manipulate iCluster differently depending on VF
                LVFactualry = irClusterY;
                %Below, save the data for each cluster in a variable
                respCrOneLVFx = LVFrx;
                respCrOneLVFy = LVFry;
                actCrOneLVFx = LVFactualrx;
                actCrOneLVFy = LVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            elseif i == 2
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                LVFly = ileftClusterY(leftVal == uniqueLocs(i));
                LVFactualx = ilClusterX;
                LVFactualy = ilClusterY;
                respClTwoLVFx = LVFlx;
                respClTwoLVFy = LVFly;
                actClTwoLVFx = LVFactualx;
                actClTwoLVFy = LVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFrx = irightClusterX(rightVal == uniqueLocs(i));
                LVFry = irightClusterY(rightVal == uniqueLocs(i));
                LVFactualrx = irClusterX;
                LVFactualry = irClusterY;
                respCrTwoLVFx = LVFrx;
                respCrTwoLVFy = LVFry;
                actCrTwoLVFx = LVFactualrx;
                actCrTwoLVFy = LVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif i == 3
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                LVFly = ileftClusterY(leftVal == uniqueLocs(i));
                LVFactualx = ilClusterX;
                LVFactualy = ilClusterY;
                respClThreeLVFx = LVFlx;
                respClThreeLVFy = LVFly;
                actClThreeLVFx = LVFactualx;
                actClThreeLVFy = LVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFrx = irightClusterX(rightVal == uniqueLocs(i));
                LVFry = irightClusterY(rightVal == uniqueLocs(i));
                LVFactualrx = irClusterX; 
                LVFactualry = irClusterY;
                respCrThreeLVFx = LVFrx;
                respCrThreeLVFy = LVFry;
                actCrThreeLVFx = LVFactualrx;
                actCrThreeLVFy = LVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            elseif i == 4
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                RVFly = ileftClusterY(leftVal == uniqueLocs(i));
                RVFactualx = ilClusterX;
                RVFactualy = ilClusterY;
                respClFourRVFx = RVFlx;
                respClFourRVFy = RVFly;
                actClFourRVFx = RVFactualx;
                actClFourRVFy = RVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFrx = irightClusterX(rightVal == uniqueLocs(i));
                RVFry = irightClusterY(rightVal == uniqueLocs(i));
                RVFactualrx = irClusterX;
                RVFactualry = irClusterY;
                respCrFourRVFx = RVFrx;
                respCrFourRVFy = RVFry;
                actCrFourRVFx = RVFactualrx;
                actCrFourRVFy = RVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                
            elseif i == 5
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                LVFly = ileftClusterY(leftVal == uniqueLocs(i));
                LVFactualx = ilClusterX;
                LVFactualy = ilClusterY;
                respClFiveLVFx = LVFlx;
                respClFiveLVFy = LVFly;
                actClFiveLVFx = LVFactualx;
                actClFiveLVFy = LVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFrx = irightClusterX(rightVal == uniqueLocs(i));
                LVFry = irightClusterY(rightVal == uniqueLocs(i));
                LVFactualrx = irClusterX;
                LVFactualry = irClusterY;
                respCrFiveLVFx = LVFrx;
                respCrFiveLVFy = LVFry;
                actCrFiveLVFx = LVFactualrx;
                actCrFiveLVFy = LVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
            elseif i == 6
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                RVFly = ileftClusterY(leftVal == uniqueLocs(i));
                RVFactualx = ilClusterX;
                RVFactualy = ilClusterY;
                respClSixRVFx = RVFlx;
                respClSixRVFy = RVFly;
                actClSixRVFx = RVFactualx;
                actClSixRVFy = RVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFrx = irightClusterX(rightVal == uniqueLocs(i));
                RVFry = irightClusterY(rightVal == uniqueLocs(i));
                RVFactualrx = irClusterX;
                RVFactualry = irClusterY;
                respCrSixRVFx = RVFrx;
                respCrSixRVFy = RVFry;
                actCrSixRVFx = RVFactualrx;
                actCrSixRVFy = RVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            elseif i == 7
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                RVFly = ileftClusterY(leftVal == uniqueLocs(i));
                RVFactualx = ilClusterX;
                RVFactualy = ilClusterY;
                respClSevenRVFx = RVFlx;
                respClSevenRVFy = RVFly;
                actClSevenRVFx = RVFactualx;
                actClSevenRVFy = RVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFrx = irightClusterX(rightVal == uniqueLocs(i));
                RVFry = irightClusterY(rightVal == uniqueLocs(i));
                RVFactualrx = irClusterX;
                RVFactualry = irClusterY;
                respCrSevenRVFx = RVFrx;
                respCrSevenRVFy = RVFry;
                actCrSevenRVFx = RVFactualrx;
                actCrSevenRVFy = RVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif i == 8
                
                %%%%%%%%%%%%%%%%%%%% LEFTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFlx = ileftClusterX(leftVal == uniqueLocs(i));
                RVFly = ileftClusterY(leftVal == uniqueLocs(i));
                RVFactualx = ilClusterX;
                RVFactualy = ilClusterY;
                respClEightRVFx = RVFlx;
                respClEightRVFy = RVFly;
                actClEightRVFx = RVFactualx;
                actClEightRVFy = RVFactualy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RIGHTWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFrx = irightClusterX(rightVal == uniqueLocs(i));
                RVFry = irightClusterY(rightVal == uniqueLocs(i));
                RVFactualrx = irClusterX;
                RVFactualry = irClusterY;
                respCrEightRVFx = RVFrx;
                respCrEightRVFy = RVFry;
                actCrEightRVFx = RVFactualrx;
                actCrEightRVFy = RVFactualry;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            % Now want to create lists for each block's x, y response and
            % actual coordinates:
            
            if iBlock == 1
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                LLVFOneBiRx = [respClOneLVFx];
                LLVFOneBiRY = [respClOneLVFy];
                LLVFOneBiAx = [actClOneLVFx];
                LLVFOneBiAY = [actClOneLVFy];
                
                LLVFTwoBiRx = [respClTwoLVFx];
                LLVFTwoBiRY = [respClTwoLVFy];
                LLVFTwoBiAx = [actClTwoLVFx];
                LLVFTwoBiAY = [actClTwoLVFy];
                
                LLVFThreeBiRx = [respClThreeLVFx];
                LLVFThreeBiRY = [respClThreeLVFy];
                LLVFThreeBiAx = [actClThreeLVFx];
                LLVFThreeBiAY = [actClThreeLVFy];
                
                LLVFFiveBiRx = [respClFiveLVFx];
                LLVFFiveBiRY = [respClFiveLVFy];
                LLVFFiveBiAx = [actClFiveLVFx];
                LLVFFiveBiAY = [actClFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                LRVFFourBiRx = [respClFourRVFx];
                LRVFFourBiRY = [respClFourRVFy];
                LRVFFourBiAx = [actClFourRVFx];
                LRVFFourBiAY = [actClFourRVFy];
                
                LRVFSixBiRx = [respClSixRVFx];
                LRVFSixBiRY = [respClSixRVFy];
                LRVFSixBiAx = [actClSixRVFx];
                LRVFSixBiAY = [actClSixRVFy];
                
                LRVFSevenBiRx = [respClSevenRVFx];
                LRVFSevenBiRY = [respClSevenRVFy];
                LRVFSevenBiAx = [actClSevenRVFx];
                LRVFSevenBiAY = [actClSevenRVFy];
                
                LRVFEightBiRx = [respClEightRVFx];
                LRVFEightBiRY = [respClEightRVFy];
                LRVFEightBiAx = [actClEightRVFx];
                LRVFEightBiAY = [actClEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
            end
            
            if iBlock == 2
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                LLVFOneBiiRx = [respClOneLVFx];
                LLVFOneBiiRY = [respClOneLVFy];
                LLVFOneBiiAx = [actClOneLVFx];
                LLVFOneBiiAY = [actClOneLVFy];
                
                LLVFTwoBiiRx = [respClTwoLVFx];
                LLVFTwoBiiRY = [respClTwoLVFy];
                LLVFTwoBiiAx = [actClTwoLVFx];
                LLVFTwoBiiAY = [actClTwoLVFy];
                
                LLVFThreeBiiRx = [respClThreeLVFx];
                LLVFThreeBiiRY = [respClThreeLVFy];
                LLVFThreeBiiAx = [actClThreeLVFx];
                LLVFThreeBiiAY = [actClThreeLVFy];
                
                LLVFFiveBiiRx = [respClFiveLVFx];
                LLVFFiveBiiRY = [respClFiveLVFy];
                LLVFFiveBiiAx = [actClFiveLVFx];
                LLVFFiveBiiAY = [actClFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                LRVFFourBiiRx = [respClFourRVFx];
                LRVFFourBiiRY = [respClFourRVFy];
                LRVFFourBiiAx = [actClFourRVFx];
                LRVFFourBiiAY = [actClFourRVFy];
                
                LRVFSixBiiRx = [respClSixRVFx];
                LRVFSixBiiRY = [respClSixRVFy];
                LRVFSixBiiAx = [actClSixRVFx];
                LRVFSixBiiAY = [actClSixRVFy];
                
                LRVFSevenBiiRx = [respClSevenRVFx];
                LRVFSevenBiiRY = [respClSevenRVFy];
                LRVFSevenBiiAx = [actClSevenRVFx];
                LRVFSevenBiiAY = [actClSevenRVFy];
                
                LRVFEightBiiRx = [respClEightRVFx];
                LRVFEightBiiRY = [respClEightRVFy];
                LRVFEightBiiAx = [actClEightRVFx];
                LRVFEightBiiAY = [actClEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            end
            
            if iBlock == 3
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                LLVFOneBiiiRx = [respClOneLVFx];
                LLVFOneBiiiRY = [respClOneLVFy];
                LLVFOneBiiiAx = [actClOneLVFx];
                LLVFOneBiiiAY = [actClOneLVFy];
                
                LLVFTwoBiiiRx = [respClTwoLVFx];
                LLVFTwoBiiiRY = [respClTwoLVFy];
                LLVFTwoBiiiAx = [actClTwoLVFx];
                LLVFTwoBiiiAY = [actClTwoLVFy];
                
                LLVFThreeBiiiRx = [respClThreeLVFx];
                LLVFThreeBiiiRY = [respClThreeLVFy];
                LLVFThreeBiiiAx = [actClThreeLVFx];
                LLVFThreeBiiiAY = [actClThreeLVFy];
                
                LLVFFiveBiiiRx = [respClFiveLVFx];
                LLVFFiveBiiiRY = [respClFiveLVFy];
                LLVFFiveBiiiAx = [actClFiveLVFx];
                LLVFFiveBiiiAY = [actClFiveLVFy];
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                LRVFFourBiiiRx = [respClFourRVFx];
                LRVFFourBiiiRY = [respClFourRVFy];
                LRVFFourBiiiAx = [actClFourRVFx];
                LRVFFourBiiiAY = [actClFourRVFy];
                
                LRVFSixBiiiRx = [respClSixRVFx];
                LRVFSixBiiiRY = [respClSixRVFy];
                LRVFSixBiiiAx = [actClSixRVFx];
                LRVFSixBiiiAY = [actClSixRVFy];
                
                LRVFSevenBiiiRx = [respClSevenRVFx];
                LRVFSevenBiiiRY = [respClSevenRVFy];
                LRVFSevenBiiiAx = [actClSevenRVFx];
                LRVFSevenBiiiAY = [actClSevenRVFy];
                
                LRVFEightBiiiRx = [respClEightRVFx];
                LRVFEightBiiiRY = [respClEightRVFy];
                LRVFEightBiiiAx = [actClEightRVFx];
                LRVFEightBiiiAY = [actClEightRVFy];
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                              
            end
            
            end

        end
    end
    
    
    %% outlier detection and removal using euclidean distances, and calculate std of each cluster

    for i = 1:length(uniqueLocs)
        %% Concatinating the blocks together under the below categories:
        
        %%%%%%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%%%%%
        %PER CLUSTER ASSOCATED WITH VF
        LLVFRespOneXP = mean([LLVFOneBiRx,LLVFOneBiiRx, LLVFOneBiiiRx]);
        LLVFRespOneYP = mean([LLVFOneBiRY,LLVFOneBiiRY, LLVFOneBiiiRY]);
        LLVFActOneXP = mean([LLVFOneBiAx,LLVFOneBiiAx, LLVFOneBiiiAx]);
        LLVFActOneYP = mean([LLVFOneBiAY,LLVFOneBiiAY, LLVFOneBiiiAY]);
        

        LLVFRespTwoXP = mean([LLVFTwoBiRx,LLVFTwoBiiRx,LLVFTwoBiiiRx]);
        LLVFRespTwoYP = mean([LLVFTwoBiRY,LLVFTwoBiiRY,LLVFTwoBiiiRY]);
        LLVFActTwoXP = mean([LLVFTwoBiAx,LLVFTwoBiiAx,LLVFTwoBiiiAx]);
        LLVFActTwoYP = mean([LLVFTwoBiAY,LLVFTwoBiiAY,LLVFTwoBiiiAY]);
        
        LLVFRespThreeXP = mean([LLVFThreeBiRx,LLVFThreeBiiRx,LLVFThreeBiiiRx]);
        LLVFRespThreeYP = mean([LLVFThreeBiRY,LLVFThreeBiiRY,LLVFThreeBiiiRY]);
        LLVFActThreeXP = mean([LLVFThreeBiAx,LLVFThreeBiiAx,LLVFThreeBiiiAx]);
        LLVFActThreeYP = mean([LLVFThreeBiAY,LLVFThreeBiiAY,LLVFThreeBiiiAY]);
        
        LLVFRespFiveXP = mean([LLVFFiveBiRx,LLVFFiveBiiRx,LLVFFiveBiiiRx]);
        LLVFRespFiveYP = mean([LLVFFiveBiRY,LLVFFiveBiiRY,LLVFFiveBiiiRY]);
        LLVFActFiveXP = mean([LLVFFiveBiAx,LLVFFiveBiiAx,LLVFFiveBiiiAx]);
        LLVFActFiveYP = mean([LLVFFiveBiAY,LLVFFiveBiiAY,LLVFFiveBiiiAY]);
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%%%%%        
        LRVFRespFourXP = mean([LRVFFourBiRx,LRVFFourBiiRx, LRVFFourBiiiRx]);
        LRVFRespFourYP = mean([LRVFFourBiRY,LRVFFourBiiRY, LRVFFourBiiiRY]);
        LRVFActFourXP = mean([LRVFFourBiAx,LRVFFourBiiAx, LRVFFourBiiiAx]);
        LRVFActFourYP = mean([LRVFFourBiAY,LRVFFourBiiAY, LRVFFourBiiiAY]);
        
        LRVFRespSixXP = mean([LRVFSixBiRx,LRVFSixBiiRx, LRVFSixBiiiRx]);
        LRVFRespSixYP = mean([LRVFSixBiRY,LRVFSixBiiRY, LRVFSixBiiiRY]);
        LRVFActSixXP = mean([LRVFSixBiAx,LRVFSixBiiAx, LRVFSixBiiiAx]);
        LRVFActSixYP = mean([LRVFSixBiAY,LRVFSixBiiAY, LRVFSixBiiiAY]);
        
        LRVFRespSevenXP = mean([LRVFSevenBiRx,LRVFSevenBiiRx, LRVFSevenBiiiRx]);
        LRVFRespSevenYP = mean([LRVFSevenBiRY,LRVFSevenBiiRY, LRVFSevenBiiiRY]);
        LRVFActSevenXP = mean([LRVFSevenBiAx,LRVFSevenBiiAx, LRVFSevenBiiiAx]);
        LRVFActSevenYP = mean([LRVFSevenBiAY,LRVFSevenBiiAY, LRVFSevenBiiiAY]);
        
        LRVFRespEightXP = mean([LRVFEightBiRx,LRVFEightBiiRx, LRVFEightBiiiRx]);
        LRVFRespEightYP = mean([LRVFEightBiRY,LRVFEightBiiRY, LRVFEightBiiiRY]);
        LRVFActEightXP = mean([LRVFEightBiAx,LRVFEightBiiAx, LRVFEightBiiiAx]);
        LRVFActEightYP = mean([LRVFEightBiAY,LRVFEightBiiAY, LRVFEightBiiiAY]);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %% Calculate euclidean distances
        % Left Saccade LVF
        eucDistOneLLVFp = calc_eucDist(LLVFRespOneXP,LLVFActOneXP,LLVFRespOneYP,LLVFActOneYP);
        
        eucDistTwoLLVFp = calc_eucDist(LLVFRespTwoXP,LLVFActTwoXP,LLVFRespTwoYP,LLVFActTwoYP);
        
        eucDistThreeLLVFp = calc_eucDist(LLVFRespThreeXP,LLVFActThreeXP,LLVFRespThreeYP,LLVFActThreeYP);
        
        eucDistFiveLLVFp = calc_eucDist(LLVFRespFiveXP,LLVFActFiveXP,LLVFRespFiveYP,LLVFActFiveYP);
        
        % Left Saccade RVF
        eucDistFourLRVFp = calc_eucDist(LRVFRespFourXP,LRVFActFourXP,LRVFRespFourYP,LRVFActFourYP);
        
        eucDistSixLRVFp = calc_eucDist(LRVFRespSixXP,LRVFActSixXP,LRVFRespSixYP,LRVFActSixYP);
        
        eucDistSevenLRVFp = calc_eucDist(LRVFRespSevenXP,LRVFActSevenXP,LRVFRespSevenYP,LRVFActSevenYP);
        
        eucDistEightLRVFp = calc_eucDist(LRVFRespEightXP,LRVFActEightXP,LRVFRespEightYP,LRVFActEightYP);

        %% z-transform
        
        % Left Saccade LVF
        z_eucDistLLVFOnep = zscore(eucDistOneLLVFp);
        z_eucDistLLVFTwop = zscore(eucDistTwoLLVFp);
        z_eucDistLLVFThreep = zscore(eucDistThreeLLVFp);
        z_eucDistLLVFFivep = zscore(eucDistFiveLLVFp);
        
        % Left Saccade RVF        
        z_eucDistLRVFFourp = zscore(eucDistFourLRVFp);
        z_eucDistLRVFSixp = zscore(eucDistSixLRVFp);
        z_eucDistLRVFSevenp = zscore(eucDistSevenLRVFp);
        z_eucDistLRVFEightp = zscore(eucDistEightLRVFp);

        %% Remove outliers based on pre-determined threshold
        
        % LVFLeft

        LLVFRespOneXP = LLVFRespOneXP(z_eucDistLLVFOnep<outlier_thresh);
        LLVFRespOneYP = LLVFRespOneYP(z_eucDistLLVFOnep<outlier_thresh);
        
        LLVFRespTwoXP = LLVFRespTwoXP(z_eucDistLLVFTwop<outlier_thresh);
        LLVFRespTwoYP = LLVFRespTwoYP(z_eucDistLLVFTwop<outlier_thresh);
        
        LLVFRespThreeXP = LLVFRespThreeXP(z_eucDistLLVFThreep<outlier_thresh);
        LLVFRespThreeYP = LLVFRespThreeYP(z_eucDistLLVFThreep<outlier_thresh);
        
        LLVFRespFiveXP = LLVFRespFiveXP(z_eucDistLLVFFivep<outlier_thresh);
        LLVFRespFiveYP = LLVFRespFiveYP(z_eucDistLLVFFivep<outlier_thresh);
        
        % RVFLeft

        LRVFRespFourXP = LRVFRespFourXP(z_eucDistLRVFFourp<outlier_thresh);
        LRVFRespFourYP = LRVFRespFourYP(z_eucDistLRVFFourp<outlier_thresh);
        
        LRVFRespSixXP = LRVFRespSixXP(z_eucDistLRVFSixp<outlier_thresh);
        LRVFRespSixYP = LRVFRespSixYP(z_eucDistLRVFSixp<outlier_thresh);
        
        LRVFRespSevenXP = LRVFRespSevenXP(z_eucDistLRVFSevenp<outlier_thresh);
        LRVFRespSevenYP = LRVFRespSevenYP(z_eucDistLRVFSevenp<outlier_thresh);
        
        LRVFRespEightXP = LRVFRespEightXP(z_eucDistLRVFEightp<outlier_thresh);
        LRVFRespEightYP = LRVFRespEightYP(z_eucDistLRVFEightp<outlier_thresh);

      
        
    end
    
    %% loading variables with Std values:
    LLVFoneP.Resp_x(iSub,1) = [LLVFRespOneXP];
    LLVFoneP.Resp_y(iSub,1) = [LLVFRespOneYP];
    LLVFoneP.Act_x(iSub,1) = [LLVFActOneXP];
    LLVFoneP.Act_y(iSub,1) = [LLVFActOneYP];
    %LLVFone.Procrustes = [LLVFoneP.Resp_x,LLVFoneP.Resp_y,LLVFoneP.Act_x,LLVFoneP.Act_y];
    
    LLVFtwoP.Resp_x(iSub,1) = [LLVFRespTwoXP];
    LLVFtwoP.Resp_y(iSub,1) = [LLVFRespTwoYP];
    LLVFtwoP.Act_x(iSub,1) = [LLVFActTwoXP];
    LLVFtwoP.Act_y(iSub,1) = [LLVFActTwoYP];
    %LLVFtwo.Procrustes = [LLVFtwoP.Resp_x,LLVFtwoP.Resp_y,LLVFtwoP.Act_x,LLVFtwoP.Act_y];
    
    LLVFthreeP.Resp_x(iSub,1) = [LLVFRespThreeXP];
    LLVFthreeP.Resp_y(iSub,1) = [LLVFRespThreeYP];
    LLVFthreeP.Act_x(iSub,1) = [LLVFActThreeXP];
    LLVFthreeP.Act_y(iSub,1) = [LLVFActThreeYP];
    %LLVFthree.Procrustes = [LLVFthreeP.Resp_x,LLVFthreeP.Resp_y,LLVFthreeP.Act_x,LLVFthreeP.Act_y];
    
    LLVFfiveP.Resp_x(iSub,1) = [LLVFRespFiveXP];
    LLVFfiveP.Resp_y(iSub,1) = [LLVFRespFiveYP];
    LLVFfiveP.Act_x(iSub,1) = [LLVFActFiveXP];
    LLVFfiveP.Act_y(iSub,1) = [LLVFActFiveYP];
    %LLVFfive.Procrustes = [LLVFfiveP.Resp_x,LLVFfiveP.Resp_y,LLVFfiveP.Act_x,LLVFfiveP.Act_y];
    
    % Left Saccade RVF
    LRVFFourP.Resp_x(iSub,1) = [LRVFRespFourXP];
    LRVFFourP.Resp_y(iSub,1) = [LRVFRespFourYP];
    LRVFFourP.Act_x(iSub,1) = [LRVFActFourXP];
    LRVFFourP.Act_y(iSub,1) = [LRVFActFourYP];
    %LRVFFour.Procrustes = [LRVFFourP.Resp_x,LRVFFourP.Resp_y,LRVFFourP.Act_x,LRVFFourP.Act_y];
    
    LRVFSixP.Resp_x(iSub,1) = [LRVFRespSixXP];
    LRVFSixP.Resp_y(iSub,1) = [LRVFRespSixYP];
    LRVFSixP.Act_x(iSub,1) = [LRVFActSixXP];
    LRVFSixP.Act_y(iSub,1) = [LRVFActSixYP];
    
    LRVFSevenP.Resp_x(iSub,1) = [LRVFRespSevenXP];
    LRVFSevenP.Resp_y(iSub,1) = [LRVFRespSevenYP];
    LRVFSevenP.Act_x(iSub,1) = [LRVFActSevenXP];
    LRVFSevenP.Act_y(iSub,1) = [LRVFActSevenYP];
    
    LRVFEightP.Resp_x(iSub,1) = [LRVFRespEightXP];
    LRVFEightP.Resp_y(iSub,1) = [LRVFRespEightYP];
    LRVFEightP.Act_x(iSub,1) = [LRVFActEightXP];
    LRVFEightP.Act_y(iSub,1) = [LRVFActEightYP];

 
end

%% Creating DataSet for each Cluster (averaged participants 1-23, resp X, Y, act X, Y)

OneLLVFP.Resp = [mean(LLVFoneP.Resp_x),mean(LLVFoneP.Resp_y),mean(LLVFoneP.Act_x),mean(LLVFoneP.Act_y)];

TwoLLVFP.Resp = [mean(LLVFtwoP.Resp_x),mean(LLVFtwoP.Resp_y),mean(LLVFtwoP.Act_x),mean(LLVFtwoP.Act_y)];

ThreeLLVFP.Resp = [mean(LLVFthreeP.Resp_x),mean(LLVFthreeP.Resp_y),mean(LLVFthreeP.Act_x),mean(LLVFthreeP.Act_y)];

FiveLLVFP.Resp = [mean(LLVFfiveP.Resp_x),mean(LLVFfiveP.Resp_y),mean(LLVFfiveP.Act_x),mean(LLVFfiveP.Act_y)];

LLVFP.Resp = [OneLLVFP.Resp;TwoLLVFP.Resp;ThreeLLVFP.Resp;FiveLLVFP.Resp];

FourLRVFP.Resp = [mean(LRVFFourP.Resp_x),mean(LRVFFourP.Resp_y),mean(LRVFFourP.Act_x),mean(LRVFFourP.Act_y)];

SixLRVFP.Resp = [mean(LRVFSixP.Resp_x),mean(LRVFSixP.Resp_y),mean(LRVFSixP.Act_x),mean(LRVFSixP.Act_y)];

SevenLRVFP.Resp = [mean(LRVFSevenP.Resp_x),mean(LRVFSevenP.Resp_y),mean(LRVFSevenP.Act_x),mean(LRVFSevenP.Act_y)];

EightLRVFP.Resp = [mean(LRVFEightP.Resp_x),mean(LRVFEightP.Resp_y),mean(LRVFEightP.Act_x),mean(LRVFEightP.Act_y)];

LRVFP.Resp = [FourLRVFP.Resp;SixLRVFP.Resp;SevenLRVFP.Resp;EightLRVFP.Resp];

% Separate out the clusters:
LLVF.oneProcrustes = [LLVFoneP.Resp_x,LLVFoneP.Resp_y,LLVFoneP.Act_x,LLVFoneP.Act_y];
LLVF.twoProcrustes = [LLVFtwoP.Resp_x,LLVFtwoP.Resp_y,LLVFtwoP.Act_x,LLVFtwoP.Act_y];
LLVF.threeProcrustes = [LLVFthreeP.Resp_x,LLVFthreeP.Resp_y,LLVFthreeP.Act_x,LLVFthreeP.Act_y];
LLVF.fiveProcrustes = [LLVFfiveP.Resp_x,LLVFfiveP.Resp_y,LLVFfiveP.Act_x,LLVFfiveP.Act_y];

LLVF.iSub = [];
for i = 1:nSubs
    One = LLVF.oneProcrustes(i,:);
    Two = LLVF.twoProcrustes(i,:);
    Three = LLVF.threeProcrustes(i,:);
    Five = LLVF.fiveProcrustes(i,:);
    TotalLLVF = [One;Two;Three;Five];
    LLVF.iSub(:,:,i) = [TotalLLVF];
end

LRVF.FourProcrustes = [LRVFFourP.Resp_x,LRVFFourP.Resp_y,LRVFFourP.Act_x,LRVFFourP.Act_y];
LRVF.SixProcrustes = [LRVFSixP.Resp_x,LRVFSixP.Resp_y,LRVFSixP.Act_x,LRVFSixP.Act_y];
LRVF.SevenProcrustes = [LRVFSevenP.Resp_x,LRVFSevenP.Resp_y,LRVFSevenP.Act_x,LRVFSevenP.Act_y];
LRVF.EightProcrustes = [LRVFEightP.Resp_x,LRVFEightP.Resp_y,LRVFEightP.Act_x,LRVFEightP.Act_y];

LRVF.iSub = [];
for i = 1:nSubs
    Four = LRVF.FourProcrustes(i,:);
    Six = LRVF.SixProcrustes(i,:);
    Seven = LRVF.SevenProcrustes(i,:);
    Eight = LRVF.EightProcrustes(i,:);
    TotalLRVF = [Four;Six;Seven;Eight];
    LRVF.iSub(:,:,i) = [TotalLRVF];
end

%% save for now
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\LeftSaccLVF\LLVFIndividualClusters.mat','LLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\LeftSaccRVF\LRVFIndividualClusters.mat','LRVF');


%% save updated info with additional participants: SegmAdditionalPTCP\

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccLVF\LLVFIndividualClusters.mat','LLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccRVF\LRVFIndividualClusters.mat','LRVF');

save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccLVF\LLVFProcrustes.mat','LLVFP');
save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccRVF\LRVFProcrustes.mat','LRVFP');


%% In script functions
function eucDist=calc_eucDist(x1,x2,y1,y2)
eucDist = sqrt(((x1-x2).^2)+((y1-y2).^2));
end