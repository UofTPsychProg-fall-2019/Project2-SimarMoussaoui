# Project2-SimarMoussaoui

First, I created 2 matlab (AddSaccDir.m and MassAddSaccade.m) scripts to add the variables I needed for my analysis (that is, variables that tell me if the saccade is vertical or horizontal, up or down, left or right).

Now that I have my variables, I have two scripts that find my unsystematic errors per condition for horizontal (SegmentConditionsHoriSacc.m ) and vertical (SegmentConditionsVertSacc.m) saccades. The results are saved and then copied into an excel file (3WayRMANOVA - 35PTCP.xlsx).

I then segmented my data (SegmentForProcrustesUp.m, SegmentForProcrustesDown.m, SegmentForProcrustesLeft.m, and SegmentForProcrustesRight.m) for inputting it into my procrustes script (procrustesLVFandRVF), and saved the output to my excel file (3WayRMANOVA - 35PTCP.xlsx). 

I then conducted a PCA (principal component analysis) on SPSS and sorted my data using my script weightedFactor.m and AdjWeightedFactor.m (the first one applying the weights extracted from PCA of original filtered data, and the second applying weights of rectified data). Two aforementioned scripts allowed for the creation of factor scores from the components extracted from the PCA, so that I can run  new analyses (ANOVAs) on the factor scores. 

Please see the presentation I have attached for all the results compiled together. I am still interpreting the results! :) 
