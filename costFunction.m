function [ rawCost, cost, constrains ] = costFunction( testProblem, x )

[testRawCost, testCost, testConstrains] = testProblem.func(x);

rawCost = testRawCost;
cost = testCost;
constrains = testConstrains;

end

