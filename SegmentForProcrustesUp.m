%%    Segmenting Data per condition to submit to Procrustes D  - Up    %%
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
                respCuFouURVFx = RVFux;
                respCuFouURVFy = RVFuy;
                actCuFouURVFx = RVFactualux;
                actCuFouURVFy = RVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFdx = idownClusterX(downVal == uniqueLocs(i));
                RVFdy = idownClusterY(downVal == uniqueLocs(i));
                RVFactualdx = idClusterX;
                RVFactualdy = idClusterY;
                respCdFouURVFx = RVFdx;
                respCdFouURVFy = RVFdy;
                actCdFouURVFx = RVFactualdx;
                actCdFouURVFy = RVFactualdy;
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
                % Just to know what everything here stands for, LVFupBiRX
                % indicates the LVF, up saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF Right Saccade %%%%%%%%%%%%%%%%%%%%
                
                ULVFOneBiRx = [respCuOneLVFx];
                ULVFOneBiRY = [respCuOneLVFy];
                ULVFOneBiAx = [actCuOneLVFx];
                ULVFOneBiAY = [actCuOneLVFy];
                
                ULVFTwoBiRx = [respCuTwoLVFx];
                ULVFTwoBiRY = [respCuTwoLVFy];
                ULVFTwoBiAx = [actCuTwoLVFx];
                ULVFTwoBiAY = [actCuTwoLVFy];
                
                ULVFThreeBiRx = [respCuThreeLVFx];
                ULVFThreeBiRY = [respCuThreeLVFy];
                ULVFThreeBiAx = [actCuThreeLVFx];
                ULVFThreeBiAY = [actCuThreeLVFy];
                
                ULVFFiveBiRx = [respCuFiveLVFx];
                ULVFFiveBiRY = [respCuFiveLVFy];
                ULVFFiveBiAx = [actCuFiveLVFx];
                ULVFFiveBiAY = [actCuFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF Right Saccade %%%%%%%%%%%%%%%%%%%%
                
                URVFFourBiRx = [respCuFouURVFx];
                URVFFourBiRY = [respCuFouURVFy];
                URVFFourBiAx = [actCuFouURVFx];
                URVFFourBiAY = [actCuFouURVFy];
                
                URVFSixBiRx = [respCuSixRVFx];
                URVFSixBiRY = [respCuSixRVFy];
                URVFSixBiAx = [actCuSixRVFx];
                URVFSixBiAY = [actCuSixRVFy];
                
                URVFSevenBiRx = [respCuSevenRVFx];
                URVFSevenBiRY = [respCuSevenRVFy];
                URVFSevenBiAx = [actCuSevenRVFx];
                URVFSevenBiAY = [actCuSevenRVFy];
                
                URVFEightBiRx = [respCuEightRVFx];
                URVFEightBiRY = [respCuEightRVFy];
                URVFEightBiAx = [actCuEightRVFx];
                URVFEightBiAY = [actCuEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
            end
            
            if iBlock == 2
                % Just to know what everything here stands for, LVFupBiRX
                % indicates the LVF, up saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF up Saccade %%%%%%%%%%%%%%%%%%%%
                
                ULVFOneBiiRx = [respCuOneLVFx];
                ULVFOneBiiRY = [respCuOneLVFy];
                ULVFOneBiiAx = [actCuOneLVFx];
                ULVFOneBiiAY = [actCuOneLVFy];
                
                ULVFTwoBiiRx = [respCuTwoLVFx];
                ULVFTwoBiiRY = [respCuTwoLVFy];
                ULVFTwoBiiAx = [actCuTwoLVFx];
                ULVFTwoBiiAY = [actCuTwoLVFy];
                
                ULVFThreeBiiRx = [respCuThreeLVFx];
                ULVFThreeBiiRY = [respCuThreeLVFy];
                ULVFThreeBiiAx = [actCuThreeLVFx];
                ULVFThreeBiiAY = [actCuThreeLVFy];
                
                ULVFFiveBiiRx = [respCuFiveLVFx];
                ULVFFiveBiiRY = [respCuFiveLVFy];
                ULVFFiveBiiAx = [actCuFiveLVFx];
                ULVFFiveBiiAY = [actCuFiveLVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF up Saccade %%%%%%%%%%%%%%%%%%%%
                
                URVFFourBiiRx = [respCuFouURVFx];
                URVFFourBiiRY = [respCuFouURVFy];
                URVFFourBiiAx = [actCuFouURVFx];
                URVFFourBiiAY = [actCuFouURVFy];
                
                URVFSixBiiRx = [respCuSixRVFx];
                URVFSixBiiRY = [respCuSixRVFy];
                URVFSixBiiAx = [actCuSixRVFx];
                URVFSixBiiAY = [actCuSixRVFy];
                
                URVFSevenBiiRx = [respCuSevenRVFx];
                URVFSevenBiiRY = [respCuSevenRVFy];
                URVFSevenBiiAx = [actCuSevenRVFx];
                URVFSevenBiiAY = [actCuSevenRVFy];
                
                URVFEightBiiRx = [respCuEightRVFx];
                URVFEightBiiRY = [respCuEightRVFy];
                URVFEightBiiAx = [actCuEightRVFx];
                URVFEightBiiAY = [actCuEightRVFy];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            end
            
            if iBlock == 3
                % Just to know what everything here stands for, LVFupBiRX
                % indicates the LVF, up saccade, block 1 (i), response or
                % actual (R, A), x-coordinate. 
                
                %%%%%%%%%%%%%%%%%%%% LVF up Saccade %%%%%%%%%%%%%%%%%%%%
                
                ULVFOneBiiiRx = [respCuOneLVFx];
                ULVFOneBiiiRY = [respCuOneLVFy];
                ULVFOneBiiiAx = [actCuOneLVFx];
                ULVFOneBiiiAY = [actCuOneLVFy];
                
                ULVFTwoBiiiRx = [respCuTwoLVFx];
                ULVFTwoBiiiRY = [respCuTwoLVFy];
                ULVFTwoBiiiAx = [actCuTwoLVFx];
                ULVFTwoBiiiAY = [actCuTwoLVFy];
                
                ULVFThreeBiiiRx = [respCuThreeLVFx];
                ULVFThreeBiiiRY = [respCuThreeLVFy];
                ULVFThreeBiiiAx = [actCuThreeLVFx];
                ULVFThreeBiiiAY = [actCuThreeLVFy];
                
                ULVFFiveBiiiRx = [respCuFiveLVFx];
                ULVFFiveBiiiRY = [respCuFiveLVFy];
                ULVFFiveBiiiAx = [actCuFiveLVFx];
                ULVFFiveBiiiAY = [actCuFiveLVFy];
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% RVF up Saccade %%%%%%%%%%%%%%%%%%%%
                
                URVFFourBiiiRx = [respCuFouURVFx];
                URVFFourBiiiRY = [respCuFouURVFy];
                URVFFourBiiiAx = [actCuFouURVFx];
                URVFFourBiiiAY = [actCuFouURVFy];
                
                URVFSixBiiiRx = [respCuSixRVFx];
                URVFSixBiiiRY = [respCuSixRVFy];
                URVFSixBiiiAx = [actCuSixRVFx];
                URVFSixBiiiAY = [actCuSixRVFy];
                
                URVFSevenBiiiRx = [respCuSevenRVFx];
                URVFSevenBiiiRY = [respCuSevenRVFy];
                URVFSevenBiiiAx = [actCuSevenRVFx];
                URVFSevenBiiiAY = [actCuSevenRVFy];
                
                URVFEightBiiiRx = [respCuEightRVFx];
                URVFEightBiiiRY = [respCuEightRVFy];
                URVFEightBiiiAx = [actCuEightRVFx];
                URVFEightBiiiAY = [actCuEightRVFy];
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                              
            end
            
            end

        end
    end
    
    
    %% outlier detection and removal using euclidean distances, and calculate std of each cluster

    for i = 1:length(uniqueLocs)
        %% Concatinating the blocks together under the below categories:
        
        %%%%%%%%%%%%%%%%%%%%%%%% LVF up Saccade %%%%%%%%%%%%%%%%%%%%%%%%
        %PER CLUSTER ASSOCATED WITH VF
        ULVFRespOneXP = mean([ULVFOneBiRx,ULVFOneBiiRx, ULVFOneBiiiRx]);
        ULVFRespOneYP = mean([ULVFOneBiRY,ULVFOneBiiRY, ULVFOneBiiiRY]);
        ULVFActOneXP = mean([ULVFOneBiAx,ULVFOneBiiAx, ULVFOneBiiiAx]);
        ULVFActOneYP = mean([ULVFOneBiAY,ULVFOneBiiAY, ULVFOneBiiiAY]);
        

        ULVFRespTwoXP = mean([ULVFTwoBiRx,ULVFTwoBiiRx,ULVFTwoBiiiRx]);
        ULVFRespTwoYP = mean([ULVFTwoBiRY,ULVFTwoBiiRY,ULVFTwoBiiiRY]);
        ULVFActTwoXP = mean([ULVFTwoBiAx,ULVFTwoBiiAx,ULVFTwoBiiiAx]);
        ULVFActTwoYP = mean([ULVFTwoBiAY,ULVFTwoBiiAY,ULVFTwoBiiiAY]);
        
        ULVFRespThreeXP = mean([ULVFThreeBiRx,ULVFThreeBiiRx,ULVFThreeBiiiRx]);
        ULVFRespThreeYP = mean([ULVFThreeBiRY,ULVFThreeBiiRY,ULVFThreeBiiiRY]);
        ULVFActThreeXP = mean([ULVFThreeBiAx,ULVFThreeBiiAx,ULVFThreeBiiiAx]);
        ULVFActThreeYP = mean([ULVFThreeBiAY,ULVFThreeBiiAY,ULVFThreeBiiiAY]);
        
        ULVFRespFiveXP = mean([ULVFFiveBiRx,ULVFFiveBiiRx,ULVFFiveBiiiRx]);
        ULVFRespFiveYP = mean([ULVFFiveBiRY,ULVFFiveBiiRY,ULVFFiveBiiiRY]);
        ULVFActFiveXP = mean([ULVFFiveBiAx,ULVFFiveBiiAx,ULVFFiveBiiiAx]);
        ULVFActFiveYP = mean([ULVFFiveBiAY,ULVFFiveBiiAY,ULVFFiveBiiiAY]);
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%% RVF up Saccade %%%%%%%%%%%%%%%%%%%%%%%%        
        URVFRespFourXP = mean([URVFFourBiRx,URVFFourBiiRx, URVFFourBiiiRx]);
        URVFRespFourYP = mean([URVFFourBiRY,URVFFourBiiRY, URVFFourBiiiRY]);
        URVFActFourXP = mean([URVFFourBiAx,URVFFourBiiAx, URVFFourBiiiAx]);
        URVFActFourYP = mean([URVFFourBiAY,URVFFourBiiAY, URVFFourBiiiAY]);
        
        URVFRespSixXP = mean([URVFSixBiRx,URVFSixBiiRx, URVFSixBiiiRx]);
        URVFRespSixYP = mean([URVFSixBiRY,URVFSixBiiRY, URVFSixBiiiRY]);
        URVFActSixXP = mean([URVFSixBiAx,URVFSixBiiAx, URVFSixBiiiAx]);
        URVFActSixYP = mean([URVFSixBiAY,URVFSixBiiAY, URVFSixBiiiAY]);
        
        URVFRespSevenXP = mean([URVFSevenBiRx,URVFSevenBiiRx, URVFSevenBiiiRx]);
        URVFRespSevenYP = mean([URVFSevenBiRY,URVFSevenBiiRY, URVFSevenBiiiRY]);
        URVFActSevenXP = mean([URVFSevenBiAx,URVFSevenBiiAx, URVFSevenBiiiAx]);
        URVFActSevenYP = mean([URVFSevenBiAY,URVFSevenBiiAY, URVFSevenBiiiAY]);
        
        URVFRespEightXP = mean([URVFEightBiRx,URVFEightBiiRx, URVFEightBiiiRx]);
        URVFRespEightYP = mean([URVFEightBiRY,URVFEightBiiRY, URVFEightBiiiRY]);
        URVFActEightXP = mean([URVFEightBiAx,URVFEightBiiAx, URVFEightBiiiAx]);
        URVFActEightYP = mean([URVFEightBiAY,URVFEightBiiAY, URVFEightBiiiAY]);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %% Calculate euclidean distances
        % up Saccade LVF
        eucDistOneULVFp = calc_eucDist(ULVFRespOneXP,ULVFActOneXP,ULVFRespOneYP,ULVFActOneYP);
        
        eucDistTwoULVFp = calc_eucDist(ULVFRespTwoXP,ULVFActTwoXP,ULVFRespTwoYP,ULVFActTwoYP);
        
        eucDistThreeULVFp = calc_eucDist(ULVFRespThreeXP,ULVFActThreeXP,ULVFRespThreeYP,ULVFActThreeYP);
        
        eucDistFiveULVFp = calc_eucDist(ULVFRespFiveXP,ULVFActFiveXP,ULVFRespFiveYP,ULVFActFiveYP);
        
        % up Saccade RVF
        eucDistFourURVFp = calc_eucDist(URVFRespFourXP,URVFActFourXP,URVFRespFourYP,URVFActFourYP);
        
        eucDistSixURVFp = calc_eucDist(URVFRespSixXP,URVFActSixXP,URVFRespSixYP,URVFActSixYP);
        
        eucDistSevenURVFp = calc_eucDist(URVFRespSevenXP,URVFActSevenXP,URVFRespSevenYP,URVFActSevenYP);
        
        eucDistEightURVFp = calc_eucDist(URVFRespEightXP,URVFActEightXP,URVFRespEightYP,URVFActEightYP);

        %% z-transform
        
        % up Saccade LVF
        z_eucDistULVFOnep = zscore(eucDistOneULVFp);
        z_eucDistULVFTwop = zscore(eucDistTwoULVFp);
        z_eucDistULVFThreep = zscore(eucDistThreeULVFp);
        z_eucDistULVFFivep = zscore(eucDistFiveULVFp);
        
        % up Saccade RVF        
        z_eucDistURVFFourp = zscore(eucDistFourURVFp);
        z_eucDistURVFSixp = zscore(eucDistSixURVFp);
        z_eucDistURVFSevenp = zscore(eucDistSevenURVFp);
        z_eucDistURVFEightp = zscore(eucDistEightURVFp);

        %% Remove outliers based on pre-determined threshold
        
        % LVFup

        ULVFRespOneXP = ULVFRespOneXP(z_eucDistULVFOnep<outlier_thresh);
        ULVFRespOneYP = ULVFRespOneYP(z_eucDistULVFOnep<outlier_thresh);
        
        ULVFRespTwoXP = ULVFRespTwoXP(z_eucDistULVFTwop<outlier_thresh);
        ULVFRespTwoYP = ULVFRespTwoYP(z_eucDistULVFTwop<outlier_thresh);
        
        ULVFRespThreeXP = ULVFRespThreeXP(z_eucDistULVFThreep<outlier_thresh);
        ULVFRespThreeYP = ULVFRespThreeYP(z_eucDistULVFThreep<outlier_thresh);
        
        ULVFRespFiveXP = ULVFRespFiveXP(z_eucDistULVFFivep<outlier_thresh);
        ULVFRespFiveYP = ULVFRespFiveYP(z_eucDistULVFFivep<outlier_thresh);
        
        % RVFup

        URVFRespFourXP = URVFRespFourXP(z_eucDistURVFFourp<outlier_thresh);
        URVFRespFourYP = URVFRespFourYP(z_eucDistURVFFourp<outlier_thresh);
        
        URVFRespSixXP = URVFRespSixXP(z_eucDistURVFSixp<outlier_thresh);
        URVFRespSixYP = URVFRespSixYP(z_eucDistURVFSixp<outlier_thresh);
        
        URVFRespSevenXP = URVFRespSevenXP(z_eucDistURVFSevenp<outlier_thresh);
        URVFRespSevenYP = URVFRespSevenYP(z_eucDistURVFSevenp<outlier_thresh);
        
        URVFRespEightXP = URVFRespEightXP(z_eucDistURVFEightp<outlier_thresh);
        URVFRespEightYP = URVFRespEightYP(z_eucDistURVFEightp<outlier_thresh);

      
        
    end
    
    %% loading variables with Std values:
    
    % up Saccade LVF
%     ULVFoneP.Resp_x(iSub,1) = [ULVFRespOneXP];ULVFoneP.Resp_x = mean(ULVFoneP.Resp_x);
%     ULVFoneP.Resp_y(iSub,1) = [ULVFRespOneYP];ULVFoneP.Resp_y = mean(ULVFoneP.Resp_y);
%     ULVFoneP.Act_x(iSub,1) = [ULVFActOneXP];ULVFoneP.Act_x = mean(ULVFoneP.Act_x);
%     ULVFoneP.Act_y(iSub,1) = [ULVFActOneYP];ULVFoneP.Act_y = mean(ULVFoneP.Act_y);
%     
    ULVFoneP.Resp_x(iSub,1) = [ULVFRespOneXP];
    ULVFoneP.Resp_y(iSub,1) = [ULVFRespOneYP];
    ULVFoneP.Act_x(iSub,1) = [ULVFActOneXP];
    ULVFoneP.Act_y(iSub,1) = [ULVFActOneYP];
    
    ULVFtwoP.Resp_x(iSub,1) = [ULVFRespTwoXP];
    ULVFtwoP.Resp_y(iSub,1) = [ULVFRespTwoYP];
    ULVFtwoP.Act_x(iSub,1) = [ULVFActTwoXP];
    ULVFtwoP.Act_y(iSub,1) = [ULVFActTwoYP];
    
    ULVFthreeP.Resp_x(iSub,1) = [ULVFRespThreeXP];
    ULVFthreeP.Resp_y(iSub,1) = [ULVFRespThreeYP];
    ULVFthreeP.Act_x(iSub,1) = [ULVFActThreeXP];
    ULVFthreeP.Act_y(iSub,1) = [ULVFActThreeYP];
    
    ULVFfiveP.Resp_x(iSub,1) = [ULVFRespFiveXP];
    ULVFfiveP.Resp_y(iSub,1) = [ULVFRespFiveYP];
    ULVFfiveP.Act_x(iSub,1) = [ULVFActFiveXP];
    ULVFfiveP.Act_y(iSub,1) = [ULVFActFiveYP];
    
    % up Saccade RVF
    URVFFourP.Resp_x(iSub,1) = [URVFRespFourXP];
    URVFFourP.Resp_y(iSub,1) = [URVFRespFourYP];
    URVFFourP.Act_x(iSub,1) = [URVFActFourXP];
    URVFFourP.Act_y(iSub,1) = [URVFActFourYP];
    
    URVFSixP.Resp_x(iSub,1) = [URVFRespSixXP];
    URVFSixP.Resp_y(iSub,1) = [URVFRespSixYP];
    URVFSixP.Act_x(iSub,1) = [URVFActSixXP];
    URVFSixP.Act_y(iSub,1) = [URVFActSixYP];
    
    URVFSevenP.Resp_x(iSub,1) = [URVFRespSevenXP];
    URVFSevenP.Resp_y(iSub,1) = [URVFRespSevenYP];
    URVFSevenP.Act_x(iSub,1) = [URVFActSevenXP];
    URVFSevenP.Act_y(iSub,1) = [URVFActSevenYP];
    
    URVFEightP.Resp_x(iSub,1) = [URVFRespEightXP];
    URVFEightP.Resp_y(iSub,1) = [URVFRespEightYP];
    URVFEightP.Act_x(iSub,1) = [URVFActEightXP];
    URVFEightP.Act_y(iSub,1) = [URVFActEightYP];

 
end

%% Creating DataSet for each Cluster (participant 1-23, resp X, Y, act X, Y

OneULVFP.Resp = [mean(ULVFoneP.Resp_x),mean(ULVFoneP.Resp_y),mean(ULVFoneP.Act_x),mean(ULVFoneP.Act_y)];

TwoULVFP.Resp = [mean(ULVFtwoP.Resp_x),mean(ULVFtwoP.Resp_y),mean(ULVFtwoP.Act_x),mean(ULVFtwoP.Act_y)];

ThreeULVFP.Resp = [mean(ULVFthreeP.Resp_x),mean(ULVFthreeP.Resp_y),mean(ULVFthreeP.Act_x),mean(ULVFthreeP.Act_y)];

FiveULVFP.Resp = [mean(ULVFfiveP.Resp_x),mean(ULVFfiveP.Resp_y),mean(ULVFfiveP.Act_x),mean(ULVFfiveP.Act_y)];

ULVFP.Resp = [OneULVFP.Resp;TwoULVFP.Resp;ThreeULVFP.Resp;FiveULVFP.Resp];

FourURVFP.Resp = [mean(URVFFourP.Resp_x),mean(URVFFourP.Resp_y),mean(URVFFourP.Act_x),mean(URVFFourP.Act_y)];

SixURVFP.Resp = [mean(URVFSixP.Resp_x),mean(URVFSixP.Resp_y),mean(URVFSixP.Act_x),mean(URVFSixP.Act_y)];

SevenURVFP.Resp = [mean(URVFSevenP.Resp_x),mean(URVFSevenP.Resp_y),mean(URVFSevenP.Act_x),mean(URVFSevenP.Act_y)];

EightURVFP.Resp = [mean(URVFEightP.Resp_x),mean(URVFEightP.Resp_y),mean(URVFEightP.Act_x),mean(URVFEightP.Act_y)];

URVFP.Resp = [FourURVFP.Resp;SixURVFP.Resp;SevenURVFP.Resp;EightURVFP.Resp];

% Separate out the clusters:
ULVF.oneProcrustes = [ULVFoneP.Resp_x,ULVFoneP.Resp_y,ULVFoneP.Act_x,ULVFoneP.Act_y];
ULVF.twoProcrustes = [ULVFtwoP.Resp_x,ULVFtwoP.Resp_y,ULVFtwoP.Act_x,ULVFtwoP.Act_y];
ULVF.threeProcrustes = [ULVFthreeP.Resp_x,ULVFthreeP.Resp_y,ULVFthreeP.Act_x,ULVFthreeP.Act_y];
ULVF.fiveProcrustes = [ULVFfiveP.Resp_x,ULVFfiveP.Resp_y,ULVFfiveP.Act_x,ULVFfiveP.Act_y];

ULVF.iSub = [];
for i = 1:nSubs
    One = ULVF.oneProcrustes(i,:);
    Two = ULVF.twoProcrustes(i,:);
    Three = ULVF.threeProcrustes(i,:);
    Five = ULVF.fiveProcrustes(i,:);
    TotalULVF = [One;Two;Three;Five];
    ULVF.iSub(:,:,i) = [TotalULVF];
end

URVF.FourProcrustes = [URVFFourP.Resp_x,URVFFourP.Resp_y,URVFFourP.Act_x,URVFFourP.Act_y];
URVF.SixProcrustes = [URVFSixP.Resp_x,URVFSixP.Resp_y,URVFSixP.Act_x,URVFSixP.Act_y];
URVF.SevenProcrustes = [URVFSevenP.Resp_x,URVFSevenP.Resp_y,URVFSevenP.Act_x,URVFSevenP.Act_y];
URVF.EightProcrustes = [URVFEightP.Resp_x,URVFEightP.Resp_y,URVFEightP.Act_x,URVFEightP.Act_y];

URVF.iSub = [];
for i = 1:nSubs
    Four = URVF.FourProcrustes(i,:);
    Six = URVF.SixProcrustes(i,:);
    Seven = URVF.SevenProcrustes(i,:);
    Eight = URVF.EightProcrustes(i,:);
    TotalURVF = [Four;Six;Seven;Eight];
    URVF.iSub(:,:,i) = [TotalURVF];
end

%% save for now
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\UpSaccLVF\ULVFProcrustes.mat','ULVFP');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\UpSaccRVF\URVFProcrustes.mat','URVFP');


% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\UpSaccLVF\ULVFIndividualClusters.mat','ULVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\UpSaccRVF\URVFIndividualClusters.mat','URVF');

%% save updated info with additional participants: SegmAdditionalPTCP\

save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccLVF\ULVFIndividualClusters.mat','ULVF');
save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccRVF\URVFIndividualClusters.mat','URVF');

save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccLVF\ULVFProcrustes.mat','ULVFP');
save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccRVF\URVFProcrustes.mat','URVFP');

%% In script functions
function eucDist=calc_eucDist(x1,x2,y1,y2)
eucDist = sqrt(((x1-x2).^2)+((y1-y2).^2));
end