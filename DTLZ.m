function DTLZ(testName, problemDim, objectiveDim)

global I mop weightStatus U U_old Cluster;

switch testName
    case 'DTLZ2'
        mop = DTLZ2(mop,problemDim,objectiveDim);
    case 'DTLZ5'
        mop = DTLZ5(mop,problemDim,objectiveDim);
    otherwise
        error('Undefined test problem name');
end

%% DTLZ2 Problem
    function p = DTLZ2(p, problemDim, objectiveDim)
        p.name='DTLZ2';
        p.odim = objectiveDim;
        p.pdim  = problemDim;
        p.varMin            = 0;
        p.varMax           = 1;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            k = problemDim-objectiveDim+1;
            f = zeros(objectiveDim,1);
            testConstrains = zeros(objectiveDim - 1);
            xm = x(objectiveDim : problemDim);
            g = sum((xm - 0.5).^2);
            f(1) = (1 + g) .* prod(cos(pi / 2 * x(1 : objectiveDim-1)));
            for i = 2 : objectiveDim - 1
                f(i) = (1 + g) .* prod(cos(pi / 2 * x(1 : objectiveDim - i))) ...
                    .* sin(pi / 2 * x(objectiveDim - i +1));
            end
            f(objectiveDim) = (1 + g) .* sin(pi / 2 * x(1));
            testRawCost = f;
            
            % Extra Operation
            if strcmp(weightStatus, 'Initialize')
                testCost = testRawCost;
            else
                tmp1 = sum (f' .* U(1, :));
                tmp2 = sum (f' .* U(2, :));
                f(1) = tmp1;
                f(2) = tmp2;
                if Cluster == 3
                    tmp3 = sum (f' .* U(3, :));
                    f(3)=tmp3;
                    testCost=f(1:3);
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% DTLZ5 Problem
    function p = DTLZ5(p, problemDim, objectiveDim)
        p.name='DTLZ5';
        p.odim = objectiveDim;
        p.pdim = problemDim;
        p.varMin = 0;
        p.varMax = 1;
        p.func=@evaluate;
        function [testRawCost, testCost, testConstrains] = evaluate(x)
%             I = 2;
            k = problemDim - objectiveDim + 1;
            f = zeros(objectiveDim, 1);
            testConstrains = zeros(objectiveDim - 1);
            xm = x(objectiveDim : problemDim);
            g = sum((xm - 0.5) .^ 2);
            theta(1 : I - 1) = (pi / 2.0) * x(1 : I - 1);
            theta(I  : objectiveDim-1) = pi / (4.0 * (1+ g) )  * (1 + 2 * g .* x(I : objectiveDim - 1));
            for i = 1 : objectiveDim
                if i == 1
                    f(i) = prod(cos(theta(1 : objectiveDim - 1)));
                    f(i) = (1 + g) * f(i);
                elseif i == objectiveDim
                    f(i) = (1 + g) * sin(theta(1));
                elseif i ~= objectiveDim && i ~= 1
                    f(i) = (1 + g)  * prod( cos (theta(1 : objectiveDim - i) ) ) ...
                        * sin(theta(objectiveDim - i + 1));
                end
%                 if i ~= objectiveDim
%                     testConstrains(i) =   ( (1 + g) * sin(theta(1)) )^2 ...
%                         + 2^(objectiveDim - i) * ( f(i) )^2 - 1;
%                     if testConstrains(i) >= 0
%                         testConstrains(i) = 0;
%                     end
%                 end
            end
            testRawCost = f;
            
            %% Extra Operation
            if strcmp(weightStatus, 'Initialize')
                testCost = testRawCost;
            else
                tmp1 = sum (f' .* U(1, :));
                tmp2 = sum (f' .* U(2, :));
                f(1) = tmp1;
                f(2) = tmp2;
                if Cluster > 2
                    for i1 = 3 : Cluster
                        f(i1)=sum (f' .* U(i1, :));
                    end
                    testCost=f(1:Cluster);
                else
                    testCost=f(1:2);
                end
            end
        end
    end

end

