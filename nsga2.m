global MaxIt nPop pCrossover Eta_c pMutation Eta_m popc popm;
global Cluster mop pop U  U_old  VarSize F1 weightStatus;

%% NSGA-II Parameters
MaxIt =300;                                      % Maximum Number of Iterations
nPop = 300;                                      % Population Size
pCrossover=0.9;                                  % Crossover Percentage
Eta_c = 5.0;                                     % Crossover Index
pMutation =1.0 / mop.pdim;                       % Mutation Percentage
Eta_m = 50.0;                                    % Mutation Index
VarSize = [1 mop.pdim];                          % Size of Decision Variables Matrix(Columns)

%% Initialization Part I: Create structure and pop

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.RawCost=[];
empty_individual.Rank=[];
empty_individual.Constrains=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];

pop=repmat(empty_individual,nPop,1);
weightStatus = 'Initialize';

%% Initialization Part II: Prepare to Compute Membership Matrix
for LoopCnt=1:nPop
    pop(LoopCnt).Position=unifrnd(mop.varMin, mop.varMax, VarSize);
    [pop(LoopCnt).RawCost, pop(LoopCnt).Cost, pop(LoopCnt).Constrains] ...
        = costFunction(mop, pop(LoopCnt).Position);
end

% Non-Dominated Sorting
[pop, F]=NonDominatedSorting(pop);

% Calculate Crowding Distance
pop=CrowdingDistance(pop,F);

% Sort Population
[pop, F]=SortPopulation(pop);

% Deploy Fuzzy C-Means to obtain U
U = Weight(pop)
U_old = zeros(size(U,1), size(U, 2));
weightStatus = 'Ready';
U1=U;
%% Initialization Part III: Run NSGA-II again to update pop.Cost

for LoopCnt=1:nPop
    pop(LoopCnt).Position=unifrnd(mop.varMin, mop.varMax, VarSize);
    [pop(LoopCnt).RawCost, pop(LoopCnt).Cost, pop(LoopCnt).Constrains] ...
        = costFunction(mop, pop(LoopCnt).Position);
end

% Non-Dominated Sorting
[pop, F]=NonDominatedSorting(pop);

% Calculate Crowding Distance
pop=CrowdingDistance(pop,F);

% Sort Population
[pop, F]=SortPopulation(pop);

%% NSGA-II Main Loop

updateIt = 1;
finishWeightMatrix = 1;

for it=1:MaxIt
    % Tournament and Crossover
    popc=repmat(empty_individual,  (size(pop, 1) - mod(size(pop,1), 4)) / 2, 1);
    Mating();
    
    % Mutation
    popm=repmat(empty_individual,  size(popc, 1), 1);
    Mutate();
    
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);
    
    % Calculate Crowding Distance
    pop=CrowdingDistance(pop,F);
    
    % Sort Population
    pop=SortPopulation(pop);
    
    % Truncate
    pop=pop(1:nPop);
    
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);
    
    % Calculate Crowding Distance
    pop=CrowdingDistance(pop,F);
    
    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Store F1
    F1=pop(F{1});
    
    global df;
    df = zeros(mop.odim, size(F1, 1));
    for i1 = 1 : size(F1, 1)
        df(:, i1) = F1(i1).RawCost;
    end
    
    % Plot F1 Costs
    figure(1);
    PlotCosts(F1);
    pause(0.01);
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);
    
    if (sum(sum(abs(U - U_old))))  / (size(U,1) *  size(U, 2)) > (2.0e-4 * Cluster)
        updateIt = updateIt + 1;
        U_old = U;
        U = Weight(pop)
        disp(['Weight Update: '  num2str(updateIt)]);
        disp(['Agverage Fluctuation: ' num2str((sum(sum(abs(U - U_old))))  / (size(U,1) *  size(U, 2)))]);

        for LoopCnt=1:nPop
            %             pop(LoopCnt).Position=unifrnd(mop.varMin, mop.varMax, VarSize);
            [pop(LoopCnt).RawCost, pop(LoopCnt).Cost, pop(LoopCnt).Constrains] ...
                = costFunction(mop, pop(LoopCnt).Position);
        end
        
        % Non-Dominated Sorting
        [pop, F]=NonDominatedSorting(pop);
        
        % Calculate Crowding Distance
        pop=CrowdingDistance(pop,F);
        
        % Sort Population
        [pop, F]=SortPopulation(pop);

        F1=pop(F{1});
        
    end
  
end
