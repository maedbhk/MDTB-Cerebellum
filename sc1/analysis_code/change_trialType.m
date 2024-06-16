function change_trialType(what,varargin)

% Set-Up

taskDir= '/Users/mking/Documents/Cerebellum_Cognition/data/results/data/s05';

switch what
    
    case 'GoNoGo'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_GoNoGo.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_GoNoGo.dat', sn));
        dsave(filename,D);
    case 'affective'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_affective.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_affective.dat', sn));
        dsave(filename,D);
    case 'emotional'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_emotional.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_emotional.dat', sn));
        dsave(filename,D);
    case 'stroop'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_stroop.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_stroop.dat', sn));
        dsave(filename,D);
    case 'visualSearch'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_visualSearch.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_visualSearch.dat', sn));
        dsave(filename,D);
    case 'ToM'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_ToM.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_ToM.dat', sn));
        dsave(filename,D);
    case 'arithmetic'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_arithmetic.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_arithmetic.dat', sn));
        dsave(filename,D);
    case 'intervalTiming'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_intervalTiming.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_intervalTiming.dat', sn));
        dsave(filename,D);
    case 'motorSequence'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_motorSequence.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_motorSequence.dat', sn));
        dsave(filename,D);
    case 'actionObservation'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_actionObservation.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_actionObservation.dat', sn));
        dsave(filename,D);
    case 'checkerBoard'
        sn=varargin{1};
        
        D = dload(sprintf('sc1_s0%d_checkerBoard.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_checkerBoard.dat', sn));
        dsave(filename,D);
    case 'verbGeneration'
        sn=varargin{1};
        D = dload(sprintf('sc1_s0%d_verbGeneration.dat',sn));
        
        for ii =1:length(D.startTime),
            if D.trialType(ii)==0,
                D.trialType(ii)=1;
            elseif D.trialType(ii)==1,
                D.trialType(ii)=2;
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_s0%d_verbGeneration.dat', sn));
        dsave(filename,D);
end