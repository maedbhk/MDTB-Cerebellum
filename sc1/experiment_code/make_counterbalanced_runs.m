function make_counterbalanced_runs(firstRun,lastRun)

while test_counterbalance(firstRun,lastRun)==1,
    
    for ii = firstRun:lastRun,
        sc2_make_runFile(sprintf('run%d',ii))
    end
end

fprintf('these runs are perfect \n')
