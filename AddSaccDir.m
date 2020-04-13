function AddSaccDir(subNum,blockNum)
% subNum = 7;
% blockNum = 1;
% ptcpList = {2;4;5;7;8;9;11;14;15;18;23;26;30;32;34;35;36;37;38;39;41;42;43};
%This code will add three variables: HorV (horizontal or vertical), LorR
%(left or right), and UorD (up or down).

path ='C:/Users/14169/OneDrive - University of Toronto/Eye-tracking Data/SMptcp';
cding = '/Users/14169/OneDrive - University of Toronto/Eye-tracking Data/SMptcp';
blockFolder = '/block';
TSI = '/TSI.mat';

cdpath = [cding, num2str(subNum), blockFolder, num2str(blockNum)];
datapath = [path, num2str(subNum), blockFolder, num2str(blockNum), TSI];
load(datapath);

%subjectID = 'SMptcp' + num2str(subNum);

% FPx, FPy, FPx2, FPy2

% Making the HorV variable, where -1 = Horizontal and 1 = Vertical
% Making the LorR variable, where 1 is left and -1 is right
% Making the UorD variable, where -1 is down and 1 is up

% If the saccade is made vertically, the value is 0 when we subtract the x
% coordinate of FP1 and FP2. If it is horizontally, you will get a positive
% or negative value. Speicifically, if it a negative number, it will be a
% rightward eye movement, and if a positive number it will be a leftward 
% eye movement.
HorV = theData.FPx - theData.FPx2;
HorV(HorV<0) = -1;
HorV(HorV>0) = -1;
HorV(HorV==0) = 1;

LorR = theData.FPx - theData.FPx2;
LorR(LorR>0) = 1; %left
LorR(LorR<0) = -1; %right
% If the value is 0, that means it was a vertical saccade

UorD = theData.FPy - theData.FPy2;
UorD(UorD>0) = 1; % up
UorD(UorD<0) = -1; % down
% If the value is 0, that means it was a horizontal saccade


theData.HorV = HorV;
theData.LorR = LorR;
theData.UorD = UorD;

cd(cdpath)

save('TSWM.mat', 'theData')

end