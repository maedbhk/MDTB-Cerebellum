function sc2_runExperiment(subjName,runFile,feedback,timing,eyeTracking,runNum)
global TRreal timeOfTR;
%% super_cerebellum project - study 2

% Maedbh King (2017)

% Main experimental script

% Change directories in 'Set-Up' section.

% open sc2_psychtoolbox_config and choose whether to run script in
% behavioural (0) or scanner (1) mode

% Input variables
% example command: sc2_runExperiment('test','sc2_run1.txt',0,0,0,1)
% subjName    = 'test'; any format can be adopted
% runFile     = 'sc2_run1.txt'; This (example) file provides all of the information
%               needed to execute one run. Refer to the excel spreadsheet 'task design' to find all options for 'runFile'
% feedback    = 0; % options: 1 - feedback scores are presented after each block; or 0 - end of run
% timing      = 0; % options: 1 - paced; or 0 - manual (keypress is required to
%               advance past the instructions)
% eyeTracking = 0; % options: 1 - eyeTracking; 0 - no eyeTracking
% runNum      = 1; 

%% Set-Up

rootDir= '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition';
cd(rootDir)
resDir = [rootDir, '/data/sc2/behavioural', sprintf('/%s', subjName)]; dircheck(resDir);
eyeTrackDir = [rootDir, '/data/sc2/eyeTracking',sprintf('/%s',subjName)]; dircheck(eyeTrackDir);
runDir=[rootDir, '/data/sc2/run_files']; dircheck(runDir);
taskDir=[rootDir, '/data/sc2/task_files']; dircheck(taskDir);

% load run file
D=dload(fullfile(runDir,runFile)); 

% number of tasks in each run
numTasks=length(D.taskName); 

% load target files
for b = 1:numTasks,
    T{D.taskNum(b)} = [];
    T{D.taskNum(b)} =dload(fullfile(taskDir,D.taskFile{b})); % load individual task files
end

% check for existing results for the run file
runFileName = fullfile(resDir,sprintf('sc2_%s.dat',subjName));
Dres        = dload(runFileName);

% configure eyetracker
if eyeTracking==1,
    [el]=sc2_config_eyeTracking;
end

% define global variables (TR counter)
TRreal = 0;
timeOfTR = GetSecs;

% open screen
[screen,keyNames] = sc2_psychtoolbox_config; % set-up psychtoolbox parameters (screen,keyboard etc)

% present fixation cross
DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
Screen('Flip', screen.window);

% if scanning, wait for the first TR when starting
if (screen.isScan)
    while (TRreal<=0)
        checkTR(screen);
    end;
end;

% start timer
t0 = GetSecs;

% define variables
taskName = {};

%% Begin Experimental Loop

index = 1;
% execute tasks
for b=1:numTasks,
    
    % check result file for this task
    taskFileName = fullfile(resDir,sprintf('sc2_%s_%s.dat',subjName,D.taskName{b}));
    Tres = dload(taskFileName);
    
    % fixation cross (stays on screen for dummy scans)
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    % wait for start time (if paced)
    if timing==1,
        while GetSecs-t0 <= D.startTime(b)
            checkTR(screen);
        end;
    end
    
    % record start of task instructions
    D.TRreal(b,1) = TRreal; % TR counter
    D.timeOfTR(b,1) = timeOfTR-t0; % This is the time when the last TR has occurred
    
    % collect start time for each task
    D.realStartTime(b,1) = (GetSecs-t0)';
    
    % amend instructions (if manual)
    if (timing==0),
        keyNames{5} = 'Press the spacebar to continue';
        P{2} = 'Press the spacebar to continue';
    else
        keyNames{5} ={};
        P{2} = {};
    end
    
    % start eyetracking
    if eyeTracking==1,
        if  strcmp(T{b}.taskName(1),'respAlt') || strcmp(T{b}.taskName(1),'spatialNavigation2'),
            TN = T{b}.taskName{1}(end-1:end); 
        else
            TN = T{b}.taskName{1}(1:2);
        end
        edfFile = [subjName(2:3),sprintf('%2.2d%2.2d',runNum,b),TN,'.edf']; %(1-8 characters in length) format is <subjName-runNum-blockNum-taskName>
        [edfFile] = sc2_start_eyeTracking(screen,el,edfFile,T{b});
    end
    
    % display instructions
    if strfind(D.taskName{b},'spatialNavigation2')==1, % Special case - spatial navigation
        P{1} = T{b};
        feval(D.taskFunction{b},screen,P)
    else
        feval(D.taskFunction{b},screen,keyNames)
    end
    
    % wait for keypress (if manual)
    if ~timing,
        KbPressWait(screen.keyBoard); % Key press required
        WaitSecs(1.0)
    elseif (timing==1), % if paced
        while GetSecs-t0 <= D.startTime(b)+D.instructTime % Timed presentation
            checkTR(screen);
        end;
    end
    
    % run task and collect results
    if strfind(D.taskName{b},'spatialNavigation2')==1, % Special case - spatial navigation
        [tresults,tscore] = feval(D.taskFunction{b},screen,P,T{b});
    else
        [tresults,tscore] = feval(D.taskFunction{b},screen,keyNames,T{b});
    end
    
    % store scores for end-of-run feedback
    if isnumeric(tscore),
        scores(index,1) = tscore;
        taskName{index,1} = D.taskName{b};
        index = index+1;
    end
    
    % present feedback (if end-of-block option is specified)
    if  (feedback==1),
        if isnumeric(tscore),
            DrawFormattedText(screen.window, sprintf('You got a score of %d%%',tscore),'center', 'center',screen.black);
            Screen('Flip', screen.window);
        else
            DrawFormattedText(screen.window, sprintf('%s',tscore),'center', 'center',screen.black);
            Screen('Flip', screen.window);
        end
        WaitSecs(2.0)
    end
    
    % wait for end-of-task (if paced)
    if (timing==1),
        scoreTime = D.endTime(b);
        while GetSecs-t0 <= scoreTime
            checkTR(screen);
        end
    end
    
    % present fixation cross (if paced)
    if (timing==1),
        DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
        Screen('Flip', screen.window);
    end
    
    % add the task specific results
    sizeResults = size(tresults.numTrial,1);
    tresults.blockNum = ones(sizeResults,1)*b;
    tresults.runNum = ones(sizeResults,1)*runNum;
    Tres = addstruct(Tres,tresults);
    dsave(taskFileName, Tres);
    
    % save eyetracking
    if eyeTracking==1,
        cd(fullfile(eyeTrackDir));
        sc2_save_eyeTracking(edfFile);
    end
end

%% End experiment

% end eyetracking
if eyeTracking==1,
    Eyelink('shutdown');
end

% add the run file to allRun
D.runNum = ones(size(D.taskNum,1),1)*runNum;
Dres = addstruct(Dres,D);
dsave(runFileName,Dres);

% end run
charYpos = [0 50 100 150 200 250 0 50 100 150 200 250];
charXpos = [-100 -100 -100 -100 -100 250 250 250 250 250 250];

% present feedback on screen (if end of run option is specified)
if (feedback==0) && exist('scores','var'),
    for ii = 1:length(scores),
        DrawFormattedText(screen.window, sprintf('%s:%d%%',char(taskName{ii}),scores(ii)), screen.xCenter-charXpos(ii), screen.yCenter-charYpos(ii), screen.black);
        DrawFormattedText(screen.window, 'Experimenter: Press the spacebar to exit', screen.xCenter-400, screen.yCenter+200, screen.black)
    end
    Screen('Flip', screen.window);
    KbPressWait(screen.keyBoard)
    feval('sc2_endExperiment', screen) % End experiment after last trial
else
    % End experiment (no feedback is presented on screen)
    DrawFormattedText(screen.window, 'Experimenter: Press the spacebar to exit', 'center','center', screen.black)
    Screen('Flip', screen.window);
    KbPressWait(screen.keyBoard)
    feval('sc2_endExperiment', screen); % End experiment after last trial
end

% release keys
ListenChar(); 

% Local functions
    function dircheck(dir)
        if ~exist(dir,'dir');
            warning('%s doesn''t exist. Creating one now. You''re welcome! \n',dir);
            mkdir(dir);
        end
    end
end