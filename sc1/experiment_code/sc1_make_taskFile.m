function sc1_make_taskFile(what, varargin)
% super_cerebellum project
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Makes target files (saved as structures) for 17 tasks listed below
% All the variables necessary to run the tasks are saved in these files
% For example: trial start-time, trial duration, task-name are always
% included in each target file along with any other necessary conditions
% such as task stimuli (word,picture,movie) specific to the task

% Set-Up

rand('seed') % initialise random number generator

% Set up variables
startTime_slow = [0;3;6;9;12;15;18;21;24;27;30;33;36;39;42]; % used for behavioural practice only
startTime_fast = [0;2;4;6;8;10;12;14;16;18;20;22;24;26;28]; % used for tasks in scanner
trialDur_slow = [2.6];
trialDur_fast = [1.6];

% Set-Up Directories
rootDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/sc1';
taskDir = [rootDir, '/task_files'];
fileDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/matlab/sc1/task_stimuli';

% Make task files

switch (what)
    
    case 'stroop'               % STEP 1.1: Any number of target files can be generated (no user input)
        % task conditions
        taskNum = varargin{1};
        
        words = {'red','green','blue','yellow'};
        RGB = [255 0 0; 0 255 0; 0 0 255; 255 255 0]; % colour of words presented on screen
        T.colour     = kron([1:4]',ones(4,1));
        T.trialType = kron(ones(8,1),[1:2]'); % 2 - congruent; 1 - incongruent
        for i=1:16
            if (T.congruency(i)==2)
                T.wordnum(i,1) = T.colour(i); % congruent
            else
                x=[1:4];
                x(T.colour(i))=[];
                T.wordnum(i,1)=x(unidrnd(3)); % incongruent
            end;
        end;
        T.word = {words{T.wordnum}}';
        T.R = RGB(T.colour,1);
        T.G = RGB(T.colour,2);
        T.B = RGB(T.colour,3);
        T.hand = repmat([0],16,1); % 0 - bimanual
        a=randperm(16);
        T=getrow(T,a(1:15));
        T.taskName = repmat({'stroop'},15,1);
        
        if (taskNum==0), % slow condition
            T.startTime = startTime_slow;
            T.trialDur = repmat(trialDur_slow,15,1);
            
        else
            % fast condition
            T.startTime = startTime_fast;
            T.trialDur = repmat(trialDur_fast,15,1);
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_stroop_%d.txt', taskNum));
        dsave(filename, T); %
    case 'make_stroop'
        sc1_make_taskFile('stroop',0)
        sc1_make_taskFile('stroop',1)
        sc1_make_taskFile('stroop',2)
        sc1_make_taskFile('stroop',3)
        sc1_make_taskFile('stroop',4)
        sc1_make_taskFile('stroop',5)
        sc1_make_taskFile('stroop',6)
        sc1_make_taskFile('stroop',7)
        sc1_make_taskFile('stroop',8)
        sc1_make_taskFile('stroop',9)
        sc1_make_taskFile('stroop',10)
        sc1_make_taskFile('stroop',11)
        sc1_make_taskFile('stroop',12)
        sc1_make_taskFile('stroop',13)
        sc1_make_taskFile('stroop',14)
        sc1_make_taskFile('stroop',15)
        sc1_make_taskFile('stroop',16)
        sc1_make_taskFile('stroop',17)
        sc1_make_taskFile('stroop',18)
        sc1_make_taskFile('stroop',19)
        sc1_make_taskFile('stroop',20)
        sc1_make_taskFile('stroop',21)
        sc1_make_taskFile('stroop',22)
        sc1_make_taskFile('stroop',23)
        sc1_make_taskFile('stroop',24)
        sc1_make_taskFile('stroop',25)
        sc1_make_taskFile('stroop',26)
        sc1_make_taskFile('stroop',27)
        sc1_make_taskFile('stroop',28)
        sc1_make_taskFile('stroop',29)
        sc1_make_taskFile('stroop',30)
        sc1_make_taskFile('stroop',31)
        sc1_make_taskFile('stroop',32)
        sc1_make_taskFile('stroop',33)
        
    case 'nBack'                % STEP 2.1: User input required - see folder 'task_stimuli/nBack'
        % task conditions
        taskNum = varargin{1};
        
        % does task stimuli subfolder exist?
        dircheck(fullfile(fileDir, 'nBack'));
        
        T.letter = importdata(sprintf('nBack%d.txt',taskNum)); % load in task stimuli (words)
        if (taskNum==0), % slow condition
            T.startTime = startTime_slow;
            T.trialDur = repmat(trialDur_slow,15,1);
        else
            % fast condition
            T.startTime = startTime_fast;
            T.trialDur = repmat(trialDur_fast,15,1);
        end
        T.hand = repmat([1],15,1); % 1 - left hand
        T.taskName = repmat({'nBack'},15,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_nBack_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_nBack'
        sc1_make_taskFile('nBack',0)
        sc1_make_taskFile('nBack',1)
        sc1_make_taskFile('nBack',2)
        sc1_make_taskFile('nBack',3)
        sc1_make_taskFile('nBack',4)
        sc1_make_taskFile('nBack',5)
        sc1_make_taskFile('nBack',6)
        sc1_make_taskFile('nBack',7)
        sc1_make_taskFile('nBack',8)
        sc1_make_taskFile('nBack',9)
        sc1_make_taskFile('nBack',10)
        sc1_make_taskFile('nBack',11)
        sc1_make_taskFile('nBack',12)
        sc1_make_taskFile('nBack',13)
        sc1_make_taskFile('nBack',14)
        sc1_make_taskFile('nBack',15)
        sc1_make_taskFile('nBack',16)
        sc1_make_taskFile('nBack',17)
        sc1_make_taskFile('nBack',18)
        sc1_make_taskFile('nBack',19)
        sc1_make_taskFile('nBack',20)
        sc1_make_taskFile('nBack',21)
        sc1_make_taskFile('nBack',22)
        sc1_make_taskFile('nBack',23)
        sc1_make_taskFile('nBack',24)
        sc1_make_taskFile('nBack',25)
        sc1_make_taskFile('nBack',26)
        sc1_make_taskFile('nBack',27)
        sc1_make_taskFile('nBack',28)
        sc1_make_taskFile('nBack',29)
        sc1_make_taskFile('nBack',30)
        
    case 'verbGeneration'       % STEP 3.1: User input required - see folder 'task_stimuli/verbGeneration'
        % task conditions
        taskNum = varargin{1};
        
        % does task stimuli subfolder exist?
        dircheck(fullfile(fileDir, 'verbGeneration'));
        
        words = dload('verbGeneration.txt'); % load in task stimuli (words)
        
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
        
        if (taskNum==0), % slow condition
            T.startTime = startTime_slow;
            T.trialDur = repmat(trialDur_slow,8,1);
        else
            % fast condition
            T.startTime = startTime_fast;
            T.trialDur = repmat(trialDur_fast,15,1);
        end
        
        T.taskName = repmat({'verbGeneration'},15,1);
        T.trialType = [2;2;2;2;2;2;2;2;1;1;1;1;1;1;1]; % 1-generate;2-read
        
        filename = fullfile(taskDir, sprintf('/sc1_verbGeneration_%d.txt', taskNum));
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
        
        a = nchoosek(1:5,2);
        b = randperm(5);
        condition = {'KITCHEN','BEDROOM','FRONT-DOOR','WASHROOM','LIVING-ROOM'};
        condition = condition(b);
        condition = condition(a);
        
        % Random pairwise relationships (i.e. Kitchen-Washroom)
        for ii= randperm(length(condition)),
            if ~strcmpi(condition(ii,1), condition(ii,2))
                T.startNav = condition(ii,1);
                T.endNav = condition(ii,2);
            end
        end
        T.startTime = [0];
        T.trialDur = [29.6];
        T.taskName = {'spatialNavigation'};
        
        % Save task conditions
        filename = fullfile(taskDir, sprintf('/sc1_spatialNavigation_%d.txt', taskNum));
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
        
        % does task stimuli subfolder exist?
        dircheck(fullfile(fileDir, 'visualSearch'));
        
        T.letter = repmat({'L.png','T.png'}',8,1); % load stimuli (picture handles)
        
        %several different set sizes in the same experiment (i.e. 4,8,12)
        target = [ones(8,1)*2;ones(8,1)]; % 2 - present; 1 - absent
        a=randperm(16);
        T.trialType=target(a);
        T.rotateDistractor = repmat([0], 16,1); % 0 - don't rotate distractors, 1 - rotate distractors
        T.hand = repmat([1],16,1); % 1 - left hand
        T=getrow(T,a(1:15));
        T.letter = sort(T.letter);
        T.taskName = repmat({'visualSearch'},15,1);
        
        % task conditions
        if (taskNum==0), % slow condition
            T.startTime = startTime_slow;
            T.trialDur = repmat(trialDur_slow,15,1);
        else
            % fast condition
            T.startTime = startTime_fast;
            T.trialDur = repmat(trialDur_fast,15,1);
        end;
        if (mod(taskNum,2)==0)
            T.setSize = kron([4;8;12],ones(5,1)); % Set size (number of items to display in each search display).
        else
            T.setSize = kron([12;8;4],ones(5,1));
        end;
        
        % Save task conditions
        filename = fullfile(taskDir, sprintf('/sc1_visualSearch_%d.txt', taskNum));
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
        
    case 'GoNoGo'               % STEP 6.1: User input required - see folder 'task_stimuli/GoNoGo'
        % task conditions
        taskNum = varargin{1};
        
        if (taskNum==0),
            % slow condition
            T.startTime = [0;3;6;9;12;15;18;21;24;27;30;33;36;39;42;45;48;51;54;57;60;63;66;69;71;74;77;80;83;86]; % different start time because there is one trial per second
            T.trialDur = repmat(trialDur_slow,30,1);
            T.trialType = [2;2;1;1;2;1;1;2;1;2;1;2;1;2;1;1;2;1;1;1;2;2;1;1;2;2;1;1;2;2]; % 1 - positive; 0 - negative
        else
            % fast condition
            T.startTime = [0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29];
            T.trialDur = repmat([0.8],30,1);
        end
        
        % does task stimuli subfolder exist?
        dircheck(fullfile(fileDir, 'GoNoGo'));
        
        pos = dload('GoNoGoPos.txt'); % load 'positive' words
        neg = dload('GoNoGoNeg.txt'); % load 'negative' words
        a = randperm(length(pos.word),15);
        word = [pos.word(a);neg.word(a)]; % randomly choose 15 of each
        trialType = [pos.trial(a);neg.trial(a)]; % determine feedback
        b = randperm(length(word));
        
        T.word = word(b);
        T.trialType = trialType(b);
        
        T.hand = repmat([1],30,1); % 1 - left hand
        T.taskName = repmat({'GoNoGo'},30,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_GoNoGo_%d.txt',taskNum));
        dsave(filename, T);
    case 'make_GoNoGo'
        sc1_make_taskFile('GoNoGo',0)
        sc1_make_taskFile('GoNoGo',1)
        sc1_make_taskFile('GoNoGo',2)
        sc1_make_taskFile('GoNoGo',3)
        sc1_make_taskFile('GoNoGo',4)
        sc1_make_taskFile('GoNoGo',5)
        sc1_make_taskFile('GoNoGo',6)
        sc1_make_taskFile('GoNoGo',7)
        sc1_make_taskFile('GoNoGo',8)
        sc1_make_taskFile('GoNoGo',9)
        sc1_make_taskFile('GoNoGo',10)
        sc1_make_taskFile('GoNoGo',11)
        sc1_make_taskFile('GoNoGo',12)
        sc1_make_taskFile('GoNoGo',13)
        sc1_make_taskFile('GoNoGo',14)
        sc1_make_taskFile('GoNoGo',15)
        sc1_make_taskFile('GoNoGo',16)
        sc1_make_taskFile('GoNoGo',17)
        sc1_make_taskFile('GoNoGo',18)
        sc1_make_taskFile('GoNoGo',19)
        sc1_make_taskFile('GoNoGo',20)
        sc1_make_taskFile('GoNoGo',21)
        sc1_make_taskFile('GoNoGo',22)
        sc1_make_taskFile('GoNoGo',23)
        sc1_make_taskFile('GoNoGo',24)
        sc1_make_taskFile('GoNoGo',25)
        sc1_make_taskFile('GoNoGo',26)
        sc1_make_taskFile('GoNoGo',27)
        sc1_make_taskFile('GoNoGo',28)
        sc1_make_taskFile('GoNoGo',29)
        sc1_make_taskFile('GoNoGo',30)
        
    case 'nBackPic'             % STEP 7.1: User input required - see folder 'task_stimuli/nBackPic'
        % task conditions
        taskNum = varargin{1};
        
        % does task stimuli subfolder exist?
        dircheck(fullfile(fileDir, 'nBackPic'));
        
        T.imgFile = importdata(sprintf('nBackPic%d.txt',taskNum)); % load stimuli (picture handles)
        if (taskNum==0), % slow condition
            T.startTime = startTime_slow;
            T.trialDur = repmat(trialDur_slow,15,1);
        else
            T.startTime = startTime_fast;
            T.trialDur = repmat(trialDur_fast,15,1);
        end
        T.hand = repmat([2],15,1); % 2 - right hand
        T.taskName = repmat({'nBackPic'},15,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_nBackPic_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_nBackPic'
        sc1_make_taskFile('nBackPic',0)
        sc1_make_taskFile('nBackPic',1)
        sc1_make_taskFile('nBackPic',2)
        sc1_make_taskFile('nBackPic',3)
        sc1_make_taskFile('nBackPic',4)
        sc1_make_taskFile('nBackPic',5)
        sc1_make_taskFile('nBackPic',6)
        sc1_make_taskFile('nBackPic',7)
        sc1_make_taskFile('nBackPic',8)
        sc1_make_taskFile('nBackPic',9)
        sc1_make_taskFile('nBackPic',10)
        sc1_make_taskFile('nBackPic',11)
        sc1_make_taskFile('nBackPic',12)
        sc1_make_taskFile('nBackPic',13)
        sc1_make_taskFile('nBackPic',14)
        sc1_make_taskFile('nBackPic',15)
        sc1_make_taskFile('nBackPic',16)
        sc1_make_taskFile('nBackPic',17)
        sc1_make_taskFile('nBackPic',18)
        sc1_make_taskFile('nBackPic',19)
        sc1_make_taskFile('nBackPic',20)
        sc1_make_taskFile('nBackPic',21)
        sc1_make_taskFile('nBackPic',22)
        sc1_make_taskFile('nBackPic',23)
        sc1_make_taskFile('nBackPic',24)
        sc1_make_taskFile('nBackPic',25)
        sc1_make_taskFile('nBackPic',26)
        sc1_make_taskFile('nBackPic',27)
        sc1_make_taskFile('nBackPic',28)
        sc1_make_taskFile('nBackPic',29)
        sc1_make_taskFile('nBackPic',30)
        
    case 'checkerBoard'         % STEP 8.1: Any number of target files can be generated (user input may be necessary depending on how you want to randomise across runs)
        % task conditions
        taskNum = varargin{1};
        
        T.startTime = startTime_fast;
        T.trialDur = repmat(trialDur_fast,15,1);
        
        imgDir = dir([fileDir, '/checkerBoard']); % load stimuli (picture handles)
        for ii = 1:length(imgDir),
            if strfind(imgDir(ii).name, '.jpg'),
                checkerBoard{ii,1} = imgDir(ii).name;
            end
        end
        checkerBoard = checkerBoard(~cellfun(@isempty,checkerBoard));
        
        % Define images for behavioural and scanning sessions
        behavImg = checkerBoard(1:round(length(checkerBoard)/2));
        scanImg = checkerBoard(round(length(checkerBoard)/2)+1:end);
        
        if taskNum<=7, % First seven target files are behavioural
            images = Shuffle(behavImg(randperm(length(behavImg),7)));
        else
            images = Shuffle(scanImg(randperm(length(scanImg),7)));
        end
        
        img = repmat({'checkerBoard'},15,1);
        T.taskName = repmat({'checkerBoard'},15,1);
        
        index = 1;
        for ii = 1:length(img),
            if ~mod(ii,2),
                img(ii,1) = images(index);
                index = index+1;
            end
        end
        T.imgDir = img;
        for i = 1:length(T.imgDir),
            if strfind(char(T.imgDir(i)), 'checkerboard'),
                T.trialType(i,1) = 1; % checkerboard
            else
                T.trialType(i,1) = 2; % neutral
            end
        end
        
        filename = fullfile(taskDir, sprintf('/sc1_checkerBoard_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_checkerBoard'
        sc1_make_taskFile('checkerBoard',1)
        sc1_make_taskFile('checkerBoard',2)
        sc1_make_taskFile('checkerBoard',3)
        sc1_make_taskFile('checkerBoard',4)
        sc1_make_taskFile('checkerBoard',5)
        sc1_make_taskFile('checkerBoard',6)
        sc1_make_taskFile('checkerBoard',7)
        sc1_make_taskFile('checkerBoard',8)
        sc1_make_taskFile('checkerBoard',9)
        sc1_make_taskFile('checkerBoard',10)
        sc1_make_taskFile('checkerBoard',11)
        sc1_make_taskFile('checkerBoard',12)
        sc1_make_taskFile('checkerBoard',13)
        sc1_make_taskFile('checkerBoard',14)
        sc1_make_taskFile('checkerBoard',15)
        sc1_make_taskFile('checkerBoard',16)
        sc1_make_taskFile('checkerBoard',17)
        sc1_make_taskFile('checkerBoard',18)
        sc1_make_taskFile('checkerBoard',19)
        sc1_make_taskFile('checkerBoard',20)
        sc1_make_taskFile('checkerBoard',21)
        
    case 'affective'            % STEP 9.1: Any number of target files can be generated (user input may be necessary depending on how you want to randomise across runs)
        % task conditions
        taskNum = varargin{1};
        
        imgDir = dir([fileDir, '/affective']); % load stimuli (picture handles)
        
        % Probably an easier way of doing this (without two loops)
        for ii = 1:length(imgDir),
            if strfind(imgDir(ii).name, 'unpleasant'),
                Unpleasant{ii,1} = imgDir(ii).name;
            else
                Pleasant{ii,1} = imgDir(ii).name;
            end
        end
        for ii = 1:length(Pleasant),
            if strfind(Pleasant{ii}, 'pleasant'),
                pleasant{ii,1} = Pleasant{ii};
            end
        end
        
        unpleasant = Shuffle(Unpleasant(~cellfun(@isempty,Unpleasant))); % all unpleasant images stored here (shuffled)
        pleasant = Shuffle(pleasant(~cellfun(@isempty,pleasant))); % all pleasant images stored here (shuffled)
        
        % Define images for behavioural and scanning sessions
        behav_UP = unpleasant(1:round(length(unpleasant)/2));
        behav_P = pleasant(1:round(length(pleasant)/2));
        scan_UP = unpleasant(round(length(unpleasant)/2)+1:end);
        scan_P = pleasant(round(length(pleasant)/2)+1:end);
        
        if taskNum<=13, % first 13 files are behavioural
            T.imgDir = Shuffle([behav_UP(randperm(length(behav_UP),8));behav_P(randperm(length(behav_P),7))]);
        else
            T.imgDir = Shuffle([scan_UP(randperm(length(scan_UP),8));scan_P(randperm(length(scan_P),7))]);
        end
        
        if (taskNum==0), % slow condition
            T.startTime = startTime_slow;
            T.trialDur = repmat(trialDur_slow,15,1);
        else
            % fast condition
            T.startTime = startTime_fast;
            T.trialDur = repmat(trialDur_fast,15,1);
        end
        for i = 1:length(T.imgDir),
            if strfind(char(T.imgDir(i)), 'unpleasant'),
                T.trialType(i,1) = 1; % unpleasant
            else
                T.trialType(i,1) = 2; % pleasant
            end
        end
        T.hand = repmat([1],15,1); % 1 - left hand
        T.taskName = repmat({'affective'},15,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_affective_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_affective'
        sc1_make_taskFile('affective',0)
        sc1_make_taskFile('affective',1)
        sc1_make_taskFile('affective',2)
        sc1_make_taskFile('affective',3)
        sc1_make_taskFile('affective',4)
        sc1_make_taskFile('affective',5)
        sc1_make_taskFile('affective',6)
        sc1_make_taskFile('affective',7)
        sc1_make_taskFile('affective',8)
        sc1_make_taskFile('affective',9)
        sc1_make_taskFile('affective',10)
        sc1_make_taskFile('affective',11)
        sc1_make_taskFile('affective',12)
        sc1_make_taskFile('affective',13)
        sc1_make_taskFile('affective',14)
        sc1_make_taskFile('affective',15)
        sc1_make_taskFile('affective',16)
        sc1_make_taskFile('affective',17)
        sc1_make_taskFile('affective',18)
        sc1_make_taskFile('affective',19)
        sc1_make_taskFile('affective',20)
        sc1_make_taskFile('affective',21)
        sc1_make_taskFile('affective',22)
        sc1_make_taskFile('affective',23)
        sc1_make_taskFile('affective',24)
        sc1_make_taskFile('affective',25)
        sc1_make_taskFile('affective',26)
        sc1_make_taskFile('affective',27)
        
    case 'emotional'            % STEP 10.1: Any number of target files can be generated (user input may be necessary depending on how you want to randomise across runs)
        % task conditions
        taskNum = varargin{1};
        
        imgDir = dir([fileDir, '/emotional']); % load stimuli (picture handles)
        
        for ii = 1:length(imgDir),
            if strfind(imgDir(ii).name, 'sad'),
                sad{ii,1} = imgDir(ii).name;
            elseif strfind(imgDir(ii).name, 'happy'),
                happy{ii,1} = imgDir(ii).name;
            end
        end
        sad = sad(~cellfun(@isempty,sad));
        happy = happy(~cellfun(@isempty,happy));
        
        % Define images for behavioural and scanning sessions
        behav_S = sad(1:round(length(sad)/2));
        behav_H = happy(1:round(length(happy)/2));
        scan_S = sad(round(length(sad)/2)+1:end);
        scan_H = happy(round(length(happy)/2)+1:end);
        
        if taskNum<=13, % 13 behavioural runs
            T.imgDir = Shuffle([behav_S(randperm(length(behav_S),8));behav_H(randperm(length(behav_H),7))]);
        else
            T.imgDir = Shuffle([scan_S(randperm(length(scan_S),8));scan_H(randperm(length(scan_H),7))]);
        end
        
        if (taskNum==0),
            T.startTime = startTime_slow;
            T.trialDur = repmat(trialDur_slow,15,1);
        else
            T.startTime = startTime_fast;
            T.trialDur = repmat(trialDur_fast,15,1);
        end
        
        for i = 1:length(T.imgDir),
            if strfind(char(T.imgDir(i)), 'happy'),
                T.trialType(i,1) = 2; % happy
            elseif strfind(char(T.imgDir(i)), 'sad'),
                T.trialType(i,1) = 1; % sad
            end
        end
        T.hand = repmat([2],15,1); % 1 - left hand; 2 - right hand
        T.taskName = repmat({'emotional'},15,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_emotional_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_emotional'
        sc1_make_taskFile('emotional',0)
        sc1_make_taskFile('emotional',1)
        sc1_make_taskFile('emotional',2)
        sc1_make_taskFile('emotional',3)
        sc1_make_taskFile('emotional',4)
        sc1_make_taskFile('emotional',5)
        sc1_make_taskFile('emotional',6)
        sc1_make_taskFile('emotional',7)
        sc1_make_taskFile('emotional',8)
        sc1_make_taskFile('emotional',9)
        sc1_make_taskFile('emotional',10)
        sc1_make_taskFile('emotional',11)
        sc1_make_taskFile('emotional',12)
        sc1_make_taskFile('emotional',13)
        sc1_make_taskFile('emotional',14)
        sc1_make_taskFile('emotional',15)
        sc1_make_taskFile('emotional',16)
        sc1_make_taskFile('emotional',17)
        sc1_make_taskFile('emotional',18)
        sc1_make_taskFile('emotional',19)
        sc1_make_taskFile('emotional',20)
        sc1_make_taskFile('emotional',21)
        sc1_make_taskFile('emotional',22)
        sc1_make_taskFile('emotional',23)
        sc1_make_taskFile('emotional',24)
        sc1_make_taskFile('emotional',25)
        sc1_make_taskFile('emotional',26)
        sc1_make_taskFile('emotional',27)
        
    case 'rest'                 % STEP 11.1: Any number of target files can be generated (no user input)
        % task conditions
        taskNum = varargin{1};
        T.startTime = [0];
        T.trialDur = [30];
        T.taskName = {'rest'};
        
        filename = fullfile(taskDir, sprintf('/sc1_rest_%d.txt',taskNum));
        dsave(filename, T);
    case 'make_rest'
        sc1_make_taskFile('rest',1)
        sc1_make_taskFile('rest',2)
        sc1_make_taskFile('rest',3)
        sc1_make_taskFile('rest',4)
        sc1_make_taskFile('rest',5)
        sc1_make_taskFile('rest',6)
        sc1_make_taskFile('rest',7)
        sc1_make_taskFile('rest',8)
        sc1_make_taskFile('rest',9)
        sc1_make_taskFile('rest',10)
        sc1_make_taskFile('rest',11)
        sc1_make_taskFile('rest',12)
        sc1_make_taskFile('rest',13)
        sc1_make_taskFile('rest',14)
        sc1_make_taskFile('rest',15)
        sc1_make_taskFile('rest',16)
        sc1_make_taskFile('rest',17)
        sc1_make_taskFile('rest',18)
        sc1_make_taskFile('rest',19)
        sc1_make_taskFile('rest',20)
        
    case 'ToM'                  % STEP 12.1: User input required - see folder 'task_stimuli/ToM'
        % task conditions
        % condition: 1 - true; 0 - false
        taskNum = varargin{1};
        
        T = dload(sprintf('qToM_%d.txt', taskNum)); % load stimuli (question)
        T.story = importdata(sprintf('sToM_%d.txt', taskNum)); % load stimuli (story)
        T.startTime = [0;15];
        T.trialDur = [9.6;14.6];
        T.trialType = [2;1]; % 2 - story; 1 - question
        T.hand = repmat([1],2,1); % 1 - left hand
        T.taskName = repmat({'ToM'},2,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_ToM_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_ToM'
        sc1_make_taskFile('ToM',1)
        sc1_make_taskFile('ToM',2)
        sc1_make_taskFile('ToM',3)
        sc1_make_taskFile('ToM',4)
        sc1_make_taskFile('ToM',5)
        sc1_make_taskFile('ToM',6)
        sc1_make_taskFile('ToM',7)
        sc1_make_taskFile('ToM',8)
        sc1_make_taskFile('ToM',9)
        sc1_make_taskFile('ToM',10)
        sc1_make_taskFile('ToM',11)
        sc1_make_taskFile('ToM',12)
        sc1_make_taskFile('ToM',13)
        sc1_make_taskFile('ToM',14)
        sc1_make_taskFile('ToM',15)
        sc1_make_taskFile('ToM',16)
        sc1_make_taskFile('ToM',17)
        sc1_make_taskFile('ToM',18)
        sc1_make_taskFile('ToM',19)
        sc1_make_taskFile('ToM',20)
        sc1_make_taskFile('ToM',21)
        sc1_make_taskFile('ToM',22)
        sc1_make_taskFile('ToM',23)
        sc1_make_taskFile('ToM',24)
        sc1_make_taskFile('ToM',25)
        sc1_make_taskFile('ToM',26)
        sc1_make_taskFile('ToM',27)
        sc1_make_taskFile('ToM',28)
        sc1_make_taskFile('ToM',29)
        
    case 'arithmetic'           % STEP 13.1: User input required - see folder 'task_stimuli/arithmetic'
        % task conditions
        taskNum = varargin{1};
        
        fid = fopen(sprintf('arithmetic%d.txt',taskNum)); % load stimuli (equations)
        for i = 1:10,
            tline = fgetl(fid);
            if ~ischar(tline), break, end
            equations{i} = (tline);
        end
        fclose(fid);
        
        exIndx = [1:length(equations)/2];
        conIndx = [length(exIndx)+1:length(equations)];
        
        all_EQ = [equations(exIndx)'; equations(conIndx)'];
        
        % Determine feedback
        for i = 1:length(all_EQ),
            % control
            if strfind(all_EQ{i}, '1'),
                condition(i,1) = 1; % correct
            else
                condition(i,1) = 0; % incorrect
            end
            if strfind(all_EQ{i}, 'x'),
                g = strfind(all_EQ{i},'x');
                if (str2double(all_EQ{i}(g(1)-2))*str2double(all_EQ{i}(g(1)+2))) == str2double(all_EQ{i}(g(1)+6:g(1)+7)),
                    condition(i,1) = 1; % correct
                else
                    condition(i,1) = 0; % incorrect
                end
            end
        end
        
        if (taskNum==0), % slow condition
            T.startTime = [0;5;10;15;20;25;30;35;40;45];
            T.trialDur = repmat([4.6],10,1);
        else
            % fast condition
            T.startTime = [0;3;6;9;12;15;18;21;24;27];
            T.trialDur = repmat(trialDur_slow,10,1);
        end
        
        % randomise equations and control
        if (mod(taskNum,2)==0)
            T.trialType=[2;2;2;2;2;1;1;1;1;1]; % 2-control;1-equation
            equationList = [(all_EQ(conIndx));(all_EQ(exIndx))];
            T.condition = [condition(conIndx);condition(exIndx)];
            equationList = char(equationList);
            tmp5 = [zeros(1,5)';str2num(equationList(:,9:10))];
        else
            T.trialType=[1;1;1;1;1;2;2;2;2;2]; % 2-control;1-equation
            equationList = [(all_EQ(exIndx));(all_EQ(conIndx))];
            T.condition = condition;
            question = sortcell(repmat({'is there a one?', 'false or true?'},5,1));
            equationList = char(equationList);
            tmp5 = [str2num(equationList(:,9:10));zeros(1,5)'];
        end;
        T.hand = repmat([2],10,1); % 1 - left hand; 2 - right hand
        T.taskName = repmat({'arithmetic'},10,1);
        
        % format equations so that they can be loaded into .txt file
        T.tmp1 = equationList(:,1);
        T.tmp2 = equationList(:,3);
        T.tmp3 = equationList(:,5);
        T.tmp4 = equationList(:,7);
        T.tmp5 = tmp5;
        
        filename = fullfile(taskDir, sprintf('/sc1_arithmetic_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_arithmetic'
        sc1_make_taskFile('arithmetic',0)
        sc1_make_taskFile('arithmetic',1)
        sc1_make_taskFile('arithmetic',2)
        sc1_make_taskFile('arithmetic',3)
        sc1_make_taskFile('arithmetic',4)
        sc1_make_taskFile('arithmetic',5)
        sc1_make_taskFile('arithmetic',6)
        sc1_make_taskFile('arithmetic',7)
        sc1_make_taskFile('arithmetic',8)
        sc1_make_taskFile('arithmetic',9)
        sc1_make_taskFile('arithmetic',10)
        sc1_make_taskFile('arithmetic',11)
        sc1_make_taskFile('arithmetic',12)
        sc1_make_taskFile('arithmetic',13)
        sc1_make_taskFile('arithmetic',14)
        sc1_make_taskFile('arithmetic',15)
        sc1_make_taskFile('arithmetic',16)
        sc1_make_taskFile('arithmetic',17)
        sc1_make_taskFile('arithmetic',18)
        sc1_make_taskFile('arithmetic',19)
        sc1_make_taskFile('arithmetic',20)
        sc1_make_taskFile('arithmetic',21)
        sc1_make_taskFile('arithmetic',22)
        sc1_make_taskFile('arithmetic',23)
        sc1_make_taskFile('arithmetic',24)
        sc1_make_taskFile('arithmetic',25)
        sc1_make_taskFile('arithmetic',26)
        sc1_make_taskFile('arithmetic',27)
        sc1_make_taskFile('arithmetic',28)
        sc1_make_taskFile('arithmetic',29)
        
    case 'actionObservation'    % STEP 14.1: User input required - see folder 'task_stimuli/actionObservation
        % task conditions
        taskNum = varargin{1};
        
        T.startTime = ([0; 15]);
        movFile = importdata(sprintf('actionObservation%d.txt', taskNum)); % load stimuli (fulldir to movies)
        for i = 1:length(movFile),
            mov = movFile{i};
            g = strfind(mov, 'knot');
            T.condition(i,1) = cellstr(mov(g:end));
        end
        
        % post-scan test
        if taskNum>21, % questions are only used in the postscan test
            question = importdata(sprintf('actionObservationQuestion%d.txt',taskNum));
            T.question = repmat(question,2,1);
        end
        
        if taskNum==22,
            T.trialType = [1;1];
        elseif taskNum==23,
            T.trialType = [0;1];
        end
        
        T.movFile = repmat({sprintf('actionObservation%d.txt',taskNum)},2,1);
        T.trialDur = repmat([14.0],2,1);
        T.taskName = repmat({'actionObservation'},2,1);
        T.trialType = [1,2]; % 1-action;2-control
        
        filename = fullfile(taskDir, sprintf('/sc1_actionObservation_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_actionObservation' % STEP 14.2: Target files for behavioural and scanning sessions
        sc1_make_taskFile('actionObservation',1)
        sc1_make_taskFile('actionObservation',2)
        sc1_make_taskFile('actionObservation',3)
        sc1_make_taskFile('actionObservation',4)
        sc1_make_taskFile('actionObservation',5)
        sc1_make_taskFile('actionObservation',6)
        sc1_make_taskFile('actionObservation',7)
        sc1_make_taskFile('actionObservation',8)
        sc1_make_taskFile('actionObservation',9)
        sc1_make_taskFile('actionObservation',10)
        sc1_make_taskFile('actionObservation',11)
        sc1_make_taskFile('actionObservation',12)
        sc1_make_taskFile('actionObservation',13)
        sc1_make_taskFile('actionObservation',14)
        sc1_make_taskFile('actionObservation',15)
        sc1_make_taskFile('actionObservation',16)
        sc1_make_taskFile('actionObservation',17)
        sc1_make_taskFile('actionObservation',18)
        sc1_make_taskFile('actionObservation',19)
        sc1_make_taskFile('actionObservation',20)
        sc1_make_taskFile('actionObservation',21)
    case 'make_actionObservation_test' % STEP 14.3: Target files for post-scan test
        sc1_make_taskFile('actionObservation',22)
        sc1_make_taskFile('actionObservation',23)
        
    case 'motorImagery'         % STEP 15.1: Any number of target files can be generated (no user input)
        % task conditions
        taskNum = varargin{1};
        
        T.startTime = [0];
        T.trialDur = [29.6];
        T.taskName = {'motorImagery'};
        
        filename = fullfile(taskDir, sprintf('/sc1_motorImagery_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_motorImagery'
        sc1_make_taskFile('motorImagery',1)
        sc1_make_taskFile('motorImagery',2)
        sc1_make_taskFile('motorImagery',3)
        sc1_make_taskFile('motorImagery',4)
        sc1_make_taskFile('motorImagery',5)
        sc1_make_taskFile('motorImagery',6)
        sc1_make_taskFile('motorImagery',7)
        sc1_make_taskFile('motorImagery',8)
        sc1_make_taskFile('motorImagery',9)
        sc1_make_taskFile('motorImagery',10)
        sc1_make_taskFile('motorImagery',11)
        sc1_make_taskFile('motorImagery',12)
        sc1_make_taskFile('motorImagery',13)
        sc1_make_taskFile('motorImagery',14)
        sc1_make_taskFile('motorImagery',15)
        sc1_make_taskFile('motorImagery',16)
        sc1_make_taskFile('motorImagery',17)
        sc1_make_taskFile('motorImagery',18)
        sc1_make_taskFile('motorImagery',19)
        sc1_make_taskFile('motorImagery',20)
        sc1_make_taskFile('motorImagery',21)
        sc1_make_taskFile('motorImagery',22)
        
    case 'intervalTiming'       % STEP 16.1: Any number of target files can be generated (no user input)
        taskNum=varargin{1};
        
        % task conditions
        T.startTime = startTime_fast;
        T.trialDur = repmat([1.6],15,1);
        timing = [ones(7,1);ones(8,1)*2]; % 2-short ; 1 - long
        T.trialType = timing(randperm(15)); % changed 08/04 by MK (from timing to trialType)
        interval = repmat([.175;.1],8,1);
        T.interval = interval(T.timing+1);
        T.hand = repmat([2],15,1); % 2 - right hand
        T.taskName = repmat({'intervalTiming'},15,1);
        
        filename = fullfile(taskDir, sprintf('sc1_intervalTiming_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_intervalTiming'
        sc1_make_taskFile('intervalTiming',1)
        sc1_make_taskFile('intervalTiming',2)
        sc1_make_taskFile('intervalTiming',3)
        sc1_make_taskFile('intervalTiming',4)
        sc1_make_taskFile('intervalTiming',5)
        sc1_make_taskFile('intervalTiming',6)
        sc1_make_taskFile('intervalTiming',7)
        sc1_make_taskFile('intervalTiming',8)
        sc1_make_taskFile('intervalTiming',9)
        sc1_make_taskFile('intervalTiming',10)
        sc1_make_taskFile('intervalTiming',11)
        sc1_make_taskFile('intervalTiming',12)
        sc1_make_taskFile('intervalTiming',13)
        sc1_make_taskFile('intervalTiming',14)
        sc1_make_taskFile('intervalTiming',15)
        sc1_make_taskFile('intervalTiming',16)
        sc1_make_taskFile('intervalTiming',17)
        sc1_make_taskFile('intervalTiming',18)
        sc1_make_taskFile('intervalTiming',19)
        sc1_make_taskFile('intervalTiming',20)
        sc1_make_taskFile('intervalTiming',21)
        sc1_make_taskFile('intervalTiming',22)
        sc1_make_taskFile('intervalTiming',23)
        sc1_make_taskFile('intervalTiming',24)
        sc1_make_taskFile('intervalTiming',25)
        sc1_make_taskFile('intervalTiming',26)
        sc1_make_taskFile('intervalTiming',27)
        sc1_make_taskFile('intervalTiming',28)
        sc1_make_taskFile('intervalTiming',29)
        
    case 'motorSequence'        % STEP 17.1: Any number of target files can be generated (no user input)
        taskNum = varargin{1};
        
        % make sequences (experimental)
        SEQ{1}=[1  3  2  4  3  2;
            2  1  3  4  3  1;
            3  2  4  1  4  2;
            4  1  2  3  4  1];
        % make sequences (control)
        SEQ{2}=[1 1 1 1 1 1;
            2 2 2 2 2 2;
            3 3 3 3 3 3 ;
            4 4 4 4 4 4];
        
        if (taskNum==0), % slow condition
            T.startTime = [0;5;10;15;20;25;30;35];
            T.trialDur = repmat([4.6],8,1);
        else
            % fast condition
            T.startTime = [0;3.75;7.5;11.25;15;18.75;22.5;26.25];
            T.trialDur = repmat([3.35],8,1);
        end;
        % randomise order of experimental and control
        if (mod(taskNum,2)==0),
            T.trialType=[2;2;2;2;1;1;1;1]; % 2-experimental; 1-control
            Digit = [SEQ{1}(randperm(4),:);SEQ{2}(randperm(4),:)];
        else
            T.trialType=[1;1;1;1;2;2;2;2]; % 2-experimental; 1-control
            Digit = [SEQ{2}(randperm(4),:);SEQ{1}(randperm(4),:)];
        end;
        T.digit1 = Digit(:,1);
        T.digit2 = Digit(:,2);
        T.digit3 = Digit(:,3);
        T.digit4 = Digit(:,4);
        T.digit5 = Digit(:,5);
        T.digit6 = Digit(:,6);
        T.hand = repmat([0],8,1); % 0 - bimanual
        T.taskName = repmat({'motorSequence'},8,1);
        
        filename = fullfile(taskDir, sprintf('/sc1_motorSequence_%d.txt', taskNum));
        dsave(filename, T);
    case 'make_motorSequence'
        sc1_make_taskFile('motorSequence',0)
        sc1_make_taskFile('motorSequence',1)
        sc1_make_taskFile('motorSequence',2)
        sc1_make_taskFile('motorSequence',3)
        sc1_make_taskFile('motorSequence',4)
        sc1_make_taskFile('motorSequence',5)
        sc1_make_taskFile('motorSequence',6)
        sc1_make_taskFile('motorSequence',7)
        sc1_make_taskFile('motorSequence',8)
        sc1_make_taskFile('motorSequence',9)
        sc1_make_taskFile('motorSequence',10)
        sc1_make_taskFile('motorSequence',11)
        sc1_make_taskFile('motorSequence',12)
        sc1_make_taskFile('motorSequence',13)
        sc1_make_taskFile('motorSequence',14)
        sc1_make_taskFile('motorSequence',15)
        sc1_make_taskFile('motorSequence',16)
        sc1_make_taskFile('motorSequence',17)
        sc1_make_taskFile('motorSequence',18)
        sc1_make_taskFile('motorSequence',19)
        sc1_make_taskFile('motorSequence',20)
        sc1_make_taskFile('motorSequence',21)
        sc1_make_taskFile('motorSequence',22)
        sc1_make_taskFile('motorSequence',23)
        sc1_make_taskFile('motorSequence',24)
        sc1_make_taskFile('motorSequence',25)
        sc1_make_taskFile('motorSequence',26)
        sc1_make_taskFile('motorSequence',27)
        sc1_make_taskFile('motorSequence',28)
        sc1_make_taskFile('motorSequence',29)
        sc1_make_taskFile('motorSequence',30)
        
    case 'make_all_files'
        sc1_make_taskFile('make_stroop')
        sc1_make_taskFile('make_verbGeneration')
        sc1_make_taskFile('make_spatialNavigation')
        sc1_make_taskFile('make_visualSearch')
        sc1_make_taskFile('make_GoNoGo')
        sc1_make_taskFile('make_nBackPic')
        sc1_make_taskFile('make_checkerBoard')
        sc1_make_taskFile('make_affective')
        sc1_make_taskFile('make_emotional')
        sc1_make_taskFile('make_rest')
        sc1_make_taskFile('make_ToM')
        sc1_make_taskFile('make_arithmetic')
        sc1_make_taskFile('make_actionObservation')
        sc1_make_taskFile('make_motorImagery')
        sc1_make_taskFile('make_intervalTiming')
        sc1_make_taskFile('make_motorSequence')
        
end