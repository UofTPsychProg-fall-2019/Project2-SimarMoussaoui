%% I want to reset my workspace and command window
close all; clear; clc;
% fprintf
%% Initialize variables
subs = [2,4,5,7,8,9,11,14,15,23,26,30,32,34,35,36,37,38,39,41,42,43,44,48,50,52,53,54,57,58,59,60,65,68,71];
% subs = [2,4,5,7,8,9,11,14,15,23,26,30,32,34,35,36,37,38,39,41,42,43,44];
% subs = [42];
nSubs = length(subs);
outlier_thresh = 3;

UpSaccLVF.std_x = [];
UpSaccLVF.std_y = [];

UpSaccRVF.std_x = [];
UpSaccRVF.std_y = [];

DownSaccLVF.std_x = [];
DownSaccLVF.std_y = [];

DownSaccRVF.std_x = [];
DownSaccRVF.std_y = [];

GroupResults.std_x = [];
GroupResults.std_y = [];

%% Conditional variables
do_plot = 0; %1 if plot, 0 if no plot.
vh_plot = 0; %1 if plot vorh for clusters, 0 if no plot vorh
rl_plot = 0; %1 if plot LorR, 0 if no plot

%% Segment data into clusters and conditions
for iSub = 1:nSubs
    % Need to loop through 3 blocks:
    blocks = [1,2,3];
    if do_plot
        figure(); hold on; set(gcf, 'color','w'); box on; grid on;
        title('First look with no outlier removal');
    end
    if vh_plot
        figure(); hold on; set(gcf, 'color','w'); box on; grid on;
        title('First look with no outlier removal');
    end
    if rl_plot
        figure(); hold on; set(gcf, 'color','w'); box on; grid on;
        title('First look with no outlier removal');
    end
    
    %% initializing variables for cluster-wise standard deviation input
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%UpWards - LVF%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LVFUpOneRX = []; LVFUpOneRY = []; LVFUpOneAX = []; LVFUpOneAY = [];
    LVFUpTwoRX = []; LVFUpTwoRY = []; LVFUpTwoAX = []; LVFUpTwoAY = [];
    LVFUpThreeRX = []; LVFUpThreeRY = []; LVFUpThreeAX = []; LVFUpThreeAY = [];
    LVFUpFiveRX = []; LVFUpFiveRY = []; LVFUpFiveAX = []; LVFUpFiveAY = [];
    
    LVFUpFourRX = []; LVFUpFourRY = []; LVFUpFourAX = []; LVFUpFourAY = [];
    LVFUpSixRX = []; LVFUpSixRY = []; LVFUpSixAX = []; LVFUpSixAY = [];
    LVFUpSevenRX = []; LVFUpSevenRY = []; LVFUpSevenAX = []; LVFUpSevenAY = [];
    LVFUpEightRX = []; LVFUpEightRY = []; LVFUpEightAX = []; LVFUpEightAY = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%UpWards - RVF%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    RVFUpOneRX = []; RVFUpOneRY = []; RVFUpOneAX = []; RVFUpOneAY = [];
    RVFUpTwoRX = []; RVFUpTwoRY = []; RVFUpTwoAX = []; RVFUpTwoAY = [];
    RVFUpThreeRX = []; RVFUpThreeRY = []; RVFUpThreeAX = []; RVFUpThreeAY = [];
    RVFUpFiveRX = []; RVFUpFiveRY = []; RVFUpFiveAX = []; RVFUpFiveAY = [];
    
    RVFUpFourRX = []; RVFUpFourRY = []; RVFUpFourAX = []; RVFUpFourAY = [];
    RVFUpSixRX = []; RVFUpSixRY = []; RVFUpSixAX = []; RVFUpSixAY = [];
    RVFUpSevenRX = []; RVFUpSevenRY = []; RVFUpSevenAX = []; RVFUpSevenAY = [];
    RVFUpEightRX = []; RVFUpEightRY = []; RVFUpEightAX = []; RVFUpEightAY = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Down - LVF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LVFDownOneRX = []; LVFDownOneRY = []; LVFDownOneAX = []; LVFDownOneAY = [];
    LVFDownTwoRX = []; LVFDownTwoRY = []; LVFDownTwoAX = []; LVFDownTwoAY = [];
    LVFDownThreeRX = []; LVFDownThreeRY = []; LVFDownThreeAX = []; LVFDownThreeAY = [];
    LVFDownFiveRX = []; LVFDownFiveRY = []; LVFDownFiveAX = []; LVFDownFiveAY = [];
    
    LVFDownFourRX = []; LVFDownFourRY = []; LVFDownFourAX = []; LVFDownFourAY = [];
    LVFDownSixRX = []; LVFDownSixRY = []; LVFDownSixAX = []; LVFDownSixAY = [];
    LVFDownSevenRX = []; LVFDownSevenRY = []; LVFDownSevenAX = []; LVFDownSevenAY = [];
    LVFDownEightRX = []; LVFDownEightRY = []; LVFDownEightAX = []; LVFDownEightAY = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Down - RVF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    RVFDownOneRX = []; RVFDownOneRY = []; RVFDownOneAX = []; RVFDownOneAY = [];
    RVFDownTwoRX = []; RVFDownTwoRY = []; RVFDownTwoAX = []; RVFDownTwoAY = [];
    RVFDownThreeRX = []; RVFDownThreeRY = []; RVFDownThreeAX = []; RVFDownThreeAY = [];
    RVFDownFiveRX = []; RVFDownFiveRY = []; RVFDownFiveAX = []; RVFDownFiveAY = [];
    
    RVFDownFourRX = []; RVFDownFourRY = []; RVFDownFourAX = []; RVFDownFourAY = [];
    RVFDownSixRX = []; RVFDownSixRY = []; RVFDownSixAX = []; RVFDownSixAY = [];
    RVFDownSevenRX = []; RVFDownSevenRY = []; RVFDownSevenAX = []; RVFDownSevenAY = [];
    RVFDownEightRX = []; RVFDownEightRY = []; RVFDownEightAX = []; RVFDownEightAY = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
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
        
        %% plot 8 clusters separately as a first look
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
            % ileftClusterX finds the responses in theData that include up saccades 
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
            % ileftClusterX finds the responses in theData that include down saccades 
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
                respCuFourRVFx = RVFux;
                respCuFourRVFy = RVFuy;
                actCuFourRVFx = RVFactualux;
                actCuFourRVFy = RVFactualuy;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%% DOWNWARD SACCADE %%%%%%%%%%%%%%%%%%%%
                RVFdx = idownClusterX(downVal == uniqueLocs(i));
                RVFdy = idownClusterY(downVal == uniqueLocs(i));
                RVFactualdx = idClusterX;
                RVFactualdy = idClusterY;
                respCdFourRVFx = RVFdx;
                respCdFourRVFy = RVFdy;
                actCdFourRVFx = RVFactualdx;
                actCdFourRVFy = RVFactualdy;
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
            
            %% Below will add all the blocks values to its corresponding cluster
            
            %%%%%%%%%%%%%%%%%%%% LVF Up Saccade %%%%%%%%%%%%%%%%%%%%
            LVFUpOneRX = [LVFUpOneRX,respCuOneLVFx];
            LVFUpOneRY = [LVFUpOneRY,respCuOneLVFy];
            LVFUpOneAX = [LVFUpOneAX,actCuOneLVFx];
            LVFUpOneAY = [LVFUpOneAY,actCuOneLVFy];
            
            LVFUpTwoRX = [LVFUpTwoRX,respCuTwoLVFx];
            LVFUpTwoRY = [LVFUpTwoRY,respCuTwoLVFy];
            LVFUpTwoAX = [LVFUpTwoAX,actCuTwoLVFx];
            LVFUpTwoAY = [LVFUpTwoAY,actCuTwoLVFy];
            
            LVFUpThreeRX = [LVFUpThreeRX,respCuThreeLVFx];
            LVFUpThreeRY = [LVFUpThreeRY,respCuThreeLVFy];
            LVFUpThreeAX = [LVFUpThreeAX,actCuThreeLVFx];
            LVFUpThreeAY = [LVFUpThreeAY,actCuThreeLVFy];
            
            LVFUpFiveRX = [LVFUpFiveRX,respCuFiveLVFx];
            LVFUpFiveRY = [LVFUpFiveRY,respCuFiveLVFy];
            LVFUpFiveAX = [LVFUpFiveAX,actCuFiveLVFx];
            LVFUpFiveAY = [LVFUpFiveAY,actCuFiveLVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%% RVF Up Saccade %%%%%%%%%%%%%%%%%%%%
            RVFUpFourRX = [RVFUpFourRX,respCuFourRVFx];
            RVFUpFourRY = [RVFUpFourRY,respCuFourRVFy];
            RVFUpFourAX = [RVFUpFourAX,actCuFourRVFx];
            RVFUpFourAY = [RVFUpFourAY,actCuFourRVFy];
            
            RVFUpSixRX = [RVFUpSixRX,respCuSixRVFx];
            RVFUpSixRY = [RVFUpSixRY,respCuSixRVFy];
            RVFUpSixAX = [RVFUpSixAX,actCuSixRVFx];
            RVFUpSixAY = [RVFUpSixAY,actCuSixRVFy];
            
            RVFUpSevenRX = [RVFUpSevenRX,respCuSevenRVFx];
            RVFUpSevenRY = [RVFUpSevenRY,respCuSevenRVFy];
            RVFUpSevenAX = [RVFUpSevenAX,actCuSevenRVFx];
            RVFUpSevenAY = [RVFUpSevenAY,actCuSevenRVFy];
            
            RVFUpEightRX = [RVFUpEightRX,respCuEightRVFx];
            RVFUpEightRY = [RVFUpEightRY,respCuEightRVFy];
            RVFUpEightAX = [RVFUpEightAX,actCuEightRVFx];
            RVFUpEightAY = [RVFUpEightAY,actCuEightRVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%% LVF Down Saccade %%%%%%%%%%%%%%%%%%%%
            LVFDownOneRX = [LVFDownOneRX,respCdOneLVFx];
            LVFDownOneRY = [LVFDownOneRY,respCdOneLVFy];
            LVFDownOneAX = [LVFDownOneAX,actCdOneLVFx];
            LVFDownOneAY = [LVFDownOneAY,actCdOneLVFy];
            
            LVFDownTwoRX = [LVFDownTwoRX,respCdTwoLVFx];
            LVFDownTwoRY = [LVFDownTwoRY,respCdTwoLVFy];
            LVFDownTwoAX = [LVFDownTwoAX,actCdTwoLVFx];
            LVFDownTwoAY = [LVFDownTwoAY,actCdTwoLVFy];
            
            LVFDownThreeRX = [LVFDownThreeRX,respCdThreeLVFx];
            LVFDownThreeRY = [LVFDownThreeRY,respCdThreeLVFy];
            LVFDownThreeAX = [LVFDownThreeAX,actCdThreeLVFx];
            LVFDownThreeAY = [LVFDownThreeAY,actCdThreeLVFy];
            
            LVFDownFiveRX = [LVFDownFiveRX,respCdFiveLVFx];
            LVFDownFiveRY = [LVFDownFiveRY,respCdFiveLVFy];
            LVFDownFiveAX = [LVFDownFiveAX,actCdFiveLVFx];
            LVFDownFiveAY = [LVFDownFiveAY,actCdFiveLVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%% RVF Down Saccade %%%%%%%%%%%%%%%%%%%%
            RVFDownFourRX = [RVFDownFourRX,respCdFourRVFx];
            RVFDownFourRY = [RVFDownFourRY,respCdFourRVFy];
            RVFDownFourAX = [RVFDownFourAX,actCdFourRVFx];
            RVFDownFourAY = [RVFDownFourAY,actCdFourRVFy];
            
            RVFDownSixRX = [RVFDownSixRX,respCdSixRVFx];
            RVFDownSixRY = [RVFDownSixRY,respCdSixRVFy];
            RVFDownSixAX = [RVFDownSixAX,actCdSixRVFx];
            RVFDownSixAY = [RVFDownSixAY,actCdSixRVFy];
            
            RVFDownSevenRX = [RVFDownSevenRX,respCdSevenRVFx];
            RVFDownSevenRY = [RVFDownSevenRY,respCdSevenRVFy];
            RVFDownSevenAX = [RVFDownSevenAX,actCdSevenRVFx];
            RVFDownSevenAY = [RVFDownSevenAY,actCdSevenRVFy];
            
            RVFDownEightRX = [RVFDownEightRX,respCdEightRVFx];
            RVFDownEightRY = [RVFDownEightRY,respCdEightRVFy];
            RVFDownEightAX = [RVFDownEightAX,actCdEightRVFx];
            RVFDownEightAY = [RVFDownEightAY,actCdEightRVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            
            end
            
           
            % plot a specific actual stimulus location
            iX = theData.StimLocNoJitterX(theData.uniqueLocXY==uniqueLocs(i));
            iY = theData.StimLocNoJitterY(theData.uniqueLocXY==uniqueLocs(i));
            
            if rl_plot
                scatter(LVFux,LVFuy,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(LVFdx,LVFdy,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                % scatter(iHorClusterX,iHorClusterY,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                %scatter(RVFux, RVFuy,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                %scatter(RVFdx,RVFdy,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(LVFactualux,LVFactualuy,75,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none');
                %scatter(RVFactualux,RVFactualuy,75,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none');
                % adjust figure size automatically based on actual stimulus location
                axis([min(theData.StimLocNoJitterX)-200, ...
                    max(theData.StimLocNoJitterX)+200, ...
                    min(theData.StimLocNoJitterY)-200, ...
                    max(theData.StimLocNoJitterY)+200],'square');
            end
            
            if do_plot
                scatter(iClusterX,iClusterY,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                % scatter(iHorClusterX,iHorClusterY,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(iX,iY, 75,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none');
                % adjust figure size automatically based on actual stimulus location
                axis([min(theData.StimLocNoJitterX)-200, ...
                    max(theData.StimLocNoJitterX)+200, ...
                    min(theData.StimLocNoJitterY)-200, ...
                    max(theData.StimLocNoJitterY)+200],'square');
            end
            
            if vh_plot
                scatter(iVCx,iVCy,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(iX,iY,75,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none');
                % adjust figure size automatically based on actual stimulus location
                axis([min(theData.StimLocNoJitterX)-100, ...
                    max(theData.StimLocNoJitterX)+100, ...
                    min(theData.StimLocNoJitterY)-100, ...
                    max(theData.StimLocNoJitterY)+100],'square');
            end
        end
    end
    
    
    %% outlier detection and removal using euclidean distances, and calculate std of each cluster
    if do_plot
        figure(); hold on; set(gcf, 'color','w'); box on; grid on;
        title('Second look with outliers removed');
    end
    for i = 1:length(uniqueLocs)
        for iBlock = 1:length(blocks)
            %% Load data
            load(['C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\SMptcp',num2str(subs(iSub)),'\block',num2str(blocks(iBlock)),'\TSWM.mat']);
            % Get responses and actual stim location for a given cluster
            %% Remove Jitter & integrate X and Y to create 8 unique location identifier array
            theData.StimLocNoJitterX = theData.selXingsX - theData.stimJitterX;
            theData.StimLocNoJitterY = theData.selXingsY - theData.stimJitterY;
            theData.RespLocNoJitterX = theData.responseX - theData.stimJitterX;
            theData.RespLocNoJitterY = theData.responseY - theData.stimJitterY;
            % Below gives each coordinate for every trial a unique value in order
            % to separate out the clusters:
            theData.uniqueLocXY = round(sqrt((theData.StimLocNoJitterX.^2) + (theData.StimLocNoJitterY.^2)),2);
            
            iClusterX = theData.RespLocNoJitterX(theData.uniqueLocXY==uniqueLocs(i));
            iClusterY = theData.RespLocNoJitterY(theData.uniqueLocXY==uniqueLocs(i));
            iX = theData.StimLocNoJitterX(theData.uniqueLocXY==uniqueLocs(i));
            iY = theData.StimLocNoJitterY(theData.uniqueLocXY==uniqueLocs(i));
            
            
            % calculate euclidean distances
            eucDist = calc_eucDist(iClusterX,iX,iClusterY,iY);
            
            % z-transform
            z_eucDist = zscore(eucDist);

            % remove outliers based on pre-determined threshold
            iClusterX = iClusterX(z_eucDist<outlier_thresh);
            iClusterY = iClusterY(z_eucDist<outlier_thresh);
            
            
            % calculate cluster-wise standard deviations for each cluster separately
            GroupResults.std_x(iSub,iBlock,i) = nanstd(iClusterX);
            GroupResults.std_y(iSub,iBlock,i) = nanstd(iClusterY);
            
            
            if do_plot
                % plot the clusters
                scatter(iClusterX,iClusterY,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(iX,iY,75,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none');
                
                % adjust figure size automatically based on actual stimulus location
                axis([min(theData.StimLocNoJitterX)-200, ...
                    max(theData.StimLocNoJitterX)+200, ...
                    min(theData.StimLocNoJitterY)-200, ...
                    max(theData.StimLocNoJitterY)+200],'square');
            end
        end
              
        %% Calculate euclidean distances
        
        % Up Saccade LVF        
        eucDistULVFOne = calc_eucDist(LVFUpOneRX,LVFUpOneRY,LVFUpOneAX,LVFUpOneAY);
        eucDistULVFTwo = calc_eucDist(LVFUpTwoRX,LVFUpTwoRY,LVFUpTwoAX,LVFUpTwoAY);
        eucDistULVFThree = calc_eucDist(LVFUpThreeRX,LVFUpThreeRY,LVFUpThreeAX,LVFUpThreeAY);
        eucDistULVFFive = calc_eucDist(LVFUpFiveRX,LVFUpFiveRY,LVFUpFiveAX,LVFUpFiveAY);
        
        % Up Saccade RVF        
        eucDistURVFFour = calc_eucDist(RVFUpFourRX,RVFUpFourRY,RVFUpFourAX,RVFUpFourAY);
        eucDistURVFSix = calc_eucDist(RVFUpSixRX,RVFUpSixRY,RVFUpSixAX,RVFUpSixAY);
        eucDistURVFSeven = calc_eucDist(RVFUpSevenRX,RVFUpSevenRY,RVFUpSevenAX,RVFUpSevenAY);
        eucDistURVFEight = calc_eucDist(RVFUpEightRX,RVFUpEightRY,RVFUpEightAX,RVFUpEightAY);
        
        % Down Saccade LVF
        eucDistDLVFOne = calc_eucDist(LVFDownOneRX,LVFDownOneRY,LVFDownOneAX,LVFDownOneAY);
        eucDistDLVFTwo = calc_eucDist(LVFDownTwoRX,LVFDownTwoRY,LVFDownTwoAX,LVFDownTwoAY);
        eucDistDLVFThree = calc_eucDist(LVFDownThreeRX,LVFDownThreeRY,LVFDownThreeAX,LVFDownThreeAY);
        eucDistDLVFFive = calc_eucDist(LVFDownFiveRX,LVFDownFiveRY,LVFDownFiveAX,LVFDownFiveAY);
        
        % Down Saccade RVF
        eucDistDRVFFour = calc_eucDist(RVFDownFourRX,RVFDownFourRY,RVFDownFourAX,RVFDownFourAY);
        eucDistDRVFSix = calc_eucDist(RVFDownSixRX,RVFDownSixRY,RVFDownSixAX,RVFDownSixAY);
        eucDistDRVFSeven = calc_eucDist(RVFDownSevenRX,RVFDownSevenRY,RVFDownSevenAX,RVFDownSevenAY);
        eucDistDRVFEight = calc_eucDist(RVFDownEightRX,RVFDownEightRY,RVFDownEightAX,RVFDownEightAY);
        
        
        %% z-transform
        
        % Up Saccade LVF
        
        z_eucDistULVFOne = zscore(eucDistULVFOne);
        z_eucDistULVFTwo = zscore(eucDistULVFTwo);
        z_eucDistULVFThree = zscore(eucDistULVFThree);
        z_eucDistULVFFive = zscore(eucDistULVFFive);
        
        % Up Saccade RVF
        
        z_eucDistURVFFour = zscore(eucDistURVFFour);
        z_eucDistURVFSix = zscore(eucDistURVFSix);
        z_eucDistURVFSeven = zscore(eucDistURVFSeven);
        z_eucDistURVFEight = zscore(eucDistURVFEight);

        % Down Saccade LVF
        
        z_eucDistDLVFOne = zscore(eucDistDLVFOne);
        z_eucDistDLVFTwo = zscore(eucDistDLVFTwo);
        z_eucDistDLVFThree = zscore(eucDistDLVFThree);
        z_eucDistDLVFFive = zscore(eucDistDLVFFive);
        
        % Down Saccade RVF
        z_eucDistDRVFFour = zscore(eucDistDRVFFour);
        z_eucDistDRVFSix = zscore(eucDistDRVFSix);
        z_eucDistDRVFSeven = zscore(eucDistDRVFSeven);
        z_eucDistDRVFEight = zscore(eucDistDRVFEight);
        
        %% Remove outliers based on pre-determined threshold
        
        % LVFUp        
        LVFUpOneRX = LVFUpOneRX(z_eucDistULVFOne<outlier_thresh);
        LVFUpOneRY = LVFUpOneRY(z_eucDistULVFOne<outlier_thresh);
        
        LVFUpTwoRX = LVFUpTwoRX(z_eucDistULVFTwo<outlier_thresh);
        LVFUpTwoRY = LVFUpTwoRY(z_eucDistULVFTwo<outlier_thresh);
        
        LVFUpThreeRX = LVFUpThreeRX(z_eucDistULVFThree<outlier_thresh);
        LVFUpThreeRY = LVFUpThreeRY(z_eucDistULVFThree<outlier_thresh);
        
        LVFUpFiveRX = LVFUpFiveRX(z_eucDistULVFFive<outlier_thresh);
        LVFUpFiveRY = LVFUpFiveRY(z_eucDistULVFFive<outlier_thresh);
        
        % RVFUp
        
        RVFUpFourRX = RVFUpFourRX(z_eucDistURVFFour<outlier_thresh);
        RVFUpFourRY = RVFUpFourRY(z_eucDistURVFFour<outlier_thresh);
        
        RVFUpSixRX = RVFUpSixRX(z_eucDistURVFSix<outlier_thresh);
        RVFUpSixRY = RVFUpSixRY(z_eucDistURVFSix<outlier_thresh);
        
        RVFUpSevenRX = RVFUpSevenRX(z_eucDistURVFSeven<outlier_thresh);
        RVFUpSevenRY = RVFUpSevenRY(z_eucDistURVFSeven<outlier_thresh);
        
        RVFUpEightRX = RVFUpEightRX(z_eucDistURVFEight<outlier_thresh);
        RVFUpEightRY = RVFUpEightRY(z_eucDistURVFEight<outlier_thresh);
        
        % LVFDown
        
        LVFDownOneRX = LVFDownOneRX(z_eucDistDLVFOne<outlier_thresh);
        LVFDownOneRY = LVFDownOneRY(z_eucDistDLVFOne<outlier_thresh);
        
        LVFDownTwoRX = LVFDownTwoRX(z_eucDistDLVFTwo<outlier_thresh);
        LVFDownTwoRY = LVFDownTwoRY(z_eucDistDLVFTwo<outlier_thresh);
        
        LVFDownThreeRX = LVFDownThreeRX(z_eucDistDLVFThree<outlier_thresh);
        LVFDownThreeRY = LVFDownThreeRY(z_eucDistDLVFThree<outlier_thresh);
        
        LVFDownFiveRX = LVFDownFiveRX(z_eucDistDLVFFive<outlier_thresh);
        LVFDownFiveRY = LVFDownFiveRY(z_eucDistDLVFFive<outlier_thresh);
        
         % RVFDown
         
        RVFDownFourRX = RVFDownFourRX(z_eucDistDRVFFour<outlier_thresh);
        RVFDownFourRY = RVFDownFourRY(z_eucDistDRVFFour<outlier_thresh);
        
        RVFDownSixRX = RVFDownSixRX(z_eucDistDRVFSix<outlier_thresh);
        RVFDownSixRY = RVFDownSixRY(z_eucDistDRVFSix<outlier_thresh);
        
        RVFDownSevenRX = RVFDownSevenRX(z_eucDistDRVFSeven<outlier_thresh);
        RVFDownSevenRY = RVFDownSevenRY(z_eucDistDRVFSeven<outlier_thresh);
        
        RVFDownEightRX = RVFDownEightRX(z_eucDistDRVFEight<outlier_thresh);
        RVFDownEightRY = RVFDownEightRY(z_eucDistDRVFEight<outlier_thresh);

        %% Calculating the Std of each condition
        
        % standard deviation of Up saccade and LVF condition
        ULVFOneX = nanstd(LVFUpOneRX);
        ULVFOneY = nanstd(LVFUpOneRY);

        ULVFTwoX = nanstd(LVFUpTwoRX);
        ULVFTwoY = nanstd(LVFUpTwoRY);
        
        ULVFThreeX = nanstd(LVFUpThreeRX);
        ULVFThreeY = nanstd(LVFUpThreeRY);
        
        ULVFFiveX = nanstd(LVFUpFiveRX);
        ULVFFiveY = nanstd(LVFUpFiveRY);
        
        ULVFx = mean([ULVFOneX,ULVFTwoX,ULVFThreeX,ULVFFiveX]);
        ULVFy = mean([ULVFOneY,ULVFTwoY,ULVFThreeY,ULVFFiveY]);
        
        
        % standard deviation of Up saccade and RVF condition
        URVFFourX = nanstd(RVFUpFourRX);
        URVFFourY = nanstd(RVFUpFourRY);
        
        URVFSixX = nanstd(RVFUpSixRX);
        URVFSixY = nanstd(RVFUpSixRY);
        
        URVFSevenX = nanstd(RVFUpSevenRX);
        URVFSevenY = nanstd(RVFUpSevenRY);
        
        URVFEightX = nanstd(RVFUpEightRX);
        URVFEightY = nanstd(RVFUpEightRY);
        
        URVFx = mean([URVFFourX,URVFSixX,URVFSevenX,URVFEightX]);
        URVFy = mean([URVFFourY,URVFSixY,URVFSevenY,URVFEightY]);
        
        % standard deviation of Down saccade and LVF condition
        
        DLVFOneX = nanstd(LVFDownOneRX);
        DLVFOneY = nanstd(LVFDownOneRY);

        DLVFTwoX = nanstd(LVFDownTwoRX);
        DLVFTwoY = nanstd(LVFDownTwoRY);
        
        DLVFThreeX = nanstd(LVFDownThreeRX);
        DLVFThreeY = nanstd(LVFDownThreeRY);
        
        DLVFFiveX = nanstd(LVFDownFiveRX);
        DLVFFiveY = nanstd(LVFDownFiveRY);
        
        DLVFx = mean([DLVFOneX,DLVFTwoX,DLVFThreeX,DLVFFiveX]);
        DLVFy = mean([DLVFOneY,DLVFTwoY,DLVFThreeY,DLVFFiveY]);
        
        % standard deviation of Down saccade and RVF condition
        
        DRVFFourX = nanstd(RVFDownFourRX);
        DRVFFourY = nanstd(RVFDownFourRY);
        
        DRVFSixX = nanstd(RVFDownSixRX);
        DRVFSixY = nanstd(RVFDownSixRY);
        
        DRVFSevenX = nanstd(RVFDownSevenRX);
        DRVFSevenY = nanstd(RVFDownSevenRY);
        
        DRVFEightX = nanstd(RVFDownEightRX);
        DRVFEightY = nanstd(RVFDownEightRY);
        
        DRVFx = mean([DRVFFourX,DRVFSixX,DRVFSevenX,DRVFEightX]);
        DRVFy = mean([DRVFFourY,DRVFSixY,DRVFSevenY,DRVFEightY]);
       
        
    end
    
    %% loading variables with Std values:
    
    % Left Saccade LVF
    UpSaccLVF.std_x(iSub,1) = ULVFx;
    UpSaccLVF.std_y(iSub,1) = ULVFy;
    
    % Left Saccade RVF
    UpSaccRVF.std_x(iSub,1) = URVFx;
    UpSaccRVF.std_y(iSub,1) = URVFy;
    
    % Right Saccade LVF
    DownSaccLVF.std_x(iSub,1) = DLVFx;
    DownSaccLVF.std_y(iSub,1) = DLVFy;
   
    % Right Saccade RVF
    DownSaccRVF.std_x(iSub,1) = DRVFx;
    DownSaccRVF.std_y(iSub,1) = DRVFy;
 
end

%% save for now
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\UpSaccLVF\UpSaccLVF.mat','UpSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\UpSaccRVF\UpSaccRVF.mat','UpSaccRVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\DownSaccLVF\DownSaccLVF.mat','DownSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\DownSaccRVF\DownSaccRVF.mat','DownSaccRVF');



%% save updated info with additional participants: SegmAdditionalPTCP\
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccLVF\UpSaccLVF.mat','UpSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\UpSaccRVF\UpSaccRVF.mat','UpSaccRVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccLVF\DownSaccLVF.mat','DownSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\DownSaccRVF\DownSaccRVF.mat','DownSaccRVF');
% 

%% In script functions
function eucDist=calc_eucDist(x1,x2,y1,y2)
eucDist = sqrt(((x1-x2).^2)+((y1-y2).^2));
end