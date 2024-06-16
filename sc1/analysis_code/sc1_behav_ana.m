function sc1_behav_ana(what,varargin)
% Behavioural Analysis
% Plot lineplots for each task

% Set up Directories
baseDir = sprintf('/Users/mking/Documents/Cerebellum_Cognition/data/results'); dircheck(baseDir);
behavDir=[baseDir '/data']; dircheck(behavDir);

subjName = {'s01','s02','s03','s04'}; 

taskNames = {'GoNoGo','ToM','actionObservation','affective','arithmetic',...
    'checkerBoard','emotional','intervalTiming','motorImagery','motorSequence',...
    'nBack', 'nBackPic','spatialNavigation','stroop', 'verbGeneration',...
    'visualSearch','rest'};

funcRunNum = [51,66]; 

%% Make plots

switch (what)
    
    case 'stroop'
        sn=varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_stroop.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='all subjects';
        end

        figure(s)
        subplot(2,1,1)
        lineplot([A.runNum], A.rt, 'split',A.congruency,'leg',{'congruent','incongruent'},'subset',A.respMade==1);
        xlabel('Run')
        ylabel('rt')
        title(main)
        
        subplot(2,1,2)
        lineplot([A.runNum], A.numCorr, 'split',A.congruency,'leg',{'congruent','incongruent'},'subset', A.respMade==1);
        xlabel('Run')
        ylabel('Percent correct') 
        title(main)
 
    case 'nBack'
        sn=varargin{1}; 
        avg= varargin{2};
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_nBack.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end
        
        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('rt')  
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('Percent Correct')
        title(main)
        
    case 'visualSearch'
        sn=varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_visualSearch.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='all subjects';
        end

        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt, 'split', A.targetPresent,'leg', {'absent','present'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('rt')
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr, 'split', A.targetPresent,'leg', {'absent','present'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('Percent Correct') 
        title(main)
        
    case 'GoNoGo'
        sn=varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_GoNoGo.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end

        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'negative','positive'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('rt') 
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'negative','positive'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('Percent Correct') 
        title(main)
        
    case 'nBackPic'
        sn=varargin{1};
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_nBackPic.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end
        
        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);
        xlabel('Run')
        ylabel('rt')
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr, 'split', A.possCorr,'leg', {'No Match','Match'}, 'subset',A.respMade==1);
        xlabel('Run')
        ylabel('Percent Correct')
        title(main)
        
    case 'affective'
        sn = varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_affective.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end

        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'unpleasant','pleasant'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('rt')   
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'unpleasant','pleasant'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('Percent Correct')  
        title(main)
        
    case 'emotional'
        sn = varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_emotional.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end

        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt, 'split', A.trialType,'leg', {'sad','happy'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('rt') 
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr, 'split', A.trialType,'leg', {'sad','happy'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('Percent Correct')  
        title(main)
        
    case 'ToM'
        sn = varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_ToM.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end

        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt,'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('rt') 
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr,'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('Percent Correct')  
        title(main)
        
    case 'arithmetic'
        sn = varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_arithmetic.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end

        figure(s)
        subplot(2,1,1)
        lineplot(A.runNum, A.rt, 'split', A.condition,'leg', {'control','equations'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('rt')  
        title(main)
        
        subplot(2,1,2)
        lineplot(A.runNum, A.numCorr, 'split', A.condition,'leg', {'control','equations'}, 'subset',A.respMade==1);    
        xlabel('Run')
        ylabel('Percent Correct')  
        title(main)
        
    case 'intervalTiming'
        sn = varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_intervalTiming.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end

        figure(s)
        subplot(2,1,1); 
        lineplot(A.runNum,A.rt,'split',A.timing,'leg', {'long', 'short'},'subset',A.respMade==1); 
        xlabel('Run'); 
        ylabel('rt'); 
        title(main);
        
        subplot(2,1,2); 
        lineplot(A.runNum,A.numCorr,'split',A.timing,'leg',{'long','short'},'subset',A.respMade==1);  
        xlabel('Run')
        ylabel('Percent Correct')
        title(main);
        
    case 'motorSequence'
        sn = varargin{1}; 
        avg=varargin{2}; % calculate average across subjs?
        
        A=[];
        for s=sn,
            
            D = dload(fullfile(behavDir,subjName{s},sprintf('sc1_%s_motorSequence.dat',subjName{s})));
            A = addstruct(A,D);
            A = getrow(A,A.runNum>=funcRunNum(1) & A.runNum<=funcRunNum(2));   
        end
        
        if avg==0,
            main=subjName{s};
        else
            main='averaged across subjects';
        end

        figure(s)  
        subplot(2,1,1); 
        lineplot(A.runNum,A.rt,'split',A.trialType,'leg',{'sequence','control'}); 
        xlabel('Run'); 
        ylabel('rt');
        title(main)
        
        subplot(2,1,2); 
        lineplot(A.runNum,A.numCorr,'split', A.trialType,'leg', {'sequence','control'});  
        xlabel('Run')
        ylabel('Percent Correct')
        title(main)

    case 'task_pivotTable'
        nRuns = varargin{1};
        allTasks = [];
        
        for ii = 1:nRuns,
            D = dload(sprintf('sc1_run%d.txt',ii));
            D.runNum = ones(length(D.taskNum),1)*ii; 
            allTasks = addstruct(allTasks,D);
        end
        
        run = kron([1:nRuns]',ones(17,1)); 

        [f,r,c] = pivottable(allTasks.taskName,run,allTasks.taskNum,'(x)'); 
         pivottable(allTasks.taskName,[],allTasks.taskNum,'mean'); % get the mean position across runs
        
         % Look at N-1 effects 
         T=allTasks; 
         [~,~,T.task]=unique(T.taskName); 
          T.lastTask=[0;T.task(1:end-1)]; 
          T.lastTask(T.taskNum==1)=0; 
         pivottable(T.task,T.lastTask,T.task,'length','subset',T.r<9); 
       
       % Loop through runs 9-16
       pivottable(T.task,T.lastTask,T.task,'length','subset',T.r>9); 
        
    case 'count_TR'
        sn = varargin{1}; 
        
        D = dload(sprintf('sc1_s%d.dat',sn));
         
%         figure(1) 
%         subplot(2,1,1)
%         lineplot([D.runNum(D.taskNum==17 & D.runNum>=27)],D.TRreal(D.taskNum==17 & D.runNum>=27))
%         xlabel('r')
%         ylabel('TR count')
%         
%         subplot(2,1,2)
%         lineplot([D.runNum(D.taskNum==17 & D.runNum>=27)],D.timeOfTR(D.taskNum==17 & D.runNum>=27))
%         xlabel('r')
%         ylabel('time of TR')
        
        D.diffTR=[diff(D.TRreal);0]; 
        D.diffTR(D.taskNum==17)=nan;
        D.diffTime = [diff(D.timeOfTR);0]; 
        D.diffTime(D.taskNum==17)=nan;
        
    case 'relabel_rs_overall'
        % relabel run numbers for s0
        sn = varargin{1};
        
        D = dload(sprintf('sc1_s%d.dat',sn));

        newRun = 51:58;
        tmp = 203:17:339;
        
        count = 1;
        count2 = 187;
        for ii = 1:length(D.runNum)
            if D.runNum(ii)>26 && D.runNum(ii)<59,
                D.runNum(count2) = newRun(count);
                count2 = count2+1;
                if  count2>tmp(count),
                    count = count+1;
                end
            end
        end
        
    case 'relabel_rs_tasks'
        % relabel task rs for s0
        sn = varargin{1};
        taskName = varargin{2};
        
        D = dload(sprintf('sc1_s%d_%s.dat',sn,taskName));
        
        for ii = 1:length(D.runNum)
            
            if D.runNum(ii)==27,
                D.runNum(ii) = 51;
            elseif D.runNum(ii)==28,
                D.runNum(ii) = 52;
            elseif D.runNum(ii)==29,
                D.runNum(ii) = 53;
            elseif D.runNum(ii)==30,
                D.runNum(ii) = 54;
            elseif D.runNum(ii)==31,
                D.runNum(ii) = 55;
            elseif D.runNum(ii)==32,
                D.runNum(ii) = 56;
            elseif D.runNum(ii)==33,
                D.runNum(ii) = 57;
            elseif D.runNum(ii)==34,
                D.runNum(ii) = 58;
            end
        end

        filename = sprintf('sc1_s%d_%s.dat',sn,taskName); 
        dsave(D,filename)
end
       