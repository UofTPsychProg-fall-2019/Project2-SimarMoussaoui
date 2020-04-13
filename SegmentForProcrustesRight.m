%%    Segmenting Data per condition to submit to Procrustes D  - Right    %%
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
                
                %%%%%%%%%%%%%%%%%%%% LVF Right Saccade %%%%%%%%%%%%%%%%%%%%
                
                RLVFOneBiRx = [respCrOneLVFx];
                RLVFOneBiRY = [respCrOneLVFy];
                RLVFOneBiAx = [actCrOneLVFx];
                RLVFOneBiAY = [actCrOneLVFy];
                
                RLVFTwoBiRx = [respCrTwoLVFx];
                RLVFTwoBiRY = [respCrTwoLVFy];
                RLVFTwoBiAx = [actCrTwoLVFx];
                RLVFTwoBiAY = [actCrTwoLVFy];
                
                RLVFThreeBiRx = [respCrThreeLVFx];
                RLVFThreeBiRY = [respCrThreeLVFy];
                RLVFThreeBiAx = [actCrThreeLVFx];
                RLVFThreeBiAY = [actCrThreeLVFy];
                
                RLVFFiveBiRx = [respCrFiveLVFx];
                RLVFFiveBiRY = [respCrFiveLVFy];
                RLVFFiveBiAx = [actCrFiveLVFx];
                RLVFFiveBiAY = [actCrFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Right Saccade %%%%%%%%%%%%%%%%%%%%
                
                RRVFFourBiRx = [respCrFourRVFx];
                RRVFFourBiRY = [respCrFourRVFy];
                RRVFFourBiAx = [actCrFourRVFx];
                RRVFFourBiAY = [actCrFourRVFy];
                
                RRVFSixBiRx = [respCrSixRVFx];
                RRVFSixBiRY = [respCrSixRVFy];
                RRVFSixBiAx = [actCrSixRVFx];
                RRVFSixBiAY = [actCrSixRVFy];
                
                RRVFSevenBiRx = [respCrSevenRVFx];
                RRVFSevenBiRY = [respCrSevenRVFy];
                RRVFSevenBiAx = [actCrSevenRVFx];
                RRVFSevenBiAY = [actCrSevenRVFy];
                
                RRVFEightBiRx = [respCrEightRVFx];
                RRVFEightBiRY = [respCrEightRVFy];
                RRVFEightBiAx = [actCrEightRVFx];
                RRVFEightBiAY = [actCrEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
            end
            
            if iBlock == 2
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                RLVFOneBiiRx = [respCrOneLVFx];
                RLVFOneBiiRY = [respCrOneLVFy];
                RLVFOneBiiAx = [actCrOneLVFx];
                RLVFOneBiiAY = [actCrOneLVFy];
                
                RLVFTwoBiiRx = [respCrTwoLVFx];
                RLVFTwoBiiRY = [respCrTwoLVFy];
                RLVFTwoBiiAx = [actCrTwoLVFx];
                RLVFTwoBiiAY = [actCrTwoLVFy];
                
                RLVFThreeBiiRx = [respCrThreeLVFx];
                RLVFThreeBiiRY = [respCrThreeLVFy];
                RLVFThreeBiiAx = [actCrThreeLVFx];
                RLVFThreeBiiAY = [actCrThreeLVFy];
                
                RLVFFiveBiiRx = [respCrFiveLVFx];
                RLVFFiveBiiRY = [respCrFiveLVFy];
                RLVFFiveBiiAx = [actCrFiveLVFx];
                RLVFFiveBiiAY = [actCrFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                RRVFFourBiiRx = [respCrFourRVFx];
                RRVFFourBiiRY = [respCrFourRVFy];
                RRVFFourBiiAx = [actCrFourRVFx];
                RRVFFourBiiAY = [actCrFourRVFy];
                
                RRVFSixBiiRx = [respCrSixRVFx];
                RRVFSixBiiRY = [respCrSixRVFy];
                RRVFSixBiiAx = [actCrSixRVFx];
                RRVFSixBiiAY = [actCrSixRVFy];
                
                RRVFSevenBiiRx = [respCrSevenRVFx];
                RRVFSevenBiiRY = [respCrSevenRVFy];
                RRVFSevenBiiAx = [actCrSevenRVFx];
                RRVFSevenBiiAY = [actCrSevenRVFy];
                
                RRVFEightBiiRx = [respCrEightRVFx];
                RRVFEightBiiRY = [respCrEightRVFy];
                RRVFEightBiiAx = [actCrEightRVFx];
                RRVFEightBiiAY = [actCrEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            end
            
            if iBlock == 3
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                RLVFOneBiiiRx = [respCrOneLVFx];
                RLVFOneBiiiRY = [respCrOneLVFy];
                RLVFOneBiiiAx = [actCrOneLVFx];
                RLVFOneBiiiAY = [actCrOneLVFy];
                
                RLVFTwoBiiiRx = [respCrTwoLVFx];
                RLVFTwoBiiiRY = [respCrTwoLVFy];
                RLVFTwoBiiiAx = [actCrTwoLVFx];
                RLVFTwoBiiiAY = [actCrTwoLVFy];
                
                RLVFThreeBiiiRx = [respCrThreeLVFx];
                RLVFThreeBiiiRY = [respCrThreeLVFy];
                RLVFThreeBiiiAx = [actCrThreeLVFx];
                RLVFThreeBiiiAY = [actCrThreeLVFy];
                
                RLVFFiveBiiiRx = [respCrFiveLVFx];
                RLVFFiveBiiiRY = [respCrFiveLVFy];
                RLVFFiveBiiiAx = [actCrFiveLVFx];
                RLVFFiveBiiiAY = [actCrFiveLVFy];
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                RRVFFourBiiiRx = [respCrFourRVFx];
                RRVFFourBiiiRY = [respCrFourRVFy];
                RRVFFourBiiiAx = [actCrFourRVFx];
                RRVFFourBiiiAY = [actCrFourRVFy];
                
                RRVFSixBiiiRx = [respCrSixRVFx];
                RRVFSixBiiiRY = [respCrSixRVFy];
                RRVFSixBiiiAx = [actCrSixRVFx];
                RRVFSixBiiiAY = [actCrSixRVFy];
                
                RRVFSevenBiiiRx = [respCrSevenRVFx];
                RRVFSevenBiiiRY = [respCrSevenRVFy];
                RRVFSevenBiiiAx = [actCrSevenRVFx];
                RRVFSevenBiiiAY = [actCrSevenRVFy];
                
                RRVFEightBiiiRx = [respCrEightRVFx];
                RRVFEightBiiiRY = [respCrEightRVFy];
                RRVFEightBiiiAx = [actCrEightRVFx];
                RRVFEightBiiiAY = [actCrEightRVFy];
                
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
        RLVFRespOneXP = mean([RLVFOneBiRx,RLVFOneBiiRx, RLVFOneBiiiRx]);
        RLVFRespOneYP = mean([RLVFOneBiRY,RLVFOneBiiRY, RLVFOneBiiiRY]);
        RLVFActOneXP = mean([RLVFOneBiAx,RLVFOneBiiAx, RLVFOneBiiiAx]);
        RLVFActOneYP = mean([RLVFOneBiAY,RLVFOneBiiAY, RLVFOneBiiiAY]);
        

        RLVFRespTwoXP = mean([RLVFTwoBiRx,RLVFTwoBiiRx,RLVFTwoBiiiRx]);
        RLVFRespTwoYP = mean([RLVFTwoBiRY,RLVFTwoBiiRY,RLVFTwoBiiiRY]);
        RLVFActTwoXP = mean([RLVFTwoBiAx,RLVFTwoBiiAx,RLVFTwoBiiiAx]);
        RLVFActTwoYP = mean([RLVFTwoBiAY,RLVFTwoBiiAY,RLVFTwoBiiiAY]);
        
        RLVFRespThreeXP = mean([RLVFThreeBiRx,RLVFThreeBiiRx,RLVFThreeBiiiRx]);
        RLVFRespThreeYP = mean([RLVFThreeBiRY,RLVFThreeBiiRY,RLVFThreeBiiiRY]);
        RLVFActThreeXP = mean([RLVFThreeBiAx,RLVFThreeBiiAx,RLVFThreeBiiiAx]);
        RLVFActThreeYP = mean([RLVFThreeBiAY,RLVFThreeBiiAY,RLVFThreeBiiiAY]);
        
        RLVFRespFiveXP = mean([RLVFFiveBiRx,RLVFFiveBiiRx,RLVFFiveBiiiRx]);
        RLVFRespFiveYP = mean([RLVFFiveBiRY,RLVFFiveBiiRY,RLVFFiveBiiiRY]);
        RLVFActFiveXP = mean([RLVFFiveBiAx,RLVFFiveBiiAx,RLVFFiveBiiiAx]);
        RLVFActFiveYP = mean([RLVFFiveBiAY,RLVFFiveBiiAY,RLVFFiveBiiiAY]);
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%%%%%        
        RRVFRespFourXP = mean([RRVFFourBiRx,RRVFFourBiiRx, RRVFFourBiiiRx]);
        RRVFRespFourYP = mean([RRVFFourBiRY,RRVFFourBiiRY, RRVFFourBiiiRY]);
        RRVFActFourXP = mean([RRVFFourBiAx,RRVFFourBiiAx, RRVFFourBiiiAx]);
        RRVFActFourYP = mean([RRVFFourBiAY,RRVFFourBiiAY, RRVFFourBiiiAY]);
        
        RRVFRespSixXP = mean([RRVFSixBiRx,RRVFSixBiiRx, RRVFSixBiiiRx]);
        RRVFRespSixYP = mean([RRVFSixBiRY,RRVFSixBiiRY, RRVFSixBiiiRY]);
        RRVFActSixXP = mean([RRVFSixBiAx,RRVFSixBiiAx, RRVFSixBiiiAx]);
        RRVFActSixYP = mean([RRVFSixBiAY,RRVFSixBiiAY, RRVFSixBiiiAY]);
        
        RRVFRespSevenXP = mean([RRVFSevenBiRx,RRVFSevenBiiRx, RRVFSevenBiiiRx]);
        RRVFRespSevenYP = mean([RRVFSevenBiRY,RRVFSevenBiiRY, RRVFSevenBiiiRY]);
        RRVFActSevenXP = mean([RRVFSevenBiAx,RRVFSevenBiiAx, RRVFSevenBiiiAx]);
        RRVFActSevenYP = mean([RRVFSevenBiAY,RRVFSevenBiiAY, RRVFSevenBiiiAY]);
        
        RRVFRespEightXP = mean([RRVFEightBiRx,RRVFEightBiiRx, RRVFEightBiiiRx]);
        RRVFRespEightYP = mean([RRVFEightBiRY,RRVFEightBiiRY, RRVFEightBiiiRY]);
        RRVFActEightXP = mean([RRVFEightBiAx,RRVFEightBiiAx, RRVFEightBiiiAx]);
        RRVFActEightYP = mean([RRVFEightBiAY,RRVFEightBiiAY, RRVFEightBiiiAY]);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %% Calculate euclidean distances
        % Left Saccade LVF
        eucDistOneRLVFp = calc_eucDist(RLVFRespOneXP,RLVFActOneXP,RLVFRespOneYP,RLVFActOneYP);
        
        eucDistTwoRLVFp = calc_eucDist(RLVFRespTwoXP,RLVFActTwoXP,RLVFRespTwoYP,RLVFActTwoYP);
        
        eucDistThreeRLVFp = calc_eucDist(RLVFRespThreeXP,RLVFActThreeXP,RLVFRespThreeYP,RLVFActThreeYP);
        
        eucDistFiveRLVFp = calc_eucDist(RLVFRespFiveXP,RLVFActFiveXP,RLVFRespFiveYP,RLVFActFiveYP);
        
        % Left Saccade RVF
        eucDistFourRRVFp = calc_eucDist(RRVFRespFourXP,RRVFActFourXP,RRVFRespFourYP,RRVFActFourYP);
        
        eucDistSixRRVFp = calc_eucDist(RRVFRespSixXP,RRVFActSixXP,RRVFRespSixYP,RRVFActSixYP);
        
        eucDistSevenRRVFp = calc_eucDist(RRVFRespSevenXP,RRVFActSevenXP,RRVFRespSevenYP,RRVFActSevenYP);
        
        eucDistEightRRVFp = calc_eucDist(RRVFRespEightXP,RRVFActEightXP,RRVFRespEightYP,RRVFActEightYP);

        %% z-transform
        
        % Left Saccade LVF
        z_eucDistRLVFOnep = zscore(eucDistOneRLVFp);
        z_eucDistRLVFTwop = zscore(eucDistTwoRLVFp);
        z_eucDistRLVFThreep = zscore(eucDistThreeRLVFp);
        z_eucDistRLVFFivep = zscore(eucDistFiveRLVFp);
        
        % Left Saccade RVF        
        z_eucDistRRVFFourp = zscore(eucDistFourRRVFp);
        z_eucDistRRVFSixp = zscore(eucDistSixRRVFp);
        z_eucDistRRVFSevenp = zscore(eucDistSevenRRVFp);
        z_eucDistRRVFEightp = zscore(eucDistEightRRVFp);

        %% Remove outliers based on pre-determined threshold
        
        % LVFLeft

        RLVFRespOneXP = RLVFRespOneXP(z_eucDistRLVFOnep<outlier_thresh);
        RLVFRespOneYP = RLVFRespOneYP(z_eucDistRLVFOnep<outlier_thresh);
        
        RLVFRespTwoXP = RLVFRespTwoXP(z_eucDistRLVFTwop<outlier_thresh);
        RLVFRespTwoYP = RLVFRespTwoYP(z_eucDistRLVFTwop<outlier_thresh);
        
        RLVFRespThreeXP = RLVFRespThreeXP(z_eucDistRLVFThreep<outlier_thresh);
        RLVFRespThreeYP = RLVFRespThreeYP(z_eucDistRLVFThreep<outlier_thresh);
        
        RLVFRespFiveXP = RLVFRespFiveXP(z_eucDistRLVFFivep<outlier_thresh);
        RLVFRespFiveYP = RLVFRespFiveYP(z_eucDistRLVFFivep<outlier_thresh);
        
        % RVFLeft

        RRVFRespFourXP = RRVFRespFourXP(z_eucDistRRVFFourp<outlier_thresh);
        RRVFRespFourYP = RRVFRespFourYP(z_eucDistRRVFFourp<outlier_thresh);
        
        RRVFRespSixXP = RRVFRespSixXP(z_eucDistRRVFSixp<outlier_thresh);
        RRVFRespSixYP = RRVFRespSixYP(z_eucDistRRVFSixp<outlier_thresh);
        
        RRVFRespSevenXP = RRVFRespSevenXP(z_eucDistRRVFSevenp<outlier_thresh);
        RRVFRespSevenYP = RRVFRespSevenYP(z_eucDistRRVFSevenp<outlier_thresh);
        
        RRVFRespEightXP = RRVFRespEightXP(z_eucDistRRVFEightp<outlier_thresh);
        RRVFRespEightYP = RRVFRespEightYP(z_eucDistRRVFEightp<outlier_thresh);

      
        
    end
    
    %% loading variables with Std values:
    
    % Left Saccade LVF
%     RLVFoneP.Resp_x(iSub,1) = [RLVFRespOneXP];RLVFoneP.Resp_x = mean(RLVFoneP.Resp_x);
%     RLVFoneP.Resp_y(iSub,1) = [RLVFRespOneYP];RLVFoneP.Resp_y = mean(RLVFoneP.Resp_y);
%     RLVFoneP.Act_x(iSub,1) = [RLVFActOneXP];RLVFoneP.Act_x = mean(RLVFoneP.Act_x);
%     RLVFoneP.Act_y(iSub,1) = [RLVFActOneYP];RLVFoneP.Act_y = mean(RLVFoneP.Act_y);
%     
    RLVFoneP.Resp_x(iSub,1) = [RLVFRespOneXP];
    RLVFoneP.Resp_y(iSub,1) = [RLVFRespOneYP];
    RLVFoneP.Act_x(iSub,1) = [RLVFActOneXP];
    RLVFoneP.Act_y(iSub,1) = [RLVFActOneYP];
    
    RLVFtwoP.Resp_x(iSub,1) = [RLVFRespTwoXP];
    RLVFtwoP.Resp_y(iSub,1) = [RLVFRespTwoYP];
    RLVFtwoP.Act_x(iSub,1) = [RLVFActTwoXP];
    RLVFtwoP.Act_y(iSub,1) = [RLVFActTwoYP];
    
    RLVFthreeP.Resp_x(iSub,1) = [RLVFRespThreeXP];
    RLVFthreeP.Resp_y(iSub,1) = [RLVFRespThreeYP];
    RLVFthreeP.Act_x(iSub,1) = [RLVFActThreeXP];
    RLVFthreeP.Act_y(iSub,1) = [RLVFActThreeYP];
    
    RLVFfiveP.Resp_x(iSub,1) = [RLVFRespFiveXP];
    RLVFfiveP.Resp_y(iSub,1) = [RLVFRespFiveYP];
    RLVFfiveP.Act_x(iSub,1) = [RLVFActFiveXP];
    RLVFfiveP.Act_y(iSub,1) = [RLVFActFiveYP];
    
    % Left Saccade RVF
    RRVFFourP.Resp_x(iSub,1) = [RRVFRespFourXP];
    RRVFFourP.Resp_y(iSub,1) = [RRVFRespFourYP];
    RRVFFourP.Act_x(iSub,1) = [RRVFActFourXP];
    RRVFFourP.Act_y(iSub,1) = [RRVFActFourYP];
    
    RRVFSixP.Resp_x(iSub,1) = [RRVFRespSixXP];
    RRVFSixP.Resp_y(iSub,1) = [RRVFRespSixYP];
    RRVFSixP.Act_x(iSub,1) = [RRVFActSixXP];
    RRVFSixP.Act_y(iSub,1) = [RRVFActSixYP];
    
    RRVFSevenP.Resp_x(iSub,1) = [RRVFRespSevenXP];
    RRVFSevenP.Resp_y(iSub,1) = [RRVFRespSevenYP];
    RRVFSevenP.Act_x(iSub,1) = [RRVFActSevenXP];
    RRVFSevenP.Act_y(iSub,1) = [RRVFActSevenYP];
    
    RRVFEightP.Resp_x(iSub,1) = [RRVFRespEightXP];
    RRVFEightP.Resp_y(iSub,1) = [RRVFRespEightYP];
    RRVFEightP.Act_x(iSub,1) = [RRVFActEightXP];
    RRVFEightP.Act_y(iSub,1) = [RRVFActEightYP];

 
end

%% Creating DataSet for each Cluster (participant 1-23, resp X, Y, act X, Y

OneRLVFP.Resp = [mean(RLVFoneP.Resp_x),mean(RLVFoneP.Resp_y),mean(RLVFoneP.Act_x),mean(RLVFoneP.Act_y)];

TwoRLVFP.Resp = [mean(RLVFtwoP.Resp_x),mean(RLVFtwoP.Resp_y),mean(RLVFtwoP.Act_x),mean(RLVFtwoP.Act_y)];

ThreeRLVFP.Resp = [mean(RLVFthreeP.Resp_x),mean(RLVFthreeP.Resp_y),mean(RLVFthreeP.Act_x),mean(RLVFthreeP.Act_y)];

FiveRLVFP.Resp = [mean(RLVFfiveP.Resp_x),mean(RLVFfiveP.Resp_y),mean(RLVFfiveP.Act_x),mean(RLVFfiveP.Act_y)];

RLVFP.Resp = [OneRLVFP.Resp;TwoRLVFP.Resp;ThreeRLVFP.Resp;FiveRLVFP.Resp];

FourRRVFP.Resp = [mean(RRVFFourP.Resp_x),mean(RRVFFourP.Resp_y),mean(RRVFFourP.Act_x),mean(RRVFFourP.Act_y)];

SixRRVFP.Resp = [mean(RRVFSixP.Resp_x),mean(RRVFSixP.Resp_y),mean(RRVFSixP.Act_x),mean(RRVFSixP.Act_y)];

SevenRRVFP.Resp = [mean(RRVFSevenP.Resp_x),mean(RRVFSevenP.Resp_y),mean(RRVFSevenP.Act_x),mean(RRVFSevenP.Act_y)];

EightRRVFP.Resp = [mean(RRVFEightP.Resp_x),mean(RRVFEightP.Resp_y),mean(RRVFEightP.Act_x),mean(RRVFEightP.Act_y)];

RRVFP.Resp = [FourRRVFP.Resp;SixRRVFP.Resp;SevenRRVFP.Resp;EightRRVFP.Resp];

% Separate out the clusters:
RLVF.oneProcrustes = [RLVFoneP.Resp_x,RLVFoneP.Resp_y,RLVFoneP.Act_x,RLVFoneP.Act_y];
RLVF.twoProcrustes = [RLVFtwoP.Resp_x,RLVFtwoP.Resp_y,RLVFtwoP.Act_x,RLVFtwoP.Act_y];
RLVF.threeProcrustes = [RLVFthreeP.Resp_x,RLVFthreeP.Resp_y,RLVFthreeP.Act_x,RLVFthreeP.Act_y];
RLVF.fiveProcrustes = [RLVFfiveP.Resp_x,RLVFfiveP.Resp_y,RLVFfiveP.Act_x,RLVFfiveP.Act_y];

RLVF.iSub = [];
for i = 1:nSubs
    One = RLVF.oneProcrustes(i,:);
    Two = RLVF.twoProcrustes(i,:);
    Three = RLVF.threeProcrustes(i,:);
    Five = RLVF.fiveProcrustes(i,:);
    TotalRLVF = [One;Two;Three;Five];
    RLVF.iSub(:,:,i) = [TotalRLVF];
end

RRVF.FourProcrustes = [RRVFFourP.Resp_x,RRVFFourP.Resp_y,RRVFFourP.Act_x,RRVFFourP.Act_y];
RRVF.SixProcrustes = [RRVFSixP.Resp_x,RRVFSixP.Resp_y,RRVFSixP.Act_x,RRVFSixP.Act_y];
RRVF.SevenProcrustes = [RRVFSevenP.Resp_x,RRVFSevenP.Resp_y,RRVFSevenP.Act_x,RRVFSevenP.Act_y];
RRVF.EightProcrustes = [RRVFEightP.Resp_x,RRVFEightP.Resp_y,RRVFEightP.Act_x,RRVFEightP.Act_y];

RRVF.iSub = [];
for i = 1:nSubs
    Four = RRVF.FourProcrustes(i,:);
    Six = RRVF.SixProcrustes(i,:);
    Seven = RRVF.SevenProcrustes(i,:);
    Eight = RRVF.EightProcrustes(i,:);
    TotalRRVF = [Four;Six;Seven;Eight];
    RRVF.iSub(:,:,i) = [TotalRRVF];
end

%% save for now
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\RightSaccLVF\RLVFProcrustes.mat','RLVFP');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\RightSaccRVF\RRVFProcrustes.mat','RRVFP');
% 
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\RightSaccLVF\RLVFIndividualClusters.mat','RLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\RightSaccRVF\RRVFIndividualClusters.mat','RRVF');


%% save updated info with additional participants: SegmAdditionalPTCP\

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccLVF\RLVFIndividualClusters.mat','RLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccRVF\RRVFIndividualClusters.mat','RRVF');

save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccLVF\RLVFProcrustes.mat','RLVFP');
save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccRVF\RRVFProcrustes.mat','RRVFP');


%% In script functions
function eucDist=calc_eucDist(x1,x2,y1,y2)
eucDist = sqrt(((x1-x2).^2)+((y1-y2).^2));
end