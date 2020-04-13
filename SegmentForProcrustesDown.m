%%    Segmenting Data per condition to submit to Procrustes D  - Down    %%
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
            
            %%%%%%%%%%%%%%%%%%%% UP SACCADES RVF LVF %%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % upVal is all the unique values for upwards saccades
            % (denoted 1 in variable LorR)
            upVal = theData.uniqueLocXY(theData.UorD == 1);
            % iupClusterX finds the responses in theData that include Cu saccades 
            iupClusterX = theData.RespLocNoJitterX(theData.UorD == 1); %Response
            iUCx = iupClusterX(upVal == uniqueLocs(i)); % separated per cluster
            
            iupClusterY = theData.RespLocNoJitterY(theData.UorD == 1);
            iUCy = iupClusterY(upVal == uniqueLocs(i));
            
            % Find the actual stimulus location for the above selected
            % points
            iuXcluster = theData.StimLocNoJitterX(theData.UorD == 1); %Actual location
            iuClusterX = iuXcluster(upVal == uniqueLocs(i)); %separated per cluster
            
            iuYcluster = theData.StimLocNoJitterY(theData.UorD == 1); %Actual location
            iuClusterY = iuYcluster(upVal == uniqueLocs(i)); %separated per cluster
            
            % Creating variables LVF and RVF for UP Saccades
            LVFux = []; LVFuy = [];RVFux = []; RVFuy = []; %creating an empty
            % list for all the below variables because it wont plot if the
            % variable doesnt exist first.
            LVFactualux = []; LVFactualuy = []; RVFactualux = []; RVFactualuy = [];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
             %%%%%%%%%%%%%%%%%%%% DOWN SACCADE RVF LVF %%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % downVal is all the unique values for downwards saccades
            % (denoted 1 in variable LorR)
            downVal = theData.uniqueLocXY(theData.UorD == -1);
            % iupClusterX finds the responses in theData that include down saccades 
            idownClusterX = theData.RespLocNoJitterX(theData.UorD == -1); %Response
            iDCx = idownClusterX(downVal == uniqueLocs(i)); % separated per cluster
            
            idownClusterY = theData.RespLocNoJitterY(theData.UorD == -1);
            iDCy = idownClusterY(downVal == uniqueLocs(i));
            
            % Find the actual stimulus location for the above selected
            % points
            idXcluster = theData.StimLocNoJitterX(theData.UorD == -1); %Actual location
            idClusterX = idXcluster(downVal == uniqueLocs(i)); %separated per cluster
            
            idYcluster = theData.StimLocNoJitterY(theData.UorD == -1); %Actual location
            idClusterY = idYcluster(downVal == uniqueLocs(i)); %separated per cluster
            
            % Creating variables LVF and RVF for Down Saccades
            LVFdx = []; LVFdy = [];RVFdx = []; RVFdy = []; %creating an empty
            % list for all the below variables because it wont plot if the
            % variable doesnt exist first.
            LVFactualdx = []; LVFactualdy = []; RVFactualdx = []; RVFactualdy = [];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            if i == 1
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFux = iupClusterX(upVal == uniqueLocs(i));
                LVFuy = iupClusterY(upVal == uniqueLocs(i));
                LVFactualux = iuClusterX; %might be redundant but I want to
                %manipulate iCluster differently depending on VF
                LVFactualuy = iuClusterY;
                %Below, save the data for each cluster in a variable
                respCuOneLVFx = LVFux;
                respCuOneLVFy = LVFuy;
                actCuOneLVFx = LVFactualux;
                actCuOneLVFy = LVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFdx = idownClusterX(downVal == uniqueLocs(i));
                LVFdy = idownClusterY(downVal == uniqueLocs(i));
                LVFactualdx = idClusterX; %might be redundant but I want to
                %manipulate iCluster differently depending on VF
                LVFactualdy = idClusterY;
                %Below, save the data for each cluster in a variable
                respCdOneLVFx = LVFdx;
                respCdOneLVFy = LVFdy;
                actCdOneLVFx = LVFactualdx;
                actCdOneLVFy = LVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            elseif i == 2
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFux = iupClusterX(upVal == uniqueLocs(i));
                LVFuy = iupClusterY(upVal == uniqueLocs(i));
                LVFactualux = iuClusterX;
                LVFactualuy = iuClusterY;
                respCuTwoLVFx = LVFux;
                respCuTwoLVFy = LVFuy;
                actCuTwoLVFx = LVFactualux;
                actCuTwoLVFy = LVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFdx = idownClusterX(downVal == uniqueLocs(i));
                LVFdy = idownClusterY(downVal == uniqueLocs(i));
                LVFactualdx = idClusterX;
                LVFactualdy = idClusterY;
                respCdTwoLVFx = LVFdx;
                respCdTwoLVFy = LVFdy;
                actCdTwoLVFx = LVFactualdx;
                actCdTwoLVFy = LVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif i == 3
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFux = iupClusterX(upVal == uniqueLocs(i));
                LVFuy = iupClusterY(upVal == uniqueLocs(i));
                LVFactualux = iuClusterX;
                LVFactualuy = iuClusterY;
                respCuThreeLVFx = LVFux;
                respCuThreeLVFy = LVFuy;
                actCuThreeLVFx = LVFactualux;
                actCuThreeLVFy = LVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFdx = idownClusterX(downVal == uniqueLocs(i));
                LVFdy = idownClusterY(downVal == uniqueLocs(i));
                LVFactualdx = idClusterX; 
                LVFactualdy = idClusterY;
                respCdThreeLVFx = LVFdx;
                respCdThreeLVFy = LVFdy;
                actCdThreeLVFx = LVFactualdx;
                actCdThreeLVFy = LVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            elseif i == 4
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFux = iupClusterX(upVal == uniqueLocs(i));
                RVFuy = iupClusterY(upVal == uniqueLocs(i));
                RVFactualux = iuClusterX;
                RVFactualuy = iuClusterY;
                respCuFouDRVFx = RVFux;
                respCuFouDRVFy = RVFuy;
                actCuFouDRVFx = RVFactualux;
                actCuFouDRVFy = RVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFdx = idownClusterX(downVal == uniqueLocs(i));
                RVFdy = idownClusterY(downVal == uniqueLocs(i));
                RVFactualdx = idClusterX;
                RVFactualdy = idClusterY;
                respCdFouDRVFx = RVFdx;
                respCdFouDRVFy = RVFdy;
                actCdFouDRVFx = RVFactualdx;
                actCdFouDRVFy = RVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                
            elseif i == 5
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFux = iupClusterX(upVal == uniqueLocs(i));
                LVFuy = iupClusterY(upVal == uniqueLocs(i));
                LVFactualux = iuClusterX;
                LVFactualuy = iuClusterY;
                respCuFiveLVFx = LVFux;
                respCuFiveLVFy = LVFuy;
                actCuFiveLVFx = LVFactualux;
                actCuFiveLVFy = LVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                LVFdx = idownClusterX(downVal == uniqueLocs(i));
                LVFdy = idownClusterY(downVal == uniqueLocs(i));
                LVFactualdx = idClusterX;
                LVFactualdy = idClusterY;
                respCdFiveLVFx = LVFdx;
                respCdFiveLVFy = LVFdy;
                actCdFiveLVFx = LVFactualdx;
                actCdFiveLVFy = LVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
            elseif i == 6
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFux = iupClusterX(upVal == uniqueLocs(i));
                RVFuy = iupClusterY(upVal == uniqueLocs(i));
                RVFactualux = iuClusterX;
                RVFactualuy = iuClusterY;
                respCuSixRVFx = RVFux;
                respCuSixRVFy = RVFuy;
                actCuSixRVFx = RVFactualux;
                actCuSixRVFy = RVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFdx = idownClusterX(downVal == uniqueLocs(i));
                RVFdy = idownClusterY(downVal == uniqueLocs(i));
                RVFactualdx = idClusterX;
                RVFactualdy = idClusterY;
                respCdSixRVFx = RVFdx;
                respCdSixRVFy = RVFdy;
                actCdSixRVFx = RVFactualdx;
                actCdSixRVFy = RVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            elseif i == 7
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFux = iupClusterX(upVal == uniqueLocs(i));
                RVFuy = iupClusterY(upVal == uniqueLocs(i));
                RVFactualux = iuClusterX;
                RVFactualuy = iuClusterY;
                respCuSevenRVFx = RVFux;
                respCuSevenRVFy = RVFuy;
                actCuSevenRVFx = RVFactualux;
                actCuSevenRVFy = RVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFdx = idownClusterX(downVal == uniqueLocs(i));
                RVFdy = idownClusterY(downVal == uniqueLocs(i));
                RVFactualdx = idClusterX;
                RVFactualdy = idClusterY;
                respCdSevenRVFx = RVFdx;
                respCdSevenRVFy = RVFdy;
                actCdSevenRVFx = RVFactualdx;
                actCdSevenRVFy = RVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif i == 8
                
                %%%%%%%%%%%%%%%%%%%% UPWARDS SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFux = iupClusterX(upVal == uniqueLocs(i));
                RVFuy = iupClusterY(upVal == uniqueLocs(i));
                RVFactualux = iuClusterX;
                RVFactualuy = iuClusterY;
                respCuEightRVFx = RVFux;
                respCuEightRVFy = RVFuy;
                actCuEightRVFx = RVFactualux;
                actCuEightRVFy = RVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFdx = idownClusterX(downVal == uniqueLocs(i));
                RVFdy = idownClusterY(downVal == uniqueLocs(i));
                RVFactualdx = idClusterX;
                RVFactualdy = idClusterY;
                respCdEightRVFx = RVFdx;
                respCdEightRVFy = RVFdy;
                actCdEightRVFx = RVFactualdx;
                actCdEightRVFy = RVFactualdy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
            % Now want to create lists for each block's x, y response and
            % actual coordinates:
            
            if iBlock == 1
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Right Saccade %%%%%%%%%%%%%%%%%%%%
                
                DLVFOneBiRx = [respCdOneLVFx];
                DLVFOneBiRY = [respCdOneLVFy];
                DLVFOneBiAx = [actCdOneLVFx];
                DLVFOneBiAY = [actCdOneLVFy];
                
                DLVFTwoBiRx = [respCdTwoLVFx];
                DLVFTwoBiRY = [respCdTwoLVFy];
                DLVFTwoBiAx = [actCdTwoLVFx];
                DLVFTwoBiAY = [actCdTwoLVFy];
                
                DLVFThreeBiRx = [respCdThreeLVFx];
                DLVFThreeBiRY = [respCdThreeLVFy];
                DLVFThreeBiAx = [actCdThreeLVFx];
                DLVFThreeBiAY = [actCdThreeLVFy];
                
                DLVFFiveBiRx = [respCdFiveLVFx];
                DLVFFiveBiRY = [respCdFiveLVFy];
                DLVFFiveBiAx = [actCdFiveLVFx];
                DLVFFiveBiAY = [actCdFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Right Saccade %%%%%%%%%%%%%%%%%%%%
                
                DRVFFourBiRx = [respCdFouDRVFx];
                DRVFFourBiRY = [respCdFouDRVFy];
                DRVFFourBiAx = [actCdFouDRVFx];
                DRVFFourBiAY = [actCdFouDRVFy];
                
                DRVFSixBiRx = [respCdSixRVFx];
                DRVFSixBiRY = [respCdSixRVFy];
                DRVFSixBiAx = [actCdSixRVFx];
                DRVFSixBiAY = [actCdSixRVFy];
                
                DRVFSevenBiRx = [respCdSevenRVFx];
                DRVFSevenBiRY = [respCdSevenRVFy];
                DRVFSevenBiAx = [actCdSevenRVFx];
                DRVFSevenBiAY = [actCdSevenRVFy];
                
                DRVFEightBiRx = [respCdEightRVFx];
                DRVFEightBiRY = [respCdEightRVFy];
                DRVFEightBiAx = [actCdEightRVFx];
                DRVFEightBiAY = [actCdEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
            end
            
            if iBlock == 2
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                DLVFOneBiiRx = [respCdOneLVFx];
                DLVFOneBiiRY = [respCdOneLVFy];
                DLVFOneBiiAx = [actCdOneLVFx];
                DLVFOneBiiAY = [actCdOneLVFy];
                
                DLVFTwoBiiRx = [respCdTwoLVFx];
                DLVFTwoBiiRY = [respCdTwoLVFy];
                DLVFTwoBiiAx = [actCdTwoLVFx];
                DLVFTwoBiiAY = [actCdTwoLVFy];
                
                DLVFThreeBiiRx = [respCdThreeLVFx];
                DLVFThreeBiiRY = [respCdThreeLVFy];
                DLVFThreeBiiAx = [actCdThreeLVFx];
                DLVFThreeBiiAY = [actCdThreeLVFy];
                
                DLVFFiveBiiRx = [respCdFiveLVFx];
                DLVFFiveBiiRY = [respCdFiveLVFy];
                DLVFFiveBiiAx = [actCdFiveLVFx];
                DLVFFiveBiiAY = [actCdFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                DRVFFourBiiRx = [respCdFouDRVFx];
                DRVFFourBiiRY = [respCdFouDRVFy];
                DRVFFourBiiAx = [actCdFouDRVFx];
                DRVFFourBiiAY = [actCdFouDRVFy];
                
                DRVFSixBiiRx = [respCdSixRVFx];
                DRVFSixBiiRY = [respCdSixRVFy];
                DRVFSixBiiAx = [actCdSixRVFx];
                DRVFSixBiiAY = [actCdSixRVFy];
                
                DRVFSevenBiiRx = [respCdSevenRVFx];
                DRVFSevenBiiRY = [respCdSevenRVFy];
                DRVFSevenBiiAx = [actCdSevenRVFx];
                DRVFSevenBiiAY = [actCdSevenRVFy];
                
                DRVFEightBiiRx = [respCdEightRVFx];
                DRVFEightBiiRY = [respCdEightRVFy];
                DRVFEightBiiAx = [actCdEightRVFx];
                DRVFEightBiiAY = [actCdEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            end
            
            if iBlock == 3
                % Just to know what everything here stands for, LVFLeftBiRX
                % indicates the LVF, left saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                DLVFOneBiiiRx = [respCdOneLVFx];
                DLVFOneBiiiRY = [respCdOneLVFy];
                DLVFOneBiiiAx = [actCdOneLVFx];
                DLVFOneBiiiAY = [actCdOneLVFy];
                
                DLVFTwoBiiiRx = [respCdTwoLVFx];
                DLVFTwoBiiiRY = [respCdTwoLVFy];
                DLVFTwoBiiiAx = [actCdTwoLVFx];
                DLVFTwoBiiiAY = [actCdTwoLVFy];
                
                DLVFThreeBiiiRx = [respCdThreeLVFx];
                DLVFThreeBiiiRY = [respCdThreeLVFy];
                DLVFThreeBiiiAx = [actCdThreeLVFx];
                DLVFThreeBiiiAY = [actCdThreeLVFy];
                
                DLVFFiveBiiiRx = [respCdFiveLVFx];
                DLVFFiveBiiiRY = [respCdFiveLVFy];
                DLVFFiveBiiiAx = [actCdFiveLVFx];
                DLVFFiveBiiiAY = [actCdFiveLVFy];
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
                
                DRVFFourBiiiRx = [respCdFouDRVFx];
                DRVFFourBiiiRY = [respCdFouDRVFy];
                DRVFFourBiiiAx = [actCdFouDRVFx];
                DRVFFourBiiiAY = [actCdFouDRVFy];
                
                DRVFSixBiiiRx = [respCdSixRVFx];
                DRVFSixBiiiRY = [respCdSixRVFy];
                DRVFSixBiiiAx = [actCdSixRVFx];
                DRVFSixBiiiAY = [actCdSixRVFy];
                
                DRVFSevenBiiiRx = [respCdSevenRVFx];
                DRVFSevenBiiiRY = [respCdSevenRVFy];
                DRVFSevenBiiiAx = [actCdSevenRVFx];
                DRVFSevenBiiiAY = [actCdSevenRVFy];
                
                DRVFEightBiiiRx = [respCdEightRVFx];
                DRVFEightBiiiRY = [respCdEightRVFy];
                DRVFEightBiiiAx = [actCdEightRVFx];
                DRVFEightBiiiAY = [actCdEightRVFy];
                
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
        DLVFRespOneXP = mean([DLVFOneBiRx,DLVFOneBiiRx, DLVFOneBiiiRx]);
        DLVFRespOneYP = mean([DLVFOneBiRY,DLVFOneBiiRY, DLVFOneBiiiRY]);
        DLVFActOneXP = mean([DLVFOneBiAx,DLVFOneBiiAx, DLVFOneBiiiAx]);
        DLVFActOneYP = mean([DLVFOneBiAY,DLVFOneBiiAY, DLVFOneBiiiAY]);
        

        DLVFRespTwoXP = mean([DLVFTwoBiRx,DLVFTwoBiiRx,DLVFTwoBiiiRx]);
        DLVFRespTwoYP = mean([DLVFTwoBiRY,DLVFTwoBiiRY,DLVFTwoBiiiRY]);
        DLVFActTwoXP = mean([DLVFTwoBiAx,DLVFTwoBiiAx,DLVFTwoBiiiAx]);
        DLVFActTwoYP = mean([DLVFTwoBiAY,DLVFTwoBiiAY,DLVFTwoBiiiAY]);
        
        DLVFRespThreeXP = mean([DLVFThreeBiRx,DLVFThreeBiiRx,DLVFThreeBiiiRx]);
        DLVFRespThreeYP = mean([DLVFThreeBiRY,DLVFThreeBiiRY,DLVFThreeBiiiRY]);
        DLVFActThreeXP = mean([DLVFThreeBiAx,DLVFThreeBiiAx,DLVFThreeBiiiAx]);
        DLVFActThreeYP = mean([DLVFThreeBiAY,DLVFThreeBiiAY,DLVFThreeBiiiAY]);
        
        DLVFRespFiveXP = mean([DLVFFiveBiRx,DLVFFiveBiiRx,DLVFFiveBiiiRx]);
        DLVFRespFiveYP = mean([DLVFFiveBiRY,DLVFFiveBiiRY,DLVFFiveBiiiRY]);
        DLVFActFiveXP = mean([DLVFFiveBiAx,DLVFFiveBiiAx,DLVFFiveBiiiAx]);
        DLVFActFiveYP = mean([DLVFFiveBiAY,DLVFFiveBiiAY,DLVFFiveBiiiAY]);
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%%%%%        
        DRVFRespFourXP = mean([DRVFFourBiRx,DRVFFourBiiRx, DRVFFourBiiiRx]);
        DRVFRespFourYP = mean([DRVFFourBiRY,DRVFFourBiiRY, DRVFFourBiiiRY]);
        DRVFActFourXP = mean([DRVFFourBiAx,DRVFFourBiiAx, DRVFFourBiiiAx]);
        DRVFActFourYP = mean([DRVFFourBiAY,DRVFFourBiiAY, DRVFFourBiiiAY]);
        
        DRVFRespSixXP = mean([DRVFSixBiRx,DRVFSixBiiRx, DRVFSixBiiiRx]);
        DRVFRespSixYP = mean([DRVFSixBiRY,DRVFSixBiiRY, DRVFSixBiiiRY]);
        DRVFActSixXP = mean([DRVFSixBiAx,DRVFSixBiiAx, DRVFSixBiiiAx]);
        DRVFActSixYP = mean([DRVFSixBiAY,DRVFSixBiiAY, DRVFSixBiiiAY]);
        
        DRVFRespSevenXP = mean([DRVFSevenBiRx,DRVFSevenBiiRx, DRVFSevenBiiiRx]);
        DRVFRespSevenYP = mean([DRVFSevenBiRY,DRVFSevenBiiRY, DRVFSevenBiiiRY]);
        DRVFActSevenXP = mean([DRVFSevenBiAx,DRVFSevenBiiAx, DRVFSevenBiiiAx]);
        DRVFActSevenYP = mean([DRVFSevenBiAY,DRVFSevenBiiAY, DRVFSevenBiiiAY]);
        
        DRVFRespEightXP = mean([DRVFEightBiRx,DRVFEightBiiRx, DRVFEightBiiiRx]);
        DRVFRespEightYP = mean([DRVFEightBiRY,DRVFEightBiiRY, DRVFEightBiiiRY]);
        DRVFActEightXP = mean([DRVFEightBiAx,DRVFEightBiiAx, DRVFEightBiiiAx]);
        DRVFActEightYP = mean([DRVFEightBiAY,DRVFEightBiiAY, DRVFEightBiiiAY]);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %% Calculate euclidean distances
        % Left Saccade LVF
        eucDistOneDLVFp = calc_eucDist(DLVFRespOneXP,DLVFActOneXP,DLVFRespOneYP,DLVFActOneYP);
        
        eucDistTwoDLVFp = calc_eucDist(DLVFRespTwoXP,DLVFActTwoXP,DLVFRespTwoYP,DLVFActTwoYP);
        
        eucDistThreeDLVFp = calc_eucDist(DLVFRespThreeXP,DLVFActThreeXP,DLVFRespThreeYP,DLVFActThreeYP);
        
        eucDistFiveDLVFp = calc_eucDist(DLVFRespFiveXP,DLVFActFiveXP,DLVFRespFiveYP,DLVFActFiveYP);
        
        % Left Saccade RVF
        eucDistFourDRVFp = calc_eucDist(DRVFRespFourXP,DRVFActFourXP,DRVFRespFourYP,DRVFActFourYP);
        
        eucDistSixDRVFp = calc_eucDist(DRVFRespSixXP,DRVFActSixXP,DRVFRespSixYP,DRVFActSixYP);
        
        eucDistSevenDRVFp = calc_eucDist(DRVFRespSevenXP,DRVFActSevenXP,DRVFRespSevenYP,DRVFActSevenYP);
        
        eucDistEightDRVFp = calc_eucDist(DRVFRespEightXP,DRVFActEightXP,DRVFRespEightYP,DRVFActEightYP);

        %% z-transform
        
        % Left Saccade LVF
        z_eucDistDLVFOnep = zscore(eucDistOneDLVFp);
        z_eucDistDLVFTwop = zscore(eucDistTwoDLVFp);
        z_eucDistDLVFThreep = zscore(eucDistThreeDLVFp);
        z_eucDistDLVFFivep = zscore(eucDistFiveDLVFp);
        
        % Left Saccade RVF        
        z_eucDistDRVFFourp = zscore(eucDistFourDRVFp);
        z_eucDistDRVFSixp = zscore(eucDistSixDRVFp);
        z_eucDistDRVFSevenp = zscore(eucDistSevenDRVFp);
        z_eucDistDRVFEightp = zscore(eucDistEightDRVFp);

        %% Remove outliers based on pre-determined threshold
        
        % LVFLeft

        DLVFRespOneXP = DLVFRespOneXP(z_eucDistDLVFOnep<outlier_thresh);
        DLVFRespOneYP = DLVFRespOneYP(z_eucDistDLVFOnep<outlier_thresh);
        
        DLVFRespTwoXP = DLVFRespTwoXP(z_eucDistDLVFTwop<outlier_thresh);
        DLVFRespTwoYP = DLVFRespTwoYP(z_eucDistDLVFTwop<outlier_thresh);
        
        DLVFRespThreeXP = DLVFRespThreeXP(z_eucDistDLVFThreep<outlier_thresh);
        DLVFRespThreeYP = DLVFRespThreeYP(z_eucDistDLVFThreep<outlier_thresh);
        
        DLVFRespFiveXP = DLVFRespFiveXP(z_eucDistDLVFFivep<outlier_thresh);
        DLVFRespFiveYP = DLVFRespFiveYP(z_eucDistDLVFFivep<outlier_thresh);
        
        % RVFLeft

        DRVFRespFourXP = DRVFRespFourXP(z_eucDistDRVFFourp<outlier_thresh);
        DRVFRespFourYP = DRVFRespFourYP(z_eucDistDRVFFourp<outlier_thresh);
        
        DRVFRespSixXP = DRVFRespSixXP(z_eucDistDRVFSixp<outlier_thresh);
        DRVFRespSixYP = DRVFRespSixYP(z_eucDistDRVFSixp<outlier_thresh);
        
        DRVFRespSevenXP = DRVFRespSevenXP(z_eucDistDRVFSevenp<outlier_thresh);
        DRVFRespSevenYP = DRVFRespSevenYP(z_eucDistDRVFSevenp<outlier_thresh);
        
        DRVFRespEightXP = DRVFRespEightXP(z_eucDistDRVFEightp<outlier_thresh);
        DRVFRespEightYP = DRVFRespEightYP(z_eucDistDRVFEightp<outlier_thresh);

      
        
    end
    
    %% loading variables with Std values:
    
    % Left Saccade LVF
%     DLVFoneP.Resp_x(iSub,1) = [DLVFRespOneXP];DLVFoneP.Resp_x = mean(DLVFoneP.Resp_x);
%     DLVFoneP.Resp_y(iSub,1) = [DLVFRespOneYP];DLVFoneP.Resp_y = mean(DLVFoneP.Resp_y);
%     DLVFoneP.Act_x(iSub,1) = [DLVFActOneXP];DLVFoneP.Act_x = mean(DLVFoneP.Act_x);
%     DLVFoneP.Act_y(iSub,1) = [DLVFActOneYP];DLVFoneP.Act_y = mean(DLVFoneP.Act_y);
%     
    DLVFoneP.Resp_x(iSub,1) = [DLVFRespOneXP];
    DLVFoneP.Resp_y(iSub,1) = [DLVFRespOneYP];
    DLVFoneP.Act_x(iSub,1) = [DLVFActOneXP];
    DLVFoneP.Act_y(iSub,1) = [DLVFActOneYP];
    
    DLVFtwoP.Resp_x(iSub,1) = [DLVFRespTwoXP];
    DLVFtwoP.Resp_y(iSub,1) = [DLVFRespTwoYP];
    DLVFtwoP.Act_x(iSub,1) = [DLVFActTwoXP];
    DLVFtwoP.Act_y(iSub,1) = [DLVFActTwoYP];
    
    DLVFthreeP.Resp_x(iSub,1) = [DLVFRespThreeXP];
    DLVFthreeP.Resp_y(iSub,1) = [DLVFRespThreeYP];
    DLVFthreeP.Act_x(iSub,1) = [DLVFActThreeXP];
    DLVFthreeP.Act_y(iSub,1) = [DLVFActThreeYP];
    
    DLVFfiveP.Resp_x(iSub,1) = [DLVFRespFiveXP];
    DLVFfiveP.Resp_y(iSub,1) = [DLVFRespFiveYP];
    DLVFfiveP.Act_x(iSub,1) = [DLVFActFiveXP];
    DLVFfiveP.Act_y(iSub,1) = [DLVFActFiveYP];
    
    % Left Saccade RVF
    DRVFFourP.Resp_x(iSub,1) = [DRVFRespFourXP];
    DRVFFourP.Resp_y(iSub,1) = [DRVFRespFourYP];
    DRVFFourP.Act_x(iSub,1) = [DRVFActFourXP];
    DRVFFourP.Act_y(iSub,1) = [DRVFActFourYP];
    
    DRVFSixP.Resp_x(iSub,1) = [DRVFRespSixXP];
    DRVFSixP.Resp_y(iSub,1) = [DRVFRespSixYP];
    DRVFSixP.Act_x(iSub,1) = [DRVFActSixXP];
    DRVFSixP.Act_y(iSub,1) = [DRVFActSixYP];
    
    DRVFSevenP.Resp_x(iSub,1) = [DRVFRespSevenXP];
    DRVFSevenP.Resp_y(iSub,1) = [DRVFRespSevenYP];
    DRVFSevenP.Act_x(iSub,1) = [DRVFActSevenXP];
    DRVFSevenP.Act_y(iSub,1) = [DRVFActSevenYP];
    
    DRVFEightP.Resp_x(iSub,1) = [DRVFRespEightXP];
    DRVFEightP.Resp_y(iSub,1) = [DRVFRespEightYP];
    DRVFEightP.Act_x(iSub,1) = [DRVFActEightXP];
    DRVFEightP.Act_y(iSub,1) = [DRVFActEightYP];

 
end

%% Creating DataSet for each Cluster (participant 1-23, resp X, Y, act X, Y

OneDLVFP.Resp = [mean(DLVFoneP.Resp_x),mean(DLVFoneP.Resp_y),mean(DLVFoneP.Act_x),mean(DLVFoneP.Act_y)];

TwoDLVFP.Resp = [mean(DLVFtwoP.Resp_x),mean(DLVFtwoP.Resp_y),mean(DLVFtwoP.Act_x),mean(DLVFtwoP.Act_y)];

ThreeDLVFP.Resp = [mean(DLVFthreeP.Resp_x),mean(DLVFthreeP.Resp_y),mean(DLVFthreeP.Act_x),mean(DLVFthreeP.Act_y)];

FiveDLVFP.Resp = [mean(DLVFfiveP.Resp_x),mean(DLVFfiveP.Resp_y),mean(DLVFfiveP.Act_x),mean(DLVFfiveP.Act_y)];

DLVFP.Resp = [OneDLVFP.Resp;TwoDLVFP.Resp;ThreeDLVFP.Resp;FiveDLVFP.Resp];

FourDRVFP.Resp = [mean(DRVFFourP.Resp_x),mean(DRVFFourP.Resp_y),mean(DRVFFourP.Act_x),mean(DRVFFourP.Act_y)];

SixDRVFP.Resp = [mean(DRVFSixP.Resp_x),mean(DRVFSixP.Resp_y),mean(DRVFSixP.Act_x),mean(DRVFSixP.Act_y)];

SevenDRVFP.Resp = [mean(DRVFSevenP.Resp_x),mean(DRVFSevenP.Resp_y),mean(DRVFSevenP.Act_x),mean(DRVFSevenP.Act_y)];

EightDRVFP.Resp = [mean(DRVFEightP.Resp_x),mean(DRVFEightP.Resp_y),mean(DRVFEightP.Act_x),mean(DRVFEightP.Act_y)];

DRVFP.Resp = [FourDRVFP.Resp;SixDRVFP.Resp;SevenDRVFP.Resp;EightDRVFP.Resp];

% Separate out the clusters:
DLVF.oneProcrustes = [DLVFoneP.Resp_x,DLVFoneP.Resp_y,DLVFoneP.Act_x,DLVFoneP.Act_y];
DLVF.twoProcrustes = [DLVFtwoP.Resp_x,DLVFtwoP.Resp_y,DLVFtwoP.Act_x,DLVFtwoP.Act_y];
DLVF.threeProcrustes = [DLVFthreeP.Resp_x,DLVFthreeP.Resp_y,DLVFthreeP.Act_x,DLVFthreeP.Act_y];
DLVF.fiveProcrustes = [DLVFfiveP.Resp_x,DLVFfiveP.Resp_y,DLVFfiveP.Act_x,DLVFfiveP.Act_y];

DLVF.iSub = [];
for i = 1:nSubs
    One = DLVF.oneProcrustes(i,:);
    Two = DLVF.twoProcrustes(i,:);
    Three = DLVF.threeProcrustes(i,:);
    Five = DLVF.fiveProcrustes(i,:);
    TotalDLVF = [One;Two;Three;Five];
    DLVF.iSub(:,:,i) = [TotalDLVF];
end

DRVF.FourProcrustes = [DRVFFourP.Resp_x,DRVFFourP.Resp_y,DRVFFourP.Act_x,DRVFFourP.Act_y];
DRVF.SixProcrustes = [DRVFSixP.Resp_x,DRVFSixP.Resp_y,DRVFSixP.Act_x,DRVFSixP.Act_y];
DRVF.SevenProcrustes = [DRVFSevenP.Resp_x,DRVFSevenP.Resp_y,DRVFSevenP.Act_x,DRVFSevenP.Act_y];
DRVF.EightProcrustes = [DRVFEightP.Resp_x,DRVFEightP.Resp_y,DRVFEightP.Act_x,DRVFEightP.Act_y];

DRVF.iSub = [];
for i = 1:nSubs
    Four = DRVF.FourProcrustes(i,:);
    Six = DRVF.SixProcrustes(i,:);
    Seven = DRVF.SevenProcrustes(i,:);
    Eight = DRVF.EightProcrustes(i,:);
    TotalDRVF = [Four;Six;Seven;Eight];
    DRVF.iSub(:,:,i) = [TotalDRVF];
end

%% save for now
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\DownSaccLVF\DLVFProcrustes.mat','DLVFP');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\DownSaccRVF\DRVFProcrustes.mat','DRVFP');

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\DownSaccLVF\DLVFIndividualClusters.mat','DLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\DownSaccRVF\DRVFIndividualClusters.mat','DRVF');


%% save updated info with additional participants: SegmAdditionalPTCP\

% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccLVF\DLVFIndividualClusters.mat','DLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccRVF\DRVFIndividualClusters.mat','DRVF');

save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccLVF\DLVFProcrustes.mat','DLVFP');
save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccRVF\DRVFProcrustes.mat','DRVFP');


%% In script functions
function eucDist=calc_eucDist(x1,x2,y1,y2)
eucDist = sqrt(((x1-x2).^2)+((y1-y2).^2));
end