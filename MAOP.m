function MAOP(testName)
global rho mop weightStatus U Cluster;

switch testName
    case 'MAOP1'
        load MAOP1.mat;
        mop = MAOP1(mop, rho);
    case 'MAOP2'
        load MAOP2.mat;
        mop = MAOP2(mop, rho);
    case 'MAOP3'
        load MAOP3.mat;
        mop = MAOP3(mop, rho);
    case 'MAOP4'
        load MAOP4.mat;
        mop = MAOP4(mop, rho);
    case 'MAOP5'
        load MAOP5.mat;
        mop = MAOP5(mop, rho);
    case 'MAOP6'
        load MAOP6.mat;
        mop = MAOP6(mop, rho);
    case 'MAOP7'
        load MAOP7.mat;
        mop = MAOP7(mop, rho);
    case 'MAOP8'
        load MAOP8.mat;
        mop = MAOP8(mop, rho);
    case 'MAOP9'
        load MAOP9.mat;
        mop = MAOP9(mop, rho);
    case 'MAOP10'
        load MAOP10.mat;
        mop = MAOP10(mop, rho);
    otherwise
        error('Undefined test problem name');
end

%% MAOP1 Problem
    function p = MAOP1(p, rho)
        p.name='MAOP1';
        p.odim = 5;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP2 Problem
    function p = MAOP2(p, rho)
        p.name='MAOP2';
        p.odim = 5;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    tmp3= sum (f' .* U(3, :));
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP3 Problem
    function p = MAOP3(p, rho)
        p.name='MAOP3';
        p.odim = 10;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
            testRawCost = f;
            
            % Extra Operation
            if strcmp(weightStatus, 'Initialize')
                testCost = testRawCost;
            else
                tmp1 = sum (f' .* U(1, :));
                tmp2 = sum (f' .* U(2, :));
                f(1) = tmp1;
                f(2) = tmp2;
                if Cluster ==3
                    tmp3 = sum (f' .* U(3, :));
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end


%% MAOP4 Problem
    function p = MAOP4(p, rho)
        p.name='MAOP4';
        p.odim = 10;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP5 Problem
    function p = MAOP5(p, rho)
        p.name='MAOP5';
        p.odim = 10;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP6 Problem
    function p = MAOP6(p, rho)
        p.name='MAOP6';
        p.odim = 10;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP7 Problem
    function p = MAOP7(p, rho)
        p.name='MAOP7';
        p.odim = 15;
        p.pdim  =5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP8 Problem
    function p = MAOP8(p, rho)
        p.name='MAOP8';
        p.odim = 15;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP9 Problem
    function p = MAOP9(p, rho)
        p.name='MAOP9';
        p.odim = 15;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

%% MAOP10 Problem
    function p = MAOP10(p, rho)
        p.name='MAOP10';
        p.odim = 15;
        p.pdim  = 5;
        p.varMin            = -2;
        p.varMax           = 2;
        p.func               =@evaluate;
        function [testRawCost, testCost, testConstrains]= evaluate(x)
            testConstrains = zeros(p.odim - 1);
            xm = x';
            f  = mymaop(xm,rho);
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
                    f(3) = tmp3;
                    testCost = (f(1:3));
                else
                    testCost = (f(1:2));
                end
            end
        end
    end

end

