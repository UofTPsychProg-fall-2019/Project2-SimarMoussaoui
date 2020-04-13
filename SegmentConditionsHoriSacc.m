%% I want to reset my workspace and command window
close all; clear; clc;
% fprintf
%% Initialize variables
%subs = [2,4,5,7,8,9,11,14,15,23,26,30,32,34,35,36,37,38,39,41,42,43,44];
subs = [2,4,5,7,8,9,11,14,15,23,26,30,32,34,35,36,37,38,39,41,42,43,44,48,50,52,53,54,57,58,59,60,65,68,71];
%subs = [42];
nSubs = length(subs);
outlier_thresh = 3;

LeftSaccLVF.std_x = [];
LeftSaccLVF.std_y = [];

LeftSaccRVF.std_x = [];
LeftSaccRVF.std_y = [];

RightSaccLVF.std_x = [];
RightSaccLVF.std_y = [];

RightSaccRVF.std_x = [];
RightSaccRVF.std_y = [];

GroRightResults.std_x = [];
GroRightResults.std_y = [];

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
        title('Example of participant responses');
    end
    if vh_plot
        figure(); hold on; set(gcf, 'color','w'); box on; grid on;
        title('First look with no outlier removal');
    end
    if rl_plot
        figure(); hold on; set(gcf, 'color','w'); box on; grid on;
        %title('First look with no outlier removal');
    end
    
    %% initializing variables for cluster-wise standard deviation input
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Left - LVF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LVFLeftOneRX = []; LVFLeftOneRY = []; LVFLeftOneAX = []; LVFLeftOneAY = [];
    LVFLeftTwoRX = []; LVFLeftTwoRY = []; LVFLeftTwoAX = []; LVFLeftTwoAY = [];
    LVFLeftThreeRX = []; LVFLeftThreeRY = []; LVFLeftThreeAX = []; LVFLeftThreeAY = [];
    LVFLeftFiveRX = []; LVFLeftFiveRY = []; LVFLeftFiveAX = []; LVFLeftFiveAY = [];
    
    LVFLeftFourRX = []; LVFLeftFourRY = []; LVFLeftFourAX = []; LVFLeftFourAY = [];
    LVFLeftSixRX = []; LVFLeftSixRY = []; LVFLeftSixAX = []; LVFLeftSixAY = [];
    LVFLeftSevenRX = []; LVFLeftSevenRY = []; LVFLeftSevenAX = []; LVFLeftSevenAY = [];
    LVFLeftEightRX = []; LVFLeftEightRY = []; LVFLeftEightAX = []; LVFLeftEightAY = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Left - RVF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    RVFLeftOneRX = []; RVFLeftOneRY = []; RVFLeftOneAX = []; RVFLeftOneAY = [];
    RVFLeftTwoRX = []; RVFLeftTwoRY = []; RVFLeftTwoAX = []; RVFLeftTwoAY = [];
    RVFLeftThreeRX = []; RVFLeftThreeRY = []; RVFLeftThreeAX = []; RVFLeftThreeAY = [];
    RVFLeftFiveRX = []; RVFLeftFiveRY = []; RVFLeftFiveAX = []; RVFLeftFiveAY = [];
    
    RVFLeftFourRX = []; RVFLeftFourRY = []; RVFLeftFourAX = []; RVFLeftFourAY = [];
    RVFLeftSixRX = []; RVFLeftSixRY = []; RVFLeftSixAX = []; RVFLeftSixAY = [];
    RVFLeftSevenRX = []; RVFLeftSevenRY = []; RVFLeftSevenAX = []; RVFLeftSevenAY = [];
    RVFLeftEightRX = []; RVFLeftEightRY = []; RVFLeftEightAX = []; RVFLeftEightAY = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Right - LVF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LVFRightOneRX = []; LVFRightOneRY = []; LVFRightOneAX = []; LVFRightOneAY = [];
    LVFRightTwoRX = []; LVFRightTwoRY = []; LVFRightTwoAX = []; LVFRightTwoAY = [];
    LVFRightThreeRX = []; LVFRightThreeRY = []; LVFRightThreeAX = []; LVFRightThreeAY = [];
    LVFRightFiveRX = []; LVFRightFiveRY = []; LVFRightFiveAX = []; LVFRightFiveAY = [];
    
    LVFRightFourRX = []; LVFRightFourRY = []; LVFRightFourAX = []; LVFRightFourAY = [];
    LVFRightSixRX = []; LVFRightSixRY = []; LVFRightSixAX = []; LVFRightSixAY = [];
    LVFRightSevenRX = []; LVFRightSevenRY = []; LVFRightSevenAX = []; LVFRightSevenAY = [];
    LVFRightEightRX = []; LVFRightEightRY = []; LVFRightEightAX = []; LVFRightEightAY = [];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Right - RVF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    RVFRightOneRX = []; RVFRightOneRY = []; RVFRightOneAX = []; RVFRightOneAY = [];
    RVFRightTwoRX = []; RVFRightTwoRY = []; RVFRightTwoAX = []; RVFRightTwoAY = [];
    RVFRightThreeRX = []; RVFRightThreeRY = []; RVFRightThreeAX = []; RVFRightThreeAY = [];
    RVFRightFiveRX = []; RVFRightFiveRY = []; RVFRightFiveAX = []; RVFRightFiveAY = [];
    
    RVFRightFourRX = []; RVFRightFourRY = []; RVFRightFourAX = []; RVFRightFourAY = [];
    RVFRightSixRX = []; RVFRightSixRY = []; RVFRightSixAX = []; RVFRightSixAY = [];
    RVFRightSevenRX = []; RVFRightSevenRY = []; RVFRightSevenAX = []; RVFRightSevenAY = [];
    RVFRightEightRX = []; RVFRightEightRY = []; RVFRightEightAX = []; RVFRightEightAY = [];
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
            
            %% Below will add all the blocks values to its corresponding cluster
            
            %%%%%%%%%%%%%%%%%%%% LVF Left Saccade %%%%%%%%%%%%%%%%%%%%
            LVFLeftOneRX = [LVFLeftOneRX,respClOneLVFx];
            LVFLeftOneRY = [LVFLeftOneRY,respClOneLVFy];
            LVFLeftOneAX = [LVFLeftOneAX,actClOneLVFx];
            LVFLeftOneAY = [LVFLeftOneAY,actClOneLVFy];
            
            LVFLeftTwoRX = [LVFLeftTwoRX,respClTwoLVFx];
            LVFLeftTwoRY = [LVFLeftTwoRY,respClTwoLVFy];
            LVFLeftTwoAX = [LVFLeftTwoAX,actClTwoLVFx];
            LVFLeftTwoAY = [LVFLeftTwoAY,actClTwoLVFy];
            
            LVFLeftThreeRX = [LVFLeftThreeRX,respClThreeLVFx];
            LVFLeftThreeRY = [LVFLeftThreeRY,respClThreeLVFy];
            LVFLeftThreeAX = [LVFLeftThreeAX,actClThreeLVFx];
            LVFLeftThreeAY = [LVFLeftThreeAY,actClThreeLVFy];
            
            LVFLeftFiveRX = [LVFLeftFiveRX,respClFiveLVFx];
            LVFLeftFiveRY = [LVFLeftFiveRY,respClFiveLVFy];
            LVFLeftFiveAX = [LVFLeftFiveAX,actClFiveLVFx];
            LVFLeftFiveAY = [LVFLeftFiveAY,actClFiveLVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%% RVF Left Saccade %%%%%%%%%%%%%%%%%%%%
            RVFLeftFourRX = [RVFLeftFourRX,respClFourRVFx];
            RVFLeftFourRY = [RVFLeftFourRY,respClFourRVFy];
            RVFLeftFourAX = [RVFLeftFourAX,actClFourRVFx];
            RVFLeftFourAY = [RVFLeftFourAY,actClFourRVFy];
            
            RVFLeftSixRX = [RVFLeftSixRX,respClSixRVFx];
            RVFLeftSixRY = [RVFLeftSixRY,respClSixRVFy];
            RVFLeftSixAX = [RVFLeftSixAX,actClSixRVFx];
            RVFLeftSixAY = [RVFLeftSixAY,actClSixRVFy];
            
            RVFLeftSevenRX = [RVFLeftSevenRX,respClSevenRVFx];
            RVFLeftSevenRY = [RVFLeftSevenRY,respClSevenRVFy];
            RVFLeftSevenAX = [RVFLeftSevenAX,actClSevenRVFx];
            RVFLeftSevenAY = [RVFLeftSevenAY,actClSevenRVFy];
            
            RVFLeftEightRX = [RVFLeftEightRX,respClEightRVFx];
            RVFLeftEightRY = [RVFLeftEightRY,respClEightRVFy];
            RVFLeftEightAX = [RVFLeftEightAX,actClEightRVFx];
            RVFLeftEightAY = [RVFLeftEightAY,actClEightRVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%% LVF Right Saccade %%%%%%%%%%%%%%%%%%%%
            LVFRightOneRX = [LVFRightOneRX,respCrOneLVFx];
            LVFRightOneRY = [LVFRightOneRY,respCrOneLVFy];
            LVFRightOneAX = [LVFRightOneAX,actCrOneLVFx];
            LVFRightOneAY = [LVFRightOneAY,actCrOneLVFy];
            
            LVFRightTwoRX = [LVFRightTwoRX,respCrTwoLVFx];
            LVFRightTwoRY = [LVFRightTwoRY,respCrTwoLVFy];
            LVFRightTwoAX = [LVFRightTwoAX,actCrTwoLVFx];
            LVFRightTwoAY = [LVFRightTwoAY,actCrTwoLVFy];
            
            LVFRightThreeRX = [LVFRightThreeRX,respCrThreeLVFx];
            LVFRightThreeRY = [LVFRightThreeRY,respCrThreeLVFy];
            LVFRightThreeAX = [LVFRightThreeAX,actCrThreeLVFx];
            LVFRightThreeAY = [LVFRightThreeAY,actCrThreeLVFy];
            
            LVFRightFiveRX = [LVFRightFiveRX,respCrFiveLVFx];
            LVFRightFiveRY = [LVFRightFiveRY,respCrFiveLVFy];
            LVFRightFiveAX = [LVFRightFiveAX,actCrFiveLVFx];
            LVFRightFiveAY = [LVFRightFiveAY,actCrFiveLVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%% RVF Right Saccade %%%%%%%%%%%%%%%%%%%%
            RVFRightFourRX = [RVFRightFourRX,respCrFourRVFx];
            RVFRightFourRY = [RVFRightFourRY,respCrFourRVFy];
            RVFRightFourAX = [RVFRightFourAX,actCrFourRVFx];
            RVFRightFourAY = [RVFRightFourAY,actCrFourRVFy];
            
            RVFRightSixRX = [RVFRightSixRX,respCrSixRVFx];
            RVFRightSixRY = [RVFRightSixRY,respCrSixRVFy];
            RVFRightSixAX = [RVFRightSixAX,actCrSixRVFx];
            RVFRightSixAY = [RVFRightSixAY,actCrSixRVFy];
            
            RVFRightSevenRX = [RVFRightSevenRX,respCrSevenRVFx];
            RVFRightSevenRY = [RVFRightSevenRY,respCrSevenRVFy];
            RVFRightSevenAX = [RVFRightSevenAX,actCrSevenRVFx];
            RVFRightSevenAY = [RVFRightSevenAY,actCrSevenRVFy];
            
            RVFRightEightRX = [RVFRightEightRX,respCrEightRVFx];
            RVFRightEightRY = [RVFRightEightRY,respCrEightRVFy];
            RVFRightEightAX = [RVFRightEightAX,actCrEightRVFx];
            RVFRightEightAY = [RVFRightEightAY,actCrEightRVFy];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            end
            
           
            % plot a specific actual stimulus location
            iX = theData.StimLocNoJitterX(theData.uniqueLocXY==uniqueLocs(i));
            iY = theData.StimLocNoJitterY(theData.uniqueLocXY==uniqueLocs(i));
            
            if rl_plot
                scatter(LVFlx,LVFly,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(LVFrx,LVFry,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                % scatter(iHorClusterX,iHorClusterY,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(RVFlx, RVFly,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(RVFrx,RVFry,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none','MarkerFaceAlpha',0.3)
                scatter(LVFactualx,LVFactualy,75,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none');
                scatter(RVFactualx,RVFactualy,75,'MarkerFaceColor',colours(i,:),'MarkerEdgeColor','none');
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
        title('Participant responses and actual location of memory array');
    end
    for i = 1:length(uniqueLocs)
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
            % Get responses and actual stim location for a given cluster
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
            GroRightResults.std_x(iSub,iBlock,i) = nanstd(iClusterX);
            GroRightResults.std_y(iSub,iBlock,i) = nanstd(iClusterY);
            
            
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
        
        % Left Saccade LVF
        eucDistLLVFOne = calc_eucDist(LVFLeftOneRX,LVFLeftOneRY,LVFLeftOneAX,LVFLeftOneAY);
        eucDistLLVFTwo = calc_eucDist(LVFLeftTwoRX,LVFLeftTwoRY,LVFLeftTwoAX,LVFLeftTwoAY);
        eucDistLLVFThree = calc_eucDist(LVFLeftThreeRX,LVFLeftThreeRY,LVFLeftThreeAX,LVFLeftThreeAY);
        eucDistLLVFFive = calc_eucDist(LVFLeftFiveRX,LVFLeftFiveRY,LVFLeftFiveAX,LVFLeftFiveAY);
        
        % Left Saccade RVF
        eucDistLRVFFour = calc_eucDist(RVFLeftFourRX,RVFLeftFourRY,RVFLeftFourAX,RVFLeftFourAY);
        eucDistLRVFSix = calc_eucDist(RVFLeftSixRX,RVFLeftSixRY,RVFLeftSixAX,RVFLeftSixAY);
        eucDistLRVFSeven = calc_eucDist(RVFLeftSevenRX,RVFLeftSevenRY,RVFLeftSevenAX,RVFLeftSevenAY);
        eucDistLRVFEight = calc_eucDist(RVFLeftEightRX,RVFLeftEightRY,RVFLeftEightAX,RVFLeftEightAY);
        
        % Right Saccade LVF
        eucDistRLVFOne = calc_eucDist(LVFRightOneRX,LVFRightOneRY,LVFRightOneAX,LVFRightOneAY);
        eucDistRLVFTwo = calc_eucDist(LVFRightTwoRX,LVFRightTwoRY,LVFRightTwoAX,LVFRightTwoAY);
        eucDistRLVFThree = calc_eucDist(LVFRightThreeRX,LVFRightThreeRY,LVFRightThreeAX,LVFRightThreeAY);
        eucDistRLVFFive = calc_eucDist(LVFRightFiveRX,LVFRightFiveRY,LVFRightFiveAX,LVFRightFiveAY);
        
        % Right Saccade RVF
        eucDistRRVFFour = calc_eucDist(RVFRightFourRX,RVFRightFourRY,RVFRightFourAX,RVFRightFourAY);
        eucDistRRVFSix = calc_eucDist(RVFRightSixRX,RVFRightSixRY,RVFRightSixAX,RVFRightSixAY);
        eucDistRRVFSeven = calc_eucDist(RVFRightSevenRX,RVFRightSevenRY,RVFRightSevenAX,RVFRightSevenAY);
        eucDistRRVFEight = calc_eucDist(RVFRightEightRX,RVFRightEightRY,RVFRightEightAX,RVFRightEightAY);
        
        
        %% z-transform
        
        % Left Saccade LVF
        z_eucDistLLVFOne = zscore(eucDistLLVFOne);
        z_eucDistLLVFTwo = zscore(eucDistLLVFTwo);
        z_eucDistLLVFThree = zscore(eucDistLLVFThree);
        z_eucDistLLVFFive = zscore(eucDistLLVFFive);
        
        % Left Saccade RVF
        z_eucDistLRVFFour = zscore(eucDistLRVFFour);
        z_eucDistLRVFSix = zscore(eucDistLRVFSix);
        z_eucDistLRVFSeven = zscore(eucDistLRVFSeven);
        z_eucDistLRVFEight = zscore(eucDistLRVFEight);

        % Right Saccade LVF
        z_eucDistRLVFOne = zscore(eucDistRLVFOne);
        z_eucDistRLVFTwo = zscore(eucDistRLVFTwo);
        z_eucDistRLVFThree = zscore(eucDistRLVFThree);
        z_eucDistRLVFFive = zscore(eucDistRLVFFive);
        
        % Right Saccade RVF
        z_eucDistRRVFFour = zscore(eucDistRRVFFour);
        z_eucDistRRVFSix = zscore(eucDistRRVFSix);
        z_eucDistRRVFSeven = zscore(eucDistRRVFSeven);
        z_eucDistRRVFEight = zscore(eucDistRRVFEight);
        
        %% Remove outliers based on pre-determined threshold
        
        % LVFLeft
        LVFLeftOneRX = LVFLeftOneRX(z_eucDistLLVFOne<outlier_thresh);
        LVFLeftOneRY = LVFLeftOneRY(z_eucDistLLVFOne<outlier_thresh);
        
        LVFLeftTwoRX = LVFLeftTwoRX(z_eucDistLLVFTwo<outlier_thresh);
        LVFLeftTwoRY = LVFLeftTwoRY(z_eucDistLLVFTwo<outlier_thresh);
        
        LVFLeftThreeRX = LVFLeftThreeRX(z_eucDistLLVFThree<outlier_thresh);
        LVFLeftThreeRY = LVFLeftThreeRY(z_eucDistLLVFThree<outlier_thresh);
        
        LVFLeftFiveRX = LVFLeftFiveRX(z_eucDistLLVFFive<outlier_thresh);
        LVFLeftFiveRY = LVFLeftFiveRY(z_eucDistLLVFFive<outlier_thresh);
        
        % RVFLeft
        RVFLeftFourRX = RVFLeftFourRX(z_eucDistLRVFFour<outlier_thresh);
        RVFLeftFourRY = RVFLeftFourRY(z_eucDistLRVFFour<outlier_thresh);
        
        RVFLeftSixRX = RVFLeftSixRX(z_eucDistLRVFSix<outlier_thresh);
        RVFLeftSixRY = RVFLeftSixRY(z_eucDistLRVFSix<outlier_thresh);
        
        RVFLeftSevenRX = RVFLeftSevenRX(z_eucDistLRVFSeven<outlier_thresh);
        RVFLeftSevenRY = RVFLeftSevenRY(z_eucDistLRVFSeven<outlier_thresh);
        
        RVFLeftEightRX = RVFLeftEightRX(z_eucDistLRVFEight<outlier_thresh);
        RVFLeftEightRY = RVFLeftEightRY(z_eucDistLRVFEight<outlier_thresh);
        
        % LVFRight
        LVFRightOneRX = LVFRightOneRX(z_eucDistRLVFOne<outlier_thresh);
        LVFRightOneRY = LVFRightOneRY(z_eucDistRLVFOne<outlier_thresh);
        
        LVFRightTwoRX = LVFRightTwoRX(z_eucDistRLVFTwo<outlier_thresh);
        LVFRightTwoRY = LVFRightTwoRY(z_eucDistRLVFTwo<outlier_thresh);
        
        LVFRightThreeRX = LVFRightThreeRX(z_eucDistRLVFThree<outlier_thresh);
        LVFRightThreeRY = LVFRightThreeRY(z_eucDistRLVFThree<outlier_thresh);
        
        LVFRightFiveRX = LVFRightFiveRX(z_eucDistRLVFFive<outlier_thresh);
        LVFRightFiveRY = LVFRightFiveRY(z_eucDistRLVFFive<outlier_thresh);
        
        % RVFRight
        RVFRightFourRX = RVFRightFourRX(z_eucDistRRVFFour<outlier_thresh);
        RVFRightFourRY = RVFRightFourRY(z_eucDistRRVFFour<outlier_thresh);
        
        RVFRightSixRX = RVFRightSixRX(z_eucDistRRVFSix<outlier_thresh);
        RVFRightSixRY = RVFRightSixRY(z_eucDistRRVFSix<outlier_thresh);
        
        RVFRightSevenRX = RVFRightSevenRX(z_eucDistRRVFSeven<outlier_thresh);
        RVFRightSevenRY = RVFRightSevenRY(z_eucDistRRVFSeven<outlier_thresh);
        
        RVFRightEightRX = RVFRightEightRX(z_eucDistRRVFEight<outlier_thresh);
        RVFRightEightRY = RVFRightEightRY(z_eucDistRRVFEight<outlier_thresh);

        %% Calculating the Std of each condition
        
        % standard deviation of Left saccade and LVF condition
        LLVFOneX = nanstd(LVFLeftOneRX);
        LLVFOneY = nanstd(LVFLeftOneRY);

        LLVFTwoX = nanstd(LVFLeftTwoRX);
        LLVFTwoY = nanstd(LVFLeftTwoRY);
        
        LLVFThreeX = nanstd(LVFLeftThreeRX);
        LLVFThreeY = nanstd(LVFLeftThreeRY);
        
        LLVFFiveX = nanstd(LVFLeftFiveRX);
        LLVFFiveY = nanstd(LVFLeftFiveRY);
        
        LLVFx = mean([LLVFOneX,LLVFTwoX,LLVFThreeX,LLVFFiveX]);
        LLVFy = mean([LLVFOneY,LLVFTwoY,LLVFThreeY,LLVFFiveY]);
        
        % standard deviation of Left saccade and RVF condition
        LRVFFourX = nanstd(RVFLeftFourRX);
        LRVFFourY = nanstd(RVFLeftFourRY);
        
        LRVFSixX = nanstd(RVFLeftSixRX);
        LRVFSixY = nanstd(RVFLeftSixRY);
        
        LRVFSevenX = nanstd(RVFLeftSevenRX);
        LRVFSevenY = nanstd(RVFLeftSevenRY);
        
        LRVFEightX = nanstd(RVFLeftEightRX);
        LRVFEightY = nanstd(RVFLeftEightRY);
        
        LRVFx = mean([LRVFFourX,LRVFSixX,LRVFSevenX,LRVFEightX]);
        LRVFy = mean([LRVFFourY,LRVFSixY,LRVFSevenY,LRVFEightY]);
        
        % standard deviation of Right saccade and LVF condition
        RLVFOneX = nanstd(LVFRightOneRX);
        RLVFOneY = nanstd(LVFRightOneRY);

        RLVFTwoX = nanstd(LVFRightTwoRX);
        RLVFTwoY = nanstd(LVFRightTwoRY);
        
        RLVFThreeX = nanstd(LVFRightThreeRX);
        RLVFThreeY = nanstd(LVFRightThreeRY);
        
        RLVFFiveX = nanstd(LVFRightFiveRX);
        RLVFFiveY = nanstd(LVFRightFiveRY);
        
        RLVFx = mean([RLVFOneX,RLVFTwoX,RLVFThreeX,RLVFFiveX]);
        RLVFy = mean([RLVFOneY,RLVFTwoY,RLVFThreeY,RLVFFiveY]);
        
        % standard deviation of Right saccade and RVF condition
        RRVFFourX = nanstd(RVFRightFourRX);
        RRVFFourY = nanstd(RVFRightFourRY);
        
        RRVFSixX = nanstd(RVFRightSixRX);
        RRVFSixY = nanstd(RVFRightSixRY);
        
        RRVFSevenX = nanstd(RVFRightSevenRX);
        RRVFSevenY = nanstd(RVFRightSevenRY);
        
        RRVFEightX = nanstd(RVFRightEightRX);
        RRVFEightY = nanstd(RVFRightEightRY);
        
        RRVFx = mean([RRVFFourX,RRVFSixX,RRVFSevenX,RRVFEightX]);
        RRVFy = mean([RRVFFourY,RRVFSixY,RRVFSevenY,RRVFEightY]);
       
        
    end
    
    %% loading variables with Std values:
    
    % Left Saccade LVF
    LeftSaccLVF.std_x(iSub,1) = LLVFx;
    LeftSaccLVF.std_y(iSub,1) = LLVFy;
    % Left Saccade RVF
    LeftSaccRVF.std_x(iSub,1) = LRVFx;
    LeftSaccRVF.std_y(iSub,1) = LRVFy;
    
    % Right Saccade LVF
    RightSaccLVF.std_x(iSub,1) = RLVFx;
    RightSaccLVF.std_y(iSub,1) = RRVFy;
    % Right Saccade RVF
    RightSaccRVF.std_x(iSub,1) = RRVFx;
    RightSaccRVF.std_y(iSub,1) = RRVFy;
 
end

%% save for now
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\LeftSaccLVF\LeftSaccLVF.mat','LeftSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\LeftSaccRVF\LeftSaccRVF.mat','LeftSaccRVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\RightSaccLVF\RightSaccLVF.mat','RightSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\RightSaccRVF\RightSaccRVF.mat','RightSaccRVF');


%% save updated info with additional participants: SegmAdditionalPTCP
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccLVF\LeftSaccLVF.mat','LeftSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\LeftSaccRVF\LeftSaccRVF.mat','LeftSaccRVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccLVF\RightSaccLVF.mat','RightSaccLVF');
% save('C:\Users\14169\OneDrive - University of Toronto\Eye-tracking Data\Segmentation\SegmAdditionalPTCP\RightSaccRVF\RightSaccRVF.mat','RightSaccRVF');
% 

%% In script functions
function eucDist=calc_eucDist(x1,x2,y1,y2)
eucDist = sqrt(((x1-x2).^2)+((y1-y2).^2));
end