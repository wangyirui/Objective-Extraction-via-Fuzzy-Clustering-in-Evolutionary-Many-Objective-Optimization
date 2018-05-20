function testProblem( testName, problemDim, objectiveDim)

global mop;
mop = struct('name',[],'objectiveDim',[],'problemDim',[],'varMin',[],'varMax',[],'func',[]);

switch testName
    case {'DTLZ1','DTLZ2','DTLZ3','DTLZ4','DTLZ5','DTLZ6','DTLZ7'}
        DTLZ(testName,problemDim,objectiveDim);
        
    case {'MF1', 'MF2'}
        MF(testName,problemDim,objectiveDim);
        
    case {'MAOP1', 'MAOP2', 'MAOP3', 'MAOP4', 'MAOP5', 'MAOP6', 'MAOP7', ...
            'MAOP8', 'MAOP9', 'MAOP10'}
        MAOP(testName);
        
    otherwise
        error('Undefined test problem name');
end

end
