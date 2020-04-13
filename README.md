# Project2-SimarMoussaoui

All in all, I want to look at the systematic and unsystematic errors for the participants. That is, I will need to compute standard deviations per condition (per click cluster) and compare the average x and y standard deviation across my 8 conditions. That will give me the unsystematic errors. I will then conduct a Procrustes analysis to fit the participants responses into the actual location of the stimuli, to look at systematic errors.

The first thing I want to do is code the vertical and horizontal coordinates from the dataset to explicitly tell me if the individual made a horizontal or vertical saccade. If the saccade is made vertically, the value is 0 when we subtract the x coordinate of FP1 and FP2. If it is horizontally, you will get a positive or negative value. Speicifically, if it a negative number, it will be a rightward eye movement, and if a positive number it will be a leftward eye movement. From my TSI.mat file (which contains the data about the saccade, jitter, block type…), I will look at theData.FPx – theData.FPx2 (fixation point 1 and 2). If the result is less than one or greater than one, that would indicate a horizontal saccade. I will then add the created variables indicating saccade direction to theData.set, to further segment my data according to condition.

The next step is to find the average standard deviation for each of the 8 possible clusters (where the stimuli could come up) separately for each participant. These standard deviations will then be inputted into SPSS to conduct a 3-way repeated measures ANOVA, the three factors being: Saccade plane (Horizontal or Vertical), Saccade Direction (L/U, R/D) and Visual field (Left or Right VF).

For my Procrustes analysis, I want to separate out average response coordinates (x,y) and target location coordinates (x,y) for each cluster associated with each condition per participant (as outlined in pseudocode). This will help me use the Procrustes() function and get my systematic errors parameters.

___________________________________________________________________________________________________________________

For starters: Everything (data organization and analysis) was completed in either MATLAB or SPSS

First, I created 2 matlab (AddSaccDir.m and MassAddSaccade.m) scripts to add the variables I needed for my analysis (that is, variables that tell me if the saccade is vertical or horizontal, up or down, left or right).

Now that I have my variables, I have two scripts that find my unsystematic errors per condition for horizontal (SegmentConditionsHoriSacc.m ) and vertical (SegmentConditionsVertSacc.m) saccades. The results are saved and then copied into an excel file (3WayRMANOVA - 35PTCP.xlsx).

I then segmented my data (SegmentForProcrustesUp.m, SegmentForProcrustesDown.m, SegmentForProcrustesLeft.m, and SegmentForProcrustesRight.m) for inputting it into my procrustes script (procrustesLVFandRVF), and saved the output to my excel file (3WayRMANOVA - 35PTCP.xlsx). 

I then conducted a PCA (principal component analysis) on SPSS and sorted my data using my script weightedFactor.m and AdjWeightedFactor.m (the first one applying the weights extracted from PCA of original filtered data, and the second applying weights of rectified data). Two aforementioned scripts allowed for the creation of factor scores from the components extracted from the PCA, so that I can run  new analyses (ANOVAs) on the factor scores. 

Please see the presentation (pdf file) I have attached for all the results compiled together. I am still interpreting the results! :) 

____________________________________________________________________________________________________________________

If you want to try out my scripts, I have uploaded one example data set. All you need to do is change the participant path from all the participant numbers to '2'. I have uploaded data for participant 2 only.
