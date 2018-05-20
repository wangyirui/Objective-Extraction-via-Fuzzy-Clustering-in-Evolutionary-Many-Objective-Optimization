function [child1, child2] = Crossover(parent1, parent2)
global mop pCrossover Eta_c  ;
child1 = [ ];
child2 = [ ];
r1 = rand;
if r1 <= pCrossover
    for i=1:mop.pdim
        r2 = rand;
        if r2 <= 0.5
            if abs(parent1(i)- parent2(i)) > 10^(-14)
                y1 = min(parent1(i), parent2(i));
                y2 = max(parent1(i), parent2(i));
                beta = 1 + 2 * (min((y1 - mop.varMin), (mop.varMax - y2)))/(y2 - y1);
                exp = Eta_c + 1;
                beta=1/beta;
                alpha = 2.0 - beta^(exp);
                u = rand;
                if u <= 1 / alpha
                    alpha = alpha * u;
                    exp = 1/(Eta_c + 1.0);
                    betaq = alpha^(exp);
                else
                    alpha=1/(2.0 - alpha * u);
                    exp = 1/(Eta_c + 1.0);
                    betaq = alpha^(exp);
                end
                c1 = 0.5*((y1 + y2) - betaq*(y2 - y1));
                c2 = 0.5*((y1 + y2) + betaq*(y2 - y1));
                
                if c1 > mop.varMax
                    c1 = mop.varMax;
                elseif c1 < mop.varMin
                    c1 = mop.varMin;
                end
                if c2 > mop.varMax
                    c2 = mop.varMax;
                elseif c2 < mop.varMin
                    c2 = mop.varMin;
                end
                r3 = rand;
                if r3 <= 0.5
                    child1(i) = c2;
                    child2(i) = c1;
                else
                    child1(i) = c1;
                    child2(i) = c2;
                end
            else
                child1(i) = parent1(i);
                child2(i) = parent2(i);
            end
        else
            child1(i) = parent1(i);
            child2(i) = parent2(i);
        end
    end
else
    child1 = parent1;
    child2 = parent2;
end

end
