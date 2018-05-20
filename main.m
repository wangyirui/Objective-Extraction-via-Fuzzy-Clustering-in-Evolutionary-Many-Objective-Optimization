clear all;
close all;
clc;

    global I plotGroup plotDim plotType Cluster fuzzyExpo;
    probList = {'DTLZ5_5_2', 'DTLZ5_5_3', 'DTLZ5_10_5', 'DTLZ5_10_7'...
        , 'DTLZ5_20_2', 'DTLZ5_20_3', 'DTLZ5_20_5', 'DTLZ5_20_7', 'DTLZ5_50_2'};
    objList = [5,5,10,10,20,20,20,20,50];
    iList = [2,3,5,7,2,3,5,7,2];

    % Select the test problems in probList 
    for pCnt =1:9
        % The number of run times
        for loopCnt = 1 : 20
            %% Main program
            %    The parameter odim indicates the number of objective functions
            %    The parameter pdim indicates the number of variables
            %    The function PlotList
            testName='DTLZ5';
            objectiveDim = objList(pCnt);
            problemDim = objectiveDim + 9;
            I = iList(pCnt);
            % The number of Fuzzy C-Means cluster
            if I== 7
                Cluster = I;
            else
                Cluster =I;
            end
            % Objective Functions drawn in the plot
            plotGroup = [objectiveDim - 2 objectiveDim - 1 objectiveDim];                       
            plotDim = 3;
            % f- function, x- x1,x2
            plotType = 'f';  
            % Exponent for U
            fuzzyExpo =1.5;                             
            testProblem( testName, problemDim,objectiveDim);
            nsga2();
            problems = char(probList(pCnt));
            sname = sprintf('./data/%s_%d.mat', char(problems), loopCnt);
            save(sname, 'df');
            disp(['Finish ' num2str(loopCnt)]);
            
        end
    end  