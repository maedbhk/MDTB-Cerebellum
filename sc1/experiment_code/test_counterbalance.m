function [out] =  test_counterbalance(firstRun,lastRun)

allTasks = []; 
for ii = firstRun:lastRun,
    D = dload(sprintf('sc2_run%d.txt',ii));
    D.runNum = ones(length(D.taskNum),1)*ii;
    allTasks = addstruct(allTasks,D);
end

% Look at N-1 effects
T=allTasks;
[~,~,T.task]=unique(T.taskName);
T.lastTask=[0;T.task(1:end-1)];
T.lastTask(T.taskNum==1)=0;
[f,~,~] = pivottable(T.task,T.lastTask,T.task,'length','subset',T.runNum);

out = any(f(:)>2); 

disp(f)

varargout={T};
