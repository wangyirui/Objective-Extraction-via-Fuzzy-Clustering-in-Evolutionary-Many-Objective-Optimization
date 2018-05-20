function MF(testName,problemDim,objectiveDim)

global mop weightStatus U Cluster;

switch testName
    case 'MF1'
        mop = MF1(mop,problemDim,objectiveDim);
    case 'MF2'
        mop = MF2(mop,problemDim,objectiveDim);
    otherwise
        error('Undefined test problem name');
end

%% MF1 Problem
    function p = MF1(p, ~, ~)
        p.name               = 'MF1';
        p.odim               = 3;
        p.pdim               = 5;
        p.varMin            = 0;
        p.varMax           = 1;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1,1);
            a = x(1) * x(2);
            b = (1 - x(2)) * x(1);
            c = 1- x(1);
            if a == max(a, max(b,c))
                tmp = a;
            else
                tmp = 0.5 * (a + min(b, c));
            end
            f(1) = tmp + sum( (x(3:p.pdim) - 0.5) .^2 );
            a = x(1) * (1 - x(2));
            b = 1 - x(1);
            c = x(1) * x(2);
            if a == max(a, max(b,c))
                tmp = a;
            else
                tmp = 0.5 * (a + min(b, c));
            end
            f(2) = tmp + sum( (x(3:p.pdim) - 0.5) .^2 );
            a = 1 - x(1);
            b = x(1) * x(2);
            c = x(1) * (1 - x(2));
            if a == max(a, max(b,c))
                tmp = a;
            else
                tmp = 0.5 * (a + min(b, c));
            end
            f(3) = tmp + sum( (x(3:p.pdim) - 0.5) .^2 );
            testRawCost = f';
            
            % Extra Operation
            if strcmp(weightStatus, 'Initialize')
                testCost = testRawCost;
            else
                tmp1 = sum (f .* U(1, :));
                tmp2 = sum (f .* U(2, :));
                f(1) = tmp1;
                f(2) = tmp2;
                if Cluster == 3
                    tmp3 = sum (f .* U(3, :));
                    f(3) = tmp3;
                    testCost = (f(1:3))';
                else
                    testCost = (f(1:2))';
                end
            end
        end
    end

%% MF2 Problem
    function p = MF2(p, ~, ~)
        p.name               = 'MF2';
        p.odim               = 3;
        p.pdim               = 5;
        p.varMin            = 0;
        p.varMax           = 1;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1,1);
            a = x(1) * x(2);
            b = (1 - x(2)) * x(1);
            c = 1- x(1);
            if a == min(a, min(b,c))
                tmp = 0;
            else
                tmp = ( a * (a + b + c) ) / ( a + max(b,c));
            end
            f(1) = tmp + sum( (x(3:p.pdim) - 0.5) .^2 );
            a = x(1) * (1 - x(2));
            b = 1 - x(1);
            c = x(1) * x(2);
            if a == min(a, min(b,c))
                tmp = 0;
            else
                tmp = ( a * (a + b + c) ) / ( a + max(b,c));
            end
            f(2) = tmp + sum( (x(3:p.pdim) - 0.5) .^2 );
            a = 1 - x(1);
            b = x(1) * x(2);
            c = x(1) * (1 - x(2));
            if a == min(a, min(b,c))
                tmp = 0;
            else
                tmp = ( a * (a + b + c) ) / ( a + max(b,c));
            end
            f(3) = tmp + sum( (x(3:p.pdim) - 0.5) .^2 );
            testRawCost = f';
            
            % Extra Operation
            if strcmp(weightStatus, 'Initialize')
                testCost = testRawCost;
            else
                tmp1 = sum (f .* U(1, :));
                tmp2 = sum (f .* U(2, :));
                f(1) = tmp1;
                f(2) = tmp2;
                if Cluster == 3
                    tmp3 = sum (f .* U(3, :));
                    f(3) = tmp3;
                    testCost = (f(1:3))';
                else
                    testCost = (f(1:2))';
                end
            end
        end
    end

end

