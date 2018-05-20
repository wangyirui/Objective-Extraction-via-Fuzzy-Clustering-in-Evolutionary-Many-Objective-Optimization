function PlotCosts(pop)

global Cluster plotGroup plotDim plotType;

Cost=[pop.Cost];
RawCost = [pop.RawCost];
nPlot = size(plotGroup, 1);
for i1 = 1 : size(pop);
    Pos(:, i1) = (pop(i1).Position)';
end

if Cluster == 2
    figure(1);
    subplot(1,nPlot + 1,1)
    plot(Cost(1, :), Cost(2, :),'r*','MarkerSize',8);
    xlabel('Weighted Objective 1');
    ylabel('Weighted Objective 2');
    title('Non-dominated Solutions (F_{1})');
    grid on;
    if plotDim == 2
        for i = 1 : nPlot
            subplot(1,nPlot + 1, i + 1)
            if plotType == 'f'
                plot(RawCost(plotGroup(i,1), :), RawCost(plotGroup(i,2), :),'r*','MarkerSize',8);
                xlabel([num2str(plotGroup(i,1)) '^{th} Objective']);
                ylabel([num2str(plotGroup(i,2)) '^{th} Objective']);
                title('Non-dominated Solutions (F_{1})');
            elseif plotType == 'x'
                plot(Pos(1, :), Pos(2, :),'r*','MarkerSize',8);
                axis([-1 1 -1 1]); 
                xlabel('x1');
                ylabel('x2');
                title('x1-x2 Distribution');
            end
            grid on;
        end
    elseif plotDim == 3
        for i = 1 : nPlot
            subplot(1,nPlot + 1, i + 1)
            plot3(RawCost(plotGroup(i,1), :), RawCost(plotGroup(i,2), :),RawCost(plotGroup(i,3), :),'r*','MarkerSize',8);
            xlabel([num2str(plotGroup(i,1)) '^{th} Objective']);
            ylabel([num2str(plotGroup(i,2)) '^{th} Objective']);
            zlabel([num2str(plotGroup(i,3)) '^{th} Objective']);
            title('Non-dominated Solutions (F_{1})');
            grid on;
        end
    end
    
elseif Cluster > 2
    figure(1);
    subplot(1,nPlot + 1, 1);
    plot3(Cost(1,:),Cost(2,:),Cost(3,:),'r*','MarkerSize',8);
    axis([0 1.2 0 1.2 0 1.2]);
    xlabel('Weighted 1^{st} Objective');
    ylabel('Weighted 2^{nd} Objective');
    zlabel('Weighted 2^{nd} Objective');
    title('Non-dominated Solutions (F_{1})');
    grid on;
    if plotDim == 2
        for i = 1 : nPlot
            subplot(1,nPlot + 1, i + 1)
            if plotType == 'f'
                plot(RawCost(plotGroup(i,1), :), RawCost(plotGroup(i,2), :),'r*','MarkerSize',8);
                xlabel([num2str(plotGroup(i,1)) '^{th} Objective']);
                ylabel([num2str(plotGroup(i,2)) '^{th} Objective']);
                title('Non-dominated Solutions (F_{1})');
            elseif plotType == 'x'
                plot(Pos(1, :), Pos(2, :),'r*','MarkerSize',8);
                axis([-1 1 -1 1]); 
                xlabel('x1');
                ylabel('x2');
                title('x1-x2 Distribution');
            end
            grid on;
        end
    elseif plotDim == 3
        for i = 1 : nPlot
            subplot(1,nPlot + 1, i + 1)
            plot3(RawCost(plotGroup(i,1), :), RawCost(plotGroup(i,2), :),RawCost(plotGroup(i,3), :),'r*','MarkerSize',8);
            xlabel([num2str(plotGroup(i,1)) '^{th} Objective']);
            ylabel([num2str(plotGroup(i,2)) '^{th} Objective']);
            zlabel([num2str(plotGroup(i,3)) '^{th} Objective']);
            title('Non-dominated Solutions (F_{1})');
            grid on;
        end
    end
end

end