function sc2_make_taskFile(what, varargin)
% sc2
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Makes target files (saved as structures) for 17 tasks listed below
% All the variables necessary to run the tasks are saved in these files
% For example: trial start-time, trial duration, task-name are always
% included in each target file along with any other necessary conditions
% such as task stimuli (word,picture,movie) specific to the task

% Set-Up

rand('seed') % initialise random number generator

% Set up variables
startTime_fast = [0;2;4;6;8;10;12;14;16;18;20;22;24;26;28]; % used for tasks in scanner
trialDur_fast = [1.6];

% Set-Up Directories
rootDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/sc2';
taskDir = [rootDir, '/task_files'];
fileDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/matlab/sc2/task_stimuli';

% Make task files

switch (what)
    
    case 'verbGeneration'       % STEP 3.1: User input required - see folder 'task_stimuli/verbGeneration'
        % task conditions
        taskNum = varargin{1};
        
        words = dload('verbGeneration2.txt'); % load in task stimuli (words)
        
        % consistent across all tasks
        T.startTime = startTime_fast;
        T.trialDur = repmat(trialDur_fast,15,1);
        T.taskName = repmat({'verbGeneration2'},15,1);
        T.condition = [2;2;2;2;2;2;2;2;1;1;1;1;1;1;1]; % 1-generate;2-read
        T.hand=repmat([0],15,1); % 0-no motor response
        
        % specific to the task
        % make unique target files
        count = 1;
        count2= 1;
        for ii=1:length(words.word)
            words_divided{count}{count2} = words.word{ii};
            count2 = count2+1;
            if count2>14
                count=count+1;
                count2=1;
            end
        end
        
        for i = 1:length(words_divided{taskNum}),
            words_str(i) = cellstr(words_divided{taskNum}{i});
        end
        
        % different words for each target file
        T.word = [(words_str(1:length(words_divided{taskNum})/2))';'+';(words_str((length(words_divided{taskNum})/2)+1:end))'];
        
        filename = fullfile(taskDir, sprintf('/sc2_verbGeneration_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_verbGeneration'
        sc1_make_taskFile('verbGeneration',1)
        sc1_make_taskFile('verbGeneration',2)
        sc1_make_taskFile('verbGeneration',3)
        sc1_make_taskFile('verbGeneration',4)
        sc1_make_taskFile('verbGeneration',5)
        sc1_make_taskFile('verbGeneration',6)
        sc1_make_taskFile('verbGeneration',7)
        sc1_make_taskFile('verbGeneration',8)
        sc1_make_taskFile('verbGeneration',9)
        sc1_make_taskFile('verbGeneration',10)
        sc1_make_taskFile('verbGeneration',11)
        sc1_make_taskFile('verbGeneration',12)
        sc1_make_taskFile('verbGeneration',13)
        sc1_make_taskFile('verbGeneration',14)
        sc1_make_taskFile('verbGeneration',15)
        sc1_make_taskFile('verbGeneration',16)
        sc1_make_taskFile('verbGeneration',17)
        sc1_make_taskFile('verbGeneration',18)
        sc1_make_taskFile('verbGeneration',19)
        sc1_make_taskFile('verbGeneration',20)
        sc1_make_taskFile('verbGeneration',21)
        sc1_make_taskFile('verbGeneration',22)
        
    case 'spatialNavigation'    % STEP 4.1: Any number of target files can be generated (no user input)
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all task
        T.startTime = [0];
        T.trialDur = [30];
        T.taskName = {'spatialNavigation2'};
        T.condition = [1]; % one condition
        T.hand = [0]; % 0-no motor response
        
        % specific to each task
        a = nchoosek(1:5,2);
        b = randperm(5);
        condition = {'KITCHEN','BEDROOM','FRONT-DOOR','WASHROOM','LIVING-ROOM','GARDEN','ATTIC'};
        condition = condition(b);
        condition = condition(a);
        
        % Random pairwise relationships (i.e. Kitchen-Washroom)
        for ii= randperm(length(condition)),
            if ~strcmpi(condition(ii,1), condition(ii,2))
                T.startNav = condition(ii,1);
                T.endNav = condition(ii,2);
            end
        end
        
        % Save task conditions
        filename = fullfile(taskDir, sprintf('/sc2_spatialNavigation_%d.txt', taskNum));
        dsave(filename, T); %
    case 'make_spatialNavigation'
        sc1_make_taskFile('spatialNavigation',1)
        sc1_make_taskFile('spatialNavigation',2)
        sc1_make_taskFile('spatialNavigation',3)
        sc1_make_taskFile('spatialNavigation',4)
        sc1_make_taskFile('spatialNavigation',5)
        sc1_make_taskFile('spatialNavigation',6)
        sc1_make_taskFile('spatialNavigation',7)
        sc1_make_taskFile('spatialNavigation',8)
        sc1_make_taskFile('spatialNavigation',9)
        sc1_make_taskFile('spatialNavigation',10)
        sc1_make_taskFile('spatialNavigation',11)
        sc1_make_taskFile('spatialNavigation',12)
        sc1_make_taskFile('spatialNavigation',13)
        sc1_make_taskFile('spatialNavigation',14)
        sc1_make_taskFile('spatialNavigation',15)
        sc1_make_taskFile('spatialNavigation',16)
        sc1_make_taskFile('spatialNavigation',17)
        sc1_make_taskFile('spatialNavigation',18)
        sc1_make_taskFile('spatialNavigation',19)
        sc1_make_taskFile('spatialNavigation',20)
        sc1_make_taskFile('spatialNavigation',21)
        sc1_make_taskFile('spatialNavigation',22)
        
    case 'visualSearch'         % STEP 5.1: Any number of target files can be generated (no user input)
        taskNum = varargin{1};
        
        % specific to the task
        T.letter = repmat({'L.png','T.png'}',8,1); % load stimuli (picture handles)
        T.rotateDistractor = repmat([0], 16,1); % 0 - don't rotate distractors, 1 - rotate distractors
        
        % consistent across all tasks
        target = [ones(8,1)*2;ones(8,1)];
        a=randperm(16);
        T.trialType=target(a); % 1-absent; 2-present
        T=getrow(T,a(1:15));
        T.trialDur = repmat(trialDur_fast,15,1);
        T.startTime = startTime_fast;
        T.taskName = repmat({'visualSearch2'},15,1);
        T.letter = sort(T.letter);
        if (mod(taskNum,2)==0)
            T.condition = kron([1;2;3],ones(5,1)); % easy-medium-difficult
            T.setSize = kron([4;8;12],ones(5,1)); % Set size (number of items to display in each search display).
        else
            T.condition = kron([3;2;1],ones(5,1));
            T.setSize = kron([12;8;4],ones(5,1));
        end;
        T.hand = repmat([1],15,1); % 1 - left hand
        
        % Save task conditions
        filename = fullfile(taskDir, sprintf('/sc2_visualSearch_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_visualSearch'
        sc1_make_taskFile('visualSearch',0)
        sc1_make_taskFile('visualSearch',1)
        sc1_make_taskFile('visualSearch',2)
        sc1_make_taskFile('visualSearch',3)
        sc1_make_taskFile('visualSearch',4)
        sc1_make_taskFile('visualSearch',5)
        sc1_make_taskFile('visualSearch',6)
        sc1_make_taskFile('visualSearch',7)
        sc1_make_taskFile('visualSearch',8)
        sc1_make_taskFile('visualSearch',9)
        sc1_make_taskFile('visualSearch',10)
        sc1_make_taskFile('visualSearch',11)
        sc1_make_taskFile('visualSearch',12)
        sc1_make_taskFile('visualSearch',13)
        sc1_make_taskFile('visualSearch',14)
        sc1_make_taskFile('visualSearch',15)
        sc1_make_taskFile('visualSearch',16)
        sc1_make_taskFile('visualSearch',17)
        sc1_make_taskFile('visualSearch',18)
        sc1_make_taskFile('visualSearch',19)
        sc1_make_taskFile('visualSearch',20)
        sc1_make_taskFile('visualSearch',21)
        sc1_make_taskFile('visualSearch',22)
        sc1_make_taskFile('visualSearch',23)
        sc1_make_taskFile('visualSearch',24)
        sc1_make_taskFile('visualSearch',25)
        sc1_make_taskFile('visualSearch',26)
        sc1_make_taskFile('visualSearch',27)
        sc1_make_taskFile('visualSearch',28)
        sc1_make_taskFile('visualSearch',29)
        sc1_make_taskFile('visualSearch',30)
        
    case 'nBackPic'             % STEP 7.1: User input required - see folder 'task_stimuli/nBackPic'
        % task conditions
        taskNum = varargin{1};
        
        % specific to the task
        imgFile = importdata(sprintf('nBackPic2_%d.txt',taskNum)); % load stimuli (picture handles)
        
        % consistent across all tasks
        T.startTime = startTime_fast;
        T.trialDur = repmat(trialDur_fast,15,1);
        T.hand = repmat([2],15,1); % 2 - right hand
        T.taskName = repmat({'nBackPic2'},15,1);
        
        % Determine condition (1-response;2-no response)
        for trial=1:numel(imgFile),
            file = imgFile(trial);
            if (trial == 1 || trial == 2),
                T.condition(trial,1) = 2;
            end
            if trial >= 3,
                if strcmpi(file,imgFile(trial-2)) == 1
                    T.condition(trial,1) = 1;
                end
            end
            if trial >= 3,
                if strcmpi(file,imgFile(trial-2)) == 0,
                    T.condition(trial,1) = 2;
                end
            end
        end
        T.imgFile=imgFile;
        
        filename = fullfile(taskDir, sprintf('/sc2_nBackPic_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_nBackPic'
        sc2_make_taskFile('nBackPic',0)
        sc2_make_taskFile('nBackPic',1)
        sc2_make_taskFile('nBackPic',2)
        sc2_make_taskFile('nBackPic',3)
        sc2_make_taskFile('nBackPic',4)
        sc2_make_taskFile('nBackPic',5)
        sc2_make_taskFile('nBackPic',6)
        sc2_make_taskFile('nBackPic',7)
        sc2_make_taskFile('nBackPic',8)
        sc2_make_taskFile('nBackPic',9)
        sc2_make_taskFile('nBackPic',10)
        sc2_make_taskFile('nBackPic',11)
        sc2_make_taskFile('nBackPic',12)
        sc2_make_taskFile('nBackPic',13)
        sc2_make_taskFile('nBackPic',14)
        sc2_make_taskFile('nBackPic',15)
        sc2_make_taskFile('nBackPic',16)
        sc2_make_taskFile('nBackPic',17)
        sc2_make_taskFile('nBackPic',18)
        sc2_make_taskFile('nBackPic',19)
        sc2_make_taskFile('nBackPic',20)
        sc2_make_taskFile('nBackPic',21)
        sc2_make_taskFile('nBackPic',22)
        sc2_make_taskFile('nBackPic',23)
        sc2_make_taskFile('nBackPic',24)
        sc2_make_taskFile('nBackPic',25)
        sc2_make_taskFile('nBackPic',26)
        sc2_make_taskFile('nBackPic',27)
        sc2_make_taskFile('nBackPic',28)
        sc2_make_taskFile('nBackPic',29)
        sc2_make_taskFile('nBackPic',30)
        
    case 'rest'                 % STEP 11.1: Any number of target files can be generated (no user input)
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = [0];
        T.trialDur = [30];
        T.taskName = {'rest2'};
        T.hand=[0]; % no motor response
        T.condition=[1]; %1-one condition
        
        filename = fullfile(taskDir, sprintf('/sc2_rest_%d.txt',taskNum));
        dsave(filename, T);
    case 'make_rest'
        sc2_make_taskFile('rest',1)
        sc2_make_taskFile('rest',2)
        sc2_make_taskFile('rest',3)
        sc2_make_taskFile('rest',4)
        sc2_make_taskFile('rest',5)
        sc2_make_taskFile('rest',6)
        sc2_make_taskFile('rest',7)
        sc2_make_taskFile('rest',8)
        sc2_make_taskFile('rest',9)
        sc2_make_taskFile('rest',10)
        sc2_make_taskFile('rest',11)
        sc2_make_taskFile('rest',12)
        sc2_make_taskFile('rest',13)
        sc2_make_taskFile('rest',14)
        sc2_make_taskFile('rest',15)
        sc2_make_taskFile('rest',16)
        sc2_make_taskFile('rest',17)
        sc2_make_taskFile('rest',18)
        sc2_make_taskFile('rest',19)
        sc2_make_taskFile('rest',20)
        
    case 'ToM'                  % STEP 12.1: User input required - see folder 'task_stimuli/ToM'
        % task conditions
        % condition: 1 - true; 0 - false
        taskNum = varargin{1};
        
        % specific to the task
        T = dload(sprintf('qToM2_%d.txt',taskNum)); % load stimuli (question)
        % trialType (embedded in 'T') - true-1; false-2
        T.storyDur = [9.8;9.8];
        T.delayDur = [10;10];
        T.questDur = [14.8;14.8];
        T.story    = importdata(sprintf('sToM2_%d.txt',taskNum)); % load stimuli (story)
        T.story    = strtrim(T.story);
        
        % consistent across all tasks
        T.startTime = [0;15];
        T.trialDur = [14.6;14.6];
        T.condition = [1;1]; % 1 - question, 2 - story
        T.hand = repmat([1],2,1); % 1 - left hand
        T.taskName = repmat({'ToM2'},2,1);
        
        filename = fullfile(taskDir, sprintf('/sc2_ToM_%d.txt',taskNum));
        dsave(filename, T);
    case 'make_ToM'
        sc2_make_taskFile('ToM',1)
        sc2_make_taskFile('ToM',2)
        sc2_make_taskFile('ToM',3)
        sc2_make_taskFile('ToM',4)
        sc2_make_taskFile('ToM',5)
        sc2_make_taskFile('ToM',6)
        sc2_make_taskFile('ToM',7)
        sc2_make_taskFile('ToM',8)
        sc2_make_taskFile('ToM',9)
        sc2_make_taskFile('ToM',10)
        sc2_make_taskFile('ToM',11)
        sc2_make_taskFile('ToM',12)
        sc2_make_taskFile('ToM',13)
        sc2_make_taskFile('ToM',14)
        sc2_make_taskFile('ToM',15)
        sc2_make_taskFile('ToM',16)
        sc2_make_taskFile('ToM',17)
        sc2_make_taskFile('ToM',18)
        sc2_make_taskFile('ToM',19)
        sc2_make_taskFile('ToM',20)
        sc2_make_taskFile('ToM',21)
        sc2_make_taskFile('ToM',22)
        sc2_make_taskFile('ToM',23)
        sc2_make_taskFile('ToM',24)
        sc2_make_taskFile('ToM',25)
        sc2_make_taskFile('ToM',26)
        sc2_make_taskFile('ToM',27)
        sc2_make_taskFile('ToM',28)
        sc2_make_taskFile('ToM',29)
        
    case 'actionObservation'    % STEP 14.1: User input required - see folder 'task_stimuli/actionObservation
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = ([0;15]);
        T.trialDur = repmat([14.0],2,1);
        T.taskName = repmat({'actionObservation2'},2,1);
        T.condition = [1;2]; % 1-action;2-control
        T.hand=repmat([0],2,1); % no motor response
        
        % specific to the task
        movFile = importdata(sprintf('actionObservation2_%d.txt', taskNum)); % load stimuli (fulldir to movies)
        for i = 1:length(movFile),
            mov = movFile{i};
            g = strfind(mov, 'knot');
            T.movieID(i,1) = cellstr(mov(g:end));
        end
        T.movFile = repmat({sprintf('actionObservation2_%d.txt',taskNum)},2,1);
        
        filename = fullfile(taskDir, sprintf('/sc2_actionObservation_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_actionObservation' % STEP 14.2: Target files for behavioural and scanning sessions
        sc2_make_taskFile('actionObservation',1)
        sc2_make_taskFile('actionObservation',2)
        sc2_make_taskFile('actionObservation',3)
        sc2_make_taskFile('actionObservation',4)
        sc2_make_taskFile('actionObservation',5)
        sc2_make_taskFile('actionObservation',6)
        sc2_make_taskFile('actionObservation',7)
        sc2_make_taskFile('actionObservation',8)
        sc2_make_taskFile('actionObservation',9)
        sc2_make_taskFile('actionObservation',10)
        sc2_make_taskFile('actionObservation',11)
        sc2_make_taskFile('actionObservation',12)
        sc2_make_taskFile('actionObservation',13)
        sc2_make_taskFile('actionObservation',14)
        sc2_make_taskFile('actionObservation',15)
        sc2_make_taskFile('actionObservation',16)
        sc2_make_taskFile('actionObservation',17)
        sc2_make_taskFile('actionObservation',18)
        sc2_make_taskFile('actionObservation',19)
        sc2_make_taskFile('actionObservation',20)
        sc2_make_taskFile('actionObservation',21)
    case 'make_actionObservation_test' % STEP 14.3: Target files for post-scan test
        sc2_make_taskFile('actionObservation',22)
        sc2_make_taskFile('actionObservation',23)
        
    case 'motorSequence'        % STEP 17.1: Any number of target files can be generated (no user input)
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = [0;3.75;7.5;11.25;15;18.75;22.5;26.25];
        T.trialDur = repmat([3.35],8,1);
        T.hand = repmat([3],8,1); % 3 - bimanual
        T.taskName = repmat({'motorSequence2'},8,1);
        
        % make sequences (experimental)
        SEQ{1}=[2  4  3  2  3  1;
            4  2  1  3  1  3;
            4  3  4  2  4  1;
            3  1  2  3  4  1];
        % make sequences (control)
        SEQ{2}=[1 1 1 1 1 1;
            2 2 2 2 2 2;
            3 3 3 3 3 3 ;
            4 4 4 4 4 4];
        
        % counterbalance order of experimental and control
        if (mod(taskNum,2)==0),
            T.condition=[2;2;2;2;1;1;1;1]; % 2-experimental; 1-control
            Digit = [SEQ{1}(randperm(4),:);SEQ{2}(randperm(4),:)];
        else
            T.condition=[1;1;1;1;2;2;2;2]; % 2-experimental; 1-control
            Digit = [SEQ{2}(randperm(4),:);SEQ{1}(randperm(4),:)];
        end;
        T.digit1 = Digit(:,1);
        T.digit2 = Digit(:,2);
        T.digit3 = Digit(:,3);
        T.digit4 = Digit(:,4);
        T.digit5 = Digit(:,5);
        T.digit6 = Digit(:,6);
        
        filename = fullfile(taskDir, sprintf('/sc2_motorSequence_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_motorSequence'
        sc2_make_taskFile('motorSequence',0)
        sc2_make_taskFile('motorSequence',1)
        sc2_make_taskFile('motorSequence',2)
        sc2_make_taskFile('motorSequence',3)
        sc2_make_taskFile('motorSequence',4)
        sc2_make_taskFile('motorSequence',5)
        sc2_make_taskFile('motorSequence',6)
        sc2_make_taskFile('motorSequence',7)
        sc2_make_taskFile('motorSequence',8)
        sc2_make_taskFile('motorSequence',9)
        sc2_make_taskFile('motorSequence',10)
        sc2_make_taskFile('motorSequence',11)
        sc2_make_taskFile('motorSequence',12)
        sc2_make_taskFile('motorSequence',13)
        sc2_make_taskFile('motorSequence',14)
        sc2_make_taskFile('motorSequence',15)
        sc2_make_taskFile('motorSequence',16)
        sc2_make_taskFile('motorSequence',17)
        sc2_make_taskFile('motorSequence',18)
        sc2_make_taskFile('motorSequence',19)
        sc2_make_taskFile('motorSequence',20)
        sc2_make_taskFile('motorSequence',21)
        sc2_make_taskFile('motorSequence',22)
        sc2_make_taskFile('motorSequence',23)
        sc2_make_taskFile('motorSequence',24)
        sc2_make_taskFile('motorSequence',25)
        sc2_make_taskFile('motorSequence',26)
        sc2_make_taskFile('motorSequence',27)
        sc2_make_taskFile('motorSequence',28)
        sc2_make_taskFile('motorSequence',29)
        sc2_make_taskFile('motorSequence',30)
        
    case 'prediction'
        taskNum=varargin{1};
        
        sentences=importdata(fullfile(fileDir,'prediction',sprintf('prediction%d.txt',taskNum)));
        question=importdata(fullfile(fileDir,'prediction','question.txt'));
        
        % consistent across all tasks
        T.startTime=[0;5;10;15;20;25];
        T.trialDur=[4.8;4.8;4.8;4.8;4.8;4.8]; % duration of each trial
        T.hand=repmat([1],6,1); % 1-left hand
        T.taskName=repmat({'prediction'},6,1);
        T.condition=sentences.data(:,1); % 1-predictive, 2-pred-violated, 3-scrambled
        
        % specific to task
        T.word1Dur=[.75;.75;.75;.75;.75;.75];
        T.word2Dur=[1.5;1.5;1.5;1.5;1.5;1.5];
        T.word3Dur=[2.25;2.25;2.25;2.25;2.25;2.25];
        T.word4Dur=[3;3;3;3;3;3];
        T.word5Dur=[3.75;3.75;3.75;3.75;3.75;3.75];
        T.questionDur=[4.8;4.8;4.8;4.8;4.8;4.8];
        for i=1:length(T.taskName),
            T.word1(i,1)=sentences.textdata(i,1);
            T.word2(i,1)=sentences.textdata(i,2);
            T.word3(i,1)=sentences.textdata(i,3);
            T.word4(i,1)=sentences.textdata(i,4);
            T.word5(i,1)=sentences.textdata(i,5);
        end
        T.trialType=sentences.data(:,2); % 1-meaningful 2-not meaningful
        T.question=repmat(question,6,1);
        
        filename = fullfile(taskDir, sprintf('/sc2_prediction_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_prediction'
        
    case 'mentalRotation'
        % task conditions
        taskNum = varargin{1};
        
        imgFile = importdata(fullfile(fileDir,'mentalRotation',sprintf('mentalRotation%d.txt',taskNum))); % load stimuli (picture handles)
        numCond=length(imgFile);
        
        % consistent across all tasks
        T.startTime =[0;3.33;6.66;9.99;13.32;16.65;19.98;23.31;26.694];
        T.trialDur = [3.15;3.15;3.15;3.15;3.15;3.15;3.15;3.15;3.15];
        T.hand = repmat([2],numCond,1); % 2 - right hand
        T.taskName = repmat({'mentalRotation'},numCond,1);
        for i=1:numel(imgFile),
            % determine trialType: true(1) or false(2)
            if strcmp(imgFile{i}(end-4:end-4),'R'),
                T.trialType(i,1)=2;
            else
                T.trialType(i,1)=1;
            end
            % determine condition: easy(1), medium(2), difficult(3)
            if sum(strfind(imgFile{i},'50'))~=0,
                T.condition(i,1)=2;
            elseif sum(strfind(imgFile{i},'100'))~=0,
                T.condition(i,1)=3;
            else
                T.condition(i,1)=1;
            end
        end
        
        % specific to task
        T.imgFile=imgFile;
        
        filename = fullfile(taskDir, sprintf('/sc2_mentalRotation_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_mentalRotation'
        taskNum = varargin{1};
        
        T = dload(sprintf('qToM_%d.txt', taskNum)); % load stimuli (question)
        T.story = importdata(sprintf('sToM_%d.txt', taskNum)); % load stimuli (story)
        T.startTime = [0;15];
        T.trialDur =  [];
        T.trialType = [1;2]; % 1-true; 2-false
        T.hand = repmat([1],2,1); % 1 - left hand
        T.taskName = repmat({'mentalRotation'},2,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_mentalRotation_%d.txt', taskNum));
        dsave(filename, T);
        
    case 'CPRO'
        taskNum=varargin{1};
        
        % make unique taskSets
        numTrials=4; % numTrials per task
        D=dload(fullfile(fileDir,'CPRO','CPRO_taskSets.dat'));
        taskSet=1:numTrials:length(D.Logic);
        Idx=taskSet(taskNum):taskSet(taskNum)+3;
        T=getrow(D,Idx);
        
        % consistent across all tasks
        T.startTime=[0;7.5;15;22.5];
        T.trialDur=[7.2;7.2;7.2;7.2];
        T.taskName=repmat({'CPRO'},4,1);
        T.hand=repmat([3],4,1); % 3-bimanual
        T.condition=repmat([1],4,1); % model as logic,sensory,motor instead of just one block?
        
        % specific to task
        T.instructDur=[2.5;2.5;2.5;2.5];
        T.delay1Dur=[3.5;3.5;3.5;3.5];
        T.trial1Dur=[4.5;4.5;4.5;4.5];
        T.delay2Dur=[5.5;5.5;5.5;5.5];
        T.trial2Dur=[7.2;7.2;7.2;7.2];
        
        % figure out motor instructions
        motorNames={'LeftMiddle','LeftIndex','RightIndex','RightMiddle'};
        motorNum={'1','2','3','4'};
        motorName={'One','Two','Three','Four'};
        for n=1:4,
            for m=1:numel(motorNames),
                if strcmp(T.Motor(n),motorNames{m}),
                    motorMap(n,1)=str2double(motorNum{m});
                    T.motorMap{n,1}=motorName{m};
                end
            end
        end
        
        % figure out motor mapping
        r=[2;1;4;3];
        for m=1:4,
            if T.trialType(m)==1,
                T.motorResp(m,1)=motorMap(m,1);
            else
                T.motorResp(m,1)=r(motorMap(m));
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc2_CPRO_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_CPRO'
        
    case 'natureMovie'
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = [0];
        T.trialDur = [29.9];
        T.taskName = {'natureMovie'};
        T.condition=[1]; % 1-one condition
        T.hand=[0]; % 0-no motor response
        
        % specific to task
        T.movFile = {sprintf('nature%d.txt',taskNum)};
        movFile = importdata(sprintf('nature%d.txt', taskNum)); % load stimuli (fulldir to movies)
        g = strfind(movFile{1}, '/');
        T.movieID(1,1) = cellstr(movFile{1}(g(end)+1:end));
        
        filename = fullfile(taskDir, sprintf('/sc2_natureMovie_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_natureMovie'
        
    case 'landscapeMovie'
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = [0];
        T.trialDur = [29.9];
        T.taskName = {'landscapeMovie'};
        T.condition=[1]; % 1-one condition
        T.hand=[0]; %0-no motor response
        
        % specific to task
        T.movFile = {sprintf('landscape%d.txt',taskNum)};
        movFile = importdata(sprintf('landscape%d.txt', taskNum)); % load stimuli (fulldir to movies)
        g = strfind(movFile{1}, '/');
        T.movieID(1,1) = cellstr(movFile{1}(g(end)+1:end));
        
        filename = fullfile(taskDir, sprintf('/sc2_landscapeMovie_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_landscapeMovie'
        
    case 'romanceMovie'
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = [0];
        T.trialDur = [29.9];
        T.taskName = {'romanceMovie'};
        T.condition=[1]; % 1-one condition
        T.hand=[0]; %0-no motor response
        
        % specific to task
        T.movFile = {sprintf('romance%d.txt',taskNum)};
        movFile = importdata(sprintf('romance%d.txt', taskNum)); % load stimuli (fulldir to movies)
        g = strfind(movFile{1}, '/');
        T.movieID(1,1) = cellstr(movFile{1}(g(end)+1:end));
        
        filename = fullfile(taskDir, sprintf('/sc2_romanceMovie_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_romanceMovie'
        
    case 'emotionProcess'
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = ([0;3;6;9;12;15;18;21;24;27]);
        T.trialDur = repmat([2.8],10,1);
        T.taskName = repmat({'emotionProcess'},10,1);
        T.hand     = repmat([2],10,1); % 2 - right hand
        movFile = importdata(fullfile(fileDir,'emotionProcess', sprintf('emotionProcess%d.txt', taskNum))); % load stimuli (fulldir to movies)
        idx=[2:11];
        movFile=strtrim(movFile);
        for i = 1:length(idx),
            mov = movFile{idx(i)};
            g = strfind(mov, '/');
            T.fileName(i,1) = cellstr(mov(g(end)+1:end));
            if ~isempty(strfind(mov,'H'))==1,
                T.trialType(i,1)=[1]; % 1-happy or 1-fast
            else
                T.trialType(i,1)=[2]; % 2-sad or 2-slow
            end
            if isempty(strfind(mov,'Scram')),
                T.condition(i,1)=1; % 1-Intact
            else
                T.condition(i,1)=2; % 2-Scram
            end
        end
        
        % specific to task
        T.movFile  = repmat({sprintf('emotionProcess%d.txt',taskNum)},10,1);
        
        filename = fullfile(taskDir, sprintf('/sc2_emotionProcess_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_emotionProcess'
        
    case 'spatialMap'
        taskNum=varargin{1};
        
        % consistent across all tasks
        T.startTime = [0;5;10;15;20;25];
        T.hand = repmat([3],6,1); % 2 - bimanual
        T.taskName = repmat({'spatialMap'},6,1);
        T.trialDur = repmat([4.8],6,1);
        % assign number of response alternatives per trial
        if (mod(taskNum,2)==0)
            T.condition = kron([1;2;3],ones(2,1));
            T.setSize = kron([1;4;7],ones(2,1)); % 1-4-7
        else
            T.condition= kron([3;2;1],ones(2,1)); % easy-medium-difficult
            T.setSize = kron([7;4;1],ones(2,1));
        end;
        
        % specific to task
        T.trial1Dur=[2;2;2;2;2;2];
        T.delayDur=[3.5;3.5;3.5;3.5;3.5;3.5];
        T.trial2Dur=[4.8;4.8;4.8;4.8;4.8;4.8];
        T.sizeDisplay=repmat([8],6,1); % 8 squares
        
        % assign motor responses (to 8 squares)
        n=repmat([1:4],6,2); % 1-4 (number of poss motor responses)
        for m=1:size(n,1),
            a=randperm(size(n,2));
            motorResp(m,:)=n(m,a);
        end
        
        % assign spatial positions to all respAlt
        T.respPos=zeros(6,8);
        T.respPos(T.respPos==0)=nan;
        for r=1:size(n,1)
            b=randperm(size(n,2));
            T.respPos(r,1:T.setSize(r,1))=randsample(b,T.setSize(r,1));
        end
        
        T.targNum=zeros(6,1);
        % ensure 1:4 are motor responses
        while sum(ismember(unique(T.targNum),[1:4]))<4,
            % assign target response pos & number (from respAlts)
            for t=1:size(n,1),
                T.targPos(t,1)=randsample(T.respPos(t,:),1);
                % keep randomly sampling until you don't get a nan value
                while isnan(T.targPos(t,1)),
                    T.targPos(t,1)=randsample(T.respPos(t,:),1);
                end
                T.targNum(t,1)=motorResp(t,T.targPos(t,1));
            end
        end
        
        % make motorResp digestible for dsave struct..
        for mr=1:6,
            T.motorResp1(mr,1)=motorResp(mr,1);
            T.motorResp2(mr,1)=motorResp(mr,2);
            T.motorResp3(mr,1)=motorResp(mr,3);
            T.motorResp4(mr,1)=motorResp(mr,4);
            T.motorResp5(mr,1)=motorResp(mr,5);
            T.motorResp6(mr,1)=motorResp(mr,6);
            T.motorResp7(mr,1)=motorResp(mr,7);
            T.motorResp8(mr,1)=motorResp(mr,8);
        end
        
        % make respPos digestible for dsave struct..
        for rp=1:6,
            T.respPos1(rp,1)=T.respPos(rp,1);
            T.respPos2(rp,1)=T.respPos(rp,2);
            T.respPos3(rp,1)=T.respPos(rp,3);
            T.respPos4(rp,1)=T.respPos(rp,4);
            T.respPos5(rp,1)=T.respPos(rp,5);
            T.respPos6(rp,1)=T.respPos(rp,6);
            T.respPos7(rp,1)=T.respPos(rp,7);
        end
        T=rmfield(T,'respPos');
        
        filename = fullfile(taskDir, sprintf('/sc2_spatialMap_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_spatialMap'
        
    case 'respAlt'
        taskNum=varargin{1};
        
        % consistent across all tasks
        T.startTime = [0;5;10;15;20;25];
        T.hand = repmat([3],6,1); % 2 - bimanual
        T.taskName = repmat({'respAlt'},6,1);
        T.trialDur = repmat([4.8],6,1);
        
        % assign spatial positions to all respAlt
        m=[1;2;3;4];
        l=[1;2;1;2;1;2];
        
        % assign conditions + setSize
        if (mod(taskNum,2)==0)
            T.condition = kron([1;2;3],ones(2,1));
            T.setSize = kron([1;2;4],ones(2,1)); % 1-2-4
        else
            T.condition= kron([3;2;1],ones(2,1)); % easy-medium-difficult
            T.setSize = kron([4;2;1],ones(2,1));
        end;
        
        s={[1,2],[3,4]}; % spatial positions
        T.respPos=zeros(6,6);
        for i=1:length(T.setSize),
            if T.setSize(i)==4,
                T.respPos(i,:)=[1,2,3,4,0,0];
            else
                idx=i;
                for ii=1:T.setSize(i),
                    T.respPos(i,ii)=randsample(s{l(idx)},1);
                    idx=idx+1;
                end
            end
        end
        
        % specific to task
        T.trial1Dur=Shuffle([1.31:.31:2.9])';
        T.imperSigDur=T.trial1Dur+.1';
        T.trial2Dur=[4.8;4.8;4.8;4.8;4.8;4.8];
        T.sizeDisplay=repmat([4],6,1); % 4 squares
        
        % assign target response pos & number (from respAlts)
        % & make sure each we have each motor resp
        T.targPos=zeros(6,1);
        while sum(ismember(unique(T.targPos),[1:4]))<4,
            for ii=1:6,
                T.targPos(ii,1)=randsample(T.respPos(ii,:),1);
                % keep randomly sampling until you don't get a nan value
                while (T.targPos(ii,1))==0,
                    T.targPos(ii,1)=randsample(T.respPos(ii,:),1);
                end
            end
        end
        
        % Determine rt feedback
        T.rtFeedback=[.3;.3;.3;.3;.3;.3];
        
        % make respPos digestible for dsave struct..
        for r=1:6,
            for c=1:4,
                T.respPos1(r,1)=T.respPos(r,1);
                T.respPos2(r,1)=T.respPos(r,2);
                T.respPos3(r,1)=T.respPos(r,3);
                T.respPos4(r,1)=T.respPos(r,4);
                T.respPos5(r,1)=T.respPos(r,5);
                T.respPos6(r,1)=T.respPos(r,6);
            end
        end
        T=rmfield(T,'respPos');
        
        filename = fullfile(taskDir, sprintf('/sc2_respAlt_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_respAlt'
        
    case 'restingState'
        % task conditions
        taskNum = varargin{1};
        
        % consistent across all tasks
        T.startTime = [0];
        T.trialDur = [595];
        T.taskName = {'restingState'};
        T.hand=[0]; % no motor response
        T.condition=[1]; %1-one condition
        
        filename = fullfile(taskDir, sprintf('/sc2_restingState_%d.txt',taskNum));
        dsave(filename, T);
    case 'make_all_files'
        sc2_make_taskFile('make_stroop')
        sc2_make_taskFile('make_verbGeneration')
        sc2_make_taskFile('make_spatialNavigation')
        sc2_make_taskFile('make_visualSearch')
        sc2_make_taskFile('make_emotionGoNoGo')
        sc2_make_taskFile('make_nBackPic')
        sc2_make_taskFile('make_checkerBoard')
        sc2_make_taskFile('make_affective')
        sc2_make_taskFile('make_emotional')
        sc2_make_taskFile('make_rest')
        sc2_make_taskFile('make_ToM')
        sc2_make_taskFile('make_arithmetic')
        sc2_make_taskFile('make_actionObservation')
        sc2_make_taskFile('make_motorImagery')
        sc2_make_taskFile('make_intervalTiming')
        sc2_make_taskFile('make_motorSequence')
        
    otherwise
        disp('there is no such case.')
        
end

% Local functions
    function dircheck(dir)
        if ~exist(dir,'dir');
            warning('%s doesn''t exist. Creating one now. You''re welcome! \n',dir);
            mkdir(dir);
        end
    end
end
