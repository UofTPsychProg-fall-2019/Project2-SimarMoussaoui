function MassAddSaccade()

ptcpList = [2]
% ptcpList = [52,53,54,57,58,59,60,65,68,71];
% ptcpList = [2,4,5,7,8,9,11,14,15,23,26,30,32,34,35,36,37,38,39,41,42,43,44,48,50,52,53,54,57,58,59,60,65,68,71];
blockList = [1, 2, 3];

% This function will allow me to add the vertical, horizontal, and directions of saccades for each block for every participant
% in one go.
for iptcp = 1:length(ptcpList)
    subNum = ptcpList(iptcp);

    for iItem = 1:length(blockList)
        blockNum = blockList(iItem);
        AddSaccDir(subNum,blockNum)
    end

end

end
