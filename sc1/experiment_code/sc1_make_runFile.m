function sc1_make_runFile(what, varargin)

% super_cerebellum project
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)
% Makes run files (saved as structures)
% All the variables necessary to execute each run are saved in these files
% For example: list of taskfiles, start times, tasknames are always
% included in each run file
% Refer to the excel spreadsheet 'task design' for an overview
% 1.1-1.16: single-task runs
% 2.1-2.6: response-only runs (11/17 tasks require a response)
% 3.1-3.4: all-task practice runs
% 4.1-4.16: scanner runs
% 5.1-5.3: pre/post scanner runs

%% Set-Up

rand('seed') % initialise random number generator

% Set-Up Directories
rootDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/sc1/run_files';

% Set up variables
instructTime = [5.0]; % length of instruction period
endTime_one = [30+instructTime];
startTime_all = [6;41;76;111;146;181;216;251;286;321;356;391;426;461;496;531;566];
endTime_all = [41;76;111;146;181;216;251;286;321;356;391;426;461;496; 531;566;601];

%% Make run files

switch (what)
    
    case 'run_stroop'           % 1.1
        D.startTime = [0;50;85;120;155;190;225;260];
        D.endTime = [50;85;120;155;190;225;260;295];
        D.taskName = repmat({'stroop'},8,1);
        D.taskFile = {'sc1_stroop_0.txt','sc1_stroop_1.txt','sc1_stroop_2.txt','sc1_stroop_3.txt','sc1_stroop_4.txt','sc1_stroop_5.txt','sc1_stroop_6.txt','sc1_stroop_7.txt'}';
        D.taskFunction = repmat({'sc1_run_stroop'},8,1);
        D.taskNum = [1;2;3;4;5;6;7;8];
        D.instructTime = repmat(instructTime,8,1);
        
        filename = fullfile(rootDir, '/sc1_run_stroop.txt');
        dsave(filename, D)
        
    case 'run_nBack'            % 1.2
        D.startTime = [0;50;85;120;155];
        D.endTime = [50;85;120;155;190];
        D.taskName = repmat({'nBack'},5,1);
        D.taskFile = {'sc1_nBack_0.txt','sc1_nBack_1.txt','sc1_nBack_2.txt','sc1_nBack_3.txt','sc1_nBack_4.txt'}';
        D.taskFunction = repmat({'sc1_run_nBack'},5,1);
        D.taskNum = [1;2;3;4;5];
        D.instructTime = repmat(instructTime,5,1);
        
        filename = fullfile(rootDir, '/sc1_run_nBack.txt');
        dsave(filename, D)
        
    case 'run_verbGeneration'   % 1.3
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.taskName = repmat({'verbGeneration'},2,1);
        D.taskFile = {'sc1_verbGeneration_1.txt','sc1_verbGeneration_2.txt'}';
        D.taskFunction = repmat({'sc1_run_verbGeneration'},2,1);
        D.taskNum = [1;2];
        D.instructTime = repmat(instructTime,2,1);
        
        filename = fullfile(rootDir, '/sc1_run_verbGeneration.txt');
        dsave(filename, D)
        
    case 'run_spatialNavigation'% 1.4
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.taskName = repmat({'spatialNavigation'},2,1);
        D.taskFile = {'sc1_spatialNavigation_1.txt','sc1_spatialNavigation_2.txt'}';
        D.taskFunction = repmat({'sc1_run_spatialNavigation'},2,1);
        D.taskNum = [1;2];
        D.instructTime = repmat(instructTime,2,1);
        
        filename = fullfile(rootDir, '/sc1_run_spatialNavigation.txt');
        dsave(filename, D)
        
    case 'run_visualSearch'     % 1.5
        D.startTime = [0;50;85;120;155];
        D.endTime = [50;85;120;155;190];
        D.taskName = repmat({'visualSearch'},5,1);
        D.taskFile = {'sc1_visualSearch_0.txt','sc1_visualSearch_1.txt','sc1_visualSearch_2.txt','sc1_visualSearch_3.txt','sc1_visualSearch_4.txt'}';
        D.taskFunction = repmat({'sc1_run_visualSearch'},5,1);
        D.taskNum = [1;2;3;4;5];
        D.instructTime = repmat(instructTime,5,1);
        
        filename = fullfile(rootDir, '/sc1_run_visualSearch.txt');
        dsave(filename, D)
        
    case 'run_GoNoGo'           % 1.6
        D.startTime = [0;94;129;164;199];
        D.endTime = [94;129;164;199;234];
        D.taskName = repmat({'GoNoGo'},5,1);
        D.taskFile = {'sc1_GoNoGo_0.txt','sc1_GoNoGo_1.txt','sc1_GoNoGo_2.txt','sc1_GoNoGo_3.txt','sc1_GoNoGo_4.txt'}';
        D.taskFunction = repmat({'sc1_run_GoNoGo'},5,1);
        D.taskNum = [1;2;3;4;5];
        D.instructTime = repmat(instructTime,5,1);
        
        filename = fullfile(rootDir, '/sc1_run_GoNoGo.txt');
        dsave(filename, D)
        
    case 'run_nBackPic'         % 1.7
        D.startTime = [0;50;85;120;155];
        D.endTime = [50;85;120;155;190];
        D.taskName = repmat({'nBackPic'},5,1);
        D.taskFile = {'sc1_nBackPic_0.txt','sc1_nBackPic_1.txt','sc1_nBackPic_2.txt','sc1_nBackPic_3.txt','sc1_nBackPic_4.txt'}';
        D.taskFunction = repmat({'sc1_run_nBackPic'},5,1);
        D.taskNum = [1;2;3;4;5];
        D.instructTime = repmat(instructTime,5,1);
        
        filename = fullfile(rootDir, '/sc1_run_nBackPic.txt');
        dsave(filename, D)
        
    case 'run_checkerBoard'     % 1.8
        D.startTime = [0];
        D.endTime = endTime_one;
        D.taskName = {'checkerBoard'};
        D.taskFile = {'sc1_checkerBoard_1.txt'};
        D.taskFunction = {'sc1_run_checkerBoard'};
        D.taskNum = [1];
        D.instructTime = instructTime;
        
        filename = fullfile(rootDir, '/sc1_run_checkerBoard.txt');
        dsave(filename, D)
        
    case 'run_affective'        % 1.9
        D.startTime = [0;50];
        D.endTime = [50;85];
        D.taskName = repmat({'affective'},2,1);
        D.taskFile = {'sc1_affective_0.txt','sc1_affective_1.txt'}';
        D.taskFunction = repmat({'sc1_run_affective'},2,1);
        D.taskNum = [1;2];
        D.instructTime = repmat(instructTime,2,1);
        
        filename = fullfile(rootDir, '/sc1_run_affective.txt');
        dsave(filename, D)
        
    case 'run_emotional'        % 1.10
        D.startTime = [0;50];
        D.endTime = [50;85];
        D.taskName = repmat({'emotional'},2,1);
        D.taskFile = {'sc1_emotional_0.txt','sc1_emotional_1.txt'}';
        D.taskFunction = repmat({'sc1_run_emotional'},2,1);
        D.taskNum = [1;2];
        D.instructTime = repmat(instructTime,2,1);
        
        filename = fullfile(rootDir, '/sc1_run_emotional.txt');
        dsave(filename, D)
        
    case 'run_ToM'              % 1.11
        D.startTime = [0;35;70];
        D.endTime = [35;70;105];
        D.taskName = repmat({'ToM'},3,1);
        D.taskFile = {'sc1_ToM_1.txt','sc1_ToM_2.txt','sc1_ToM_3.txt'}';
        D.taskFunction = repmat({'sc1_run_ToM'},3,1);
        D.taskNum = [1;2;3];
        D.instructTime = repmat(instructTime,3,1);
        
        filename = fullfile(rootDir, '/sc1_run_ToM.txt');
        dsave(filename, D)
        
    case 'run_arithmetic'       % 1.12
        D.startTime = [0;55;90;125];
        D.endTime = [55;90;125;160];
        D.taskName = repmat({'arithmetic'},4,1);
        D.taskFile = {'sc1_arithmetic_0.txt','sc1_arithmetic_1.txt','sc1_arithmetic_2.txt','sc1_arithmetic_3.txt'}';
        D.taskFunction = repmat({'sc1_run_arithmetic'},4,1);
        D.taskNum = [1;2;3;4];
        D.instructTime = repmat(instructTime,4,1);
        
        filename = fullfile(rootDir, '/sc1_run_arithmetic.txt');
        dsave(filename, D)
        
    case 'run_actionObservation'% 1.13
        D.startTime = [0];
        D.endTime = [35];
        D.taskName = repmat({'actionObservation'},1,1);
        D.taskFile = {'sc1_actionObservation_1.txt'}';
        D.taskFunction = repmat({'sc1_run_actionObservation'},1,1);
        D.taskNum = [1];
        D.instructTime = repmat(instructTime,1,1);
        
        filename = fullfile(rootDir, '/sc1_run_actionObservation.txt');
        dsave(filename, D)
        
    case 'run_motorImagery'     % 1.14
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.taskName = repmat({'motorImagery'},2,1);
        D.taskFile = {'sc1_motorImagery_1.txt','sc1_motorImagery_2.txt'}';
        D.taskFunction = repmat({'sc1_run_motorImagery'},2,1);
        D.taskNum = [1;2];
        D.instructTime = repmat(instructTime,2,1);
        
        filename = fullfile(rootDir, '/sc1_run_motorImagery.txt');
        dsave(filename, D)
        
    case 'run_intervalTiming'   % 1.15
        D.startTime = [0;35;70];
        D.endTime = [35;70;105];
        D.taskName = repmat({'intervalTiming'},3,1);
        D.taskFile = {'sc1_intervalTiming_1.txt','sc1_intervalTiming_2.txt','sc1_intervalTiming_3.txt'}';
        D.taskFunction = repmat({'sc1_run_intervalTiming'},3,1);
        D.taskNum = [1;2;3];
        D.instructTime = repmat(instructTime,3,1);
        
        filename = fullfile(rootDir, '/sc1_run_intervalTiming.txt');
        dsave(filename, D)
        
    case 'run_motorSequence'    % 1.16
        D.startTime = [0;50;85;120;155];
        D.endTime = [50;85;120;155;190];
        D.taskName = repmat({'motorSequence'},5,1);
        D.taskFile = {'sc1_motorSequence_0.txt','sc1_motorSequence_1.txt','sc1_motorSequence_2.txt','sc1_motorSequence_3.txt','sc1_motorSequence_4.txt'}';
        D.taskFunction = repmat({'sc1_run_motorSequence'},5,1);
        D.taskNum = [1;2;3;4;5];
        D.instructTime = repmat(instructTime,5,1);
        
        filename = fullfile(rootDir, '/sc1_run_motorSequence.txt');
        dsave(filename, D)
        
    case 'runResp1'             % 2.1
        a = randperm(11);
        taskName = {'emotional', 'nBack', 'arithmetic', 'visualSearch', 'stroop', 'affective', 'nBackPic', 'GoNoGo', 'motorSequence', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_2.txt','sc1_nBack_5.txt', 'sc1_arithmetic_4.txt', 'sc1_visualSearch_5.txt','sc1_stroop_8.txt', 'sc1_affective_2.txt', 'sc1_nBackPic_5.txt', 'sc1_GoNoGo_5.txt', 'sc1_motorSequence_5.txt', 'sc1_ToM_4.txt','sc1_intervalTiming_4.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic',  'sc1_run_visualSearch', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = [0;35;70;105;140;175;210;245;280;315;350];
        D.endTime = [35;70;105;140;175;210;245;280;315;350;385];
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,11,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11];
        
        filename = fullfile(rootDir, '/sc1_runResp1.txt');
        dsave(filename, D)
        
    case 'runResp2'             % 2.2
        a = randperm(11);
        taskName = {'emotional', 'nBack', 'arithmetic', 'visualSearch', 'stroop', 'affective', 'nBackPic', 'GoNoGo', 'motorSequence', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_3.txt','sc1_nBack_6.txt', 'sc1_arithmetic_5.txt', 'sc1_visualSearch_6.txt','sc1_stroop_9.txt', 'sc1_affective_3.txt', 'sc1_nBackPic_6.txt', 'sc1_GoNoGo_6.txt', 'sc1_motorSequence_6.txt', 'sc1_ToM_5.txt','sc1_intervalTiming_5.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic',  'sc1_run_visualSearch', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = [0;35;70;105;140;175;210;245;280;315;350];
        D.endTime = [35;70;105;140;175;210;245;280;315;350;385];
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,11,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11];
        
        filename = fullfile(rootDir, '/sc1_runResp2.txt');
        dsave(filename, D)
        
    case 'runResp3'             % 2.3
        a = randperm(11);
        taskName = {'emotional', 'nBack', 'arithmetic', 'visualSearch', 'stroop', 'affective', 'nBackPic', 'GoNoGo', 'motorSequence', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_4.txt','sc1_nBack_7.txt', 'sc1_arithmetic_6.txt', 'sc1_visualSearch_7.txt','sc1_stroop_10.txt', 'sc1_affective_4.txt', 'sc1_nBackPic_7.txt', 'sc1_GoNoGo_7.txt', 'sc1_motorSequence_7.txt', 'sc1_ToM_6.txt','sc1_intervalTiming_6.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic',  'sc1_run_visualSearch', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = [0;35;70;105;140;175;210;245;280;315;350];
        D.endTime = [35;70;105;140;175;210;245;280;315;350;385];
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,11,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11];
        
        filename = fullfile(rootDir, '/sc1_runResp3.txt');
        dsave(filename, D)
        
    case 'runResp4'             % 2.4
        a = randperm(11);
        taskName = {'emotional', 'nBack', 'arithmetic', 'visualSearch', 'stroop', 'affective', 'nBackPic', 'GoNoGo', 'motorSequence', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_5.txt','sc1_nBack_8.txt', 'sc1_arithmetic_7.txt', 'sc1_visualSearch_8.txt','sc1_stroop_11.txt', 'sc1_affective_5.txt', 'sc1_nBackPic_8.txt', 'sc1_GoNoGo_8.txt', 'sc1_motorSequence_8.txt', 'sc1_ToM_7.txt','sc1_intervalTiming_7.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic',  'sc1_run_visualSearch', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = [0;35;70;105;140;175;210;245;280;315;350];
        D.endTime = [35;70;105;140;175;210;245;280;315;350;385];
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,11,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11];
        
        filename = fullfile(rootDir, '/sc1_runResp4.txt');
        dsave(filename, D)
        
    case 'runResp5'             % 2.5
        a = randperm(11);
        taskName = {'emotional', 'nBack', 'arithmetic', 'visualSearch', 'stroop', 'affective', 'nBackPic', 'GoNoGo', 'motorSequence', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_6.txt','sc1_nBack_9.txt', 'sc1_arithmetic_8.txt', 'sc1_visualSearch_9.txt','sc1_stroop_12.txt', 'sc1_affective_6.txt', 'sc1_nBackPic_9.txt', 'sc1_GoNoGo_9.txt', 'sc1_motorSequence_9.txt', 'sc1_ToM_8.txt','sc1_intervalTiming_8.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic',  'sc1_run_visualSearch', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = [0;35;70;105;140;175;210;245;280;315;350];
        D.endTime = [35;70;105;140;175;210;245;280;315;350;385];
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,11,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11];
        
        filename = fullfile(rootDir, '/sc1_runResp5.txt');
        dsave(filename, D)
        
    case 'runResp6'             % 2.6
        a = randperm(11);
        taskName = {'emotional', 'nBack', 'arithmetic', 'visualSearch', 'stroop', 'affective', 'nBackPic', 'GoNoGo', 'motorSequence', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_7.txt','sc1_nBack_10.txt', 'sc1_arithmetic_9.txt', 'sc1_visualSearch_10.txt','sc1_stroop_13.txt', 'sc1_affective_7.txt', 'sc1_nBackPic_10.txt', 'sc1_GoNoGo_10.txt', 'sc1_motorSequence_10.txt', 'sc1_ToM_9.txt','sc1_intervalTiming_9.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic',  'sc1_run_visualSearch', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = [0;35;70;105;140;175;210;245;280;315;350];
        D.endTime = [35;70;105;140;175;210;245;280;315;350;385];
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,11,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11];
        
        filename = fullfile(rootDir, '/sc1_runResp6.txt');
        dsave(filename, D)
        
    case 'runPrac1'             % 3.1
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_8.txt','sc1_nBack_11.txt', 'sc1_arithmetic_10.txt', 'sc1_verbGeneration_3.txt', 'sc1_visualSearch_11.txt', 'sc1_spatialNavigation_3.txt', 'sc1_stroop_14.txt', 'sc1_affective_8.txt', 'sc1_nBackPic_11.txt', 'sc1_rest_1.txt', 'sc1_checkerBoard_2.txt','sc1_actionObservation_2.txt','sc1_GoNoGo_11.txt', 'sc1_motorSequence_11.txt', 'sc1_motorImagery_3.txt', 'sc1_ToM_10.txt','sc1_intervalTiming_10.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_runPrac1.txt');
        dsave(filename, D)
        
    case 'runPrac2'             % 3.2
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_9.txt','sc1_nBack_12.txt', 'sc1_arithmetic_11.txt', 'sc1_verbGeneration_4.txt', 'sc1_visualSearch_12.txt', 'sc1_spatialNavigation_4.txt', 'sc1_stroop_15.txt', 'sc1_affective_9.txt', 'sc1_nBackPic_12.txt', 'sc1_rest_2.txt', 'sc1_checkerBoard_3.txt','sc1_actionObservation_3.txt','sc1_GoNoGo_12.txt', 'sc1_motorSequence_12.txt', 'sc1_motorImagery_4.txt', 'sc1_ToM_11.txt','sc1_intervalTiming_11.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_runPrac2.txt');
        dsave(filename, D)
        
    case 'runPrac3'             % 3.3
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_10.txt','sc1_nBack_13.txt', 'sc1_arithmetic_12.txt', 'sc1_verbGeneration_5.txt', 'sc1_visualSearch_13.txt', 'sc1_spatialNavigation_5.txt', 'sc1_stroop_16.txt', 'sc1_affective_10.txt', 'sc1_nBackPic_13.txt', 'sc1_rest_3.txt', 'sc1_checkerBoard_4.txt','sc1_actionObservation_4.txt','sc1_GoNoGo_13.txt', 'sc1_motorSequence_13.txt', 'sc1_motorImagery_5.txt', 'sc1_ToM_12.txt','sc1_intervalTiming_12.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_runPrac3.txt');
        dsave(filename, D)
        
    case 'runPrac4'             % 3.4
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_11.txt','sc1_nBack_14.txt', 'sc1_arithmetic_13.txt', 'sc1_verbGeneration_6.txt', 'sc1_visualSearch_14.txt', 'sc1_spatialNavigation_6.txt', 'sc1_stroop_17.txt', 'sc1_affective_11.txt', 'sc1_nBackPic_14.txt', 'sc1_rest_4.txt', 'sc1_checkerBoard_5.txt','sc1_actionObservation_5.txt','sc1_GoNoGo_14.txt', 'sc1_motorSequence_14.txt', 'sc1_motorImagery_6.txt', 'sc1_ToM_13.txt','sc1_intervalTiming_13.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_runPrac4.txt');
        dsave(filename, D)
        
    case 'run1'                 % 4.1
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_12.txt','sc1_nBack_15.txt', 'sc1_arithmetic_14.txt', 'sc1_verbGeneration_7.txt', 'sc1_visualSearch_15.txt', 'sc1_spatialNavigation_7.txt', 'sc1_stroop_18.txt', 'sc1_affective_12.txt', 'sc1_nBackPic_15.txt', 'sc1_rest_5.txt', 'sc1_checkerBoard_6.txt','sc1_actionObservation_6.txt','sc1_GoNoGo_15.txt', 'sc1_motorSequence_15.txt', 'sc1_motorImagery_7.txt', 'sc1_ToM_14.txt','sc1_intervalTiming_14.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run1.txt');
        dsave(filename, D)
        
    case 'run2'                 % 4.2
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_13.txt','sc1_nBack_16.txt', 'sc1_arithmetic_15.txt', 'sc1_verbGeneration_8.txt', 'sc1_visualSearch_16.txt', 'sc1_spatialNavigation_8.txt', 'sc1_stroop_19.txt', 'sc1_affective_13.txt', 'sc1_nBackPic_16.txt', 'sc1_rest_6.txt', 'sc1_checkerBoard_7.txt','sc1_actionObservation_7.txt','sc1_GoNoGo_16.txt', 'sc1_motorSequence_16.txt', 'sc1_motorImagery_8.txt', 'sc1_ToM_15.txt','sc1_intervalTiming_15.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run2.txt');
        dsave(filename, D)
        
    case 'run3'                 % 4.3
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_14.txt','sc1_nBack_17.txt', 'sc1_arithmetic_16.txt', 'sc1_verbGeneration_9.txt', 'sc1_visualSearch_17.txt', 'sc1_spatialNavigation_9.txt', 'sc1_stroop_20.txt', 'sc1_affective_14.txt', 'sc1_nBackPic_17.txt', 'sc1_rest_7.txt', 'sc1_checkerBoard_8.txt','sc1_actionObservation_8.txt','sc1_GoNoGo_17.txt', 'sc1_motorSequence_17.txt', 'sc1_motorImagery_9.txt', 'sc1_ToM_16.txt','sc1_intervalTiming_16.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run3.txt');
        dsave(filename, D)
        
    case 'run4'                 % 4.4
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_15.txt','sc1_nBack_18.txt', 'sc1_arithmetic_17.txt', 'sc1_verbGeneration_10.txt', 'sc1_visualSearch_18.txt', 'sc1_spatialNavigation_10.txt', 'sc1_stroop_21.txt', 'sc1_affective_15.txt', 'sc1_nBackPic_18.txt', 'sc1_rest_8.txt', 'sc1_checkerBoard_9.txt','sc1_actionObservation_9.txt','sc1_GoNoGo_18.txt', 'sc1_motorSequence_18.txt', 'sc1_motorImagery_10.txt', 'sc1_ToM_17.txt','sc1_intervalTiming_17.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run4.txt');
        dsave(filename, D)
        
    case 'run5'                 % 4.5
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_16.txt','sc1_nBack_19.txt', 'sc1_arithmetic_18.txt', 'sc1_verbGeneration_11.txt', 'sc1_visualSearch_19.txt', 'sc1_spatialNavigation_11.txt', 'sc1_stroop_22.txt', 'sc1_affective_16.txt', 'sc1_nBackPic_19.txt', 'sc1_rest_9.txt', 'sc1_checkerBoard_10.txt','sc1_actionObservation_10.txt','sc1_GoNoGo_19.txt', 'sc1_motorSequence_19.txt', 'sc1_motorImagery_11.txt', 'sc1_ToM_18.txt','sc1_intervalTiming_18.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run5.txt');
        dsave(filename, D)
        
    case 'run6'                 % 4.6
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_17.txt','sc1_nBack_20.txt', 'sc1_arithmetic_19.txt', 'sc1_verbGeneration_12.txt', 'sc1_visualSearch_20.txt', 'sc1_spatialNavigation_12.txt', 'sc1_stroop_23.txt', 'sc1_affective_17.txt', 'sc1_nBackPic_20.txt', 'sc1_rest_10.txt', 'sc1_checkerBoard_11.txt','sc1_actionObservation_11.txt','sc1_GoNoGo_20.txt', 'sc1_motorSequence_20.txt', 'sc1_motorImagery_12.txt', 'sc1_ToM_19.txt','sc1_intervalTiming_19.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run6.txt');
        dsave(filename, D)
        
    case 'run7'                 % 4.7
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_18.txt','sc1_nBack_21.txt', 'sc1_arithmetic_20.txt', 'sc1_verbGeneration_13.txt', 'sc1_visualSearch_21.txt', 'sc1_spatialNavigation_13.txt', 'sc1_stroop_24.txt', 'sc1_affective_18.txt', 'sc1_nBackPic_21.txt', 'sc1_rest_11.txt', 'sc1_checkerBoard_12.txt','sc1_actionObservation_12.txt','sc1_GoNoGo_21.txt', 'sc1_motorSequence_21.txt', 'sc1_motorImagery_13.txt', 'sc1_ToM_20.txt','sc1_intervalTiming_20.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run7.txt');
        dsave(filename, D)
        
    case 'run8'                 % 4.8
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_19.txt','sc1_nBack_22.txt', 'sc1_arithmetic_21.txt', 'sc1_verbGeneration_14.txt', 'sc1_visualSearch_22.txt', 'sc1_spatialNavigation_14.txt', 'sc1_stroop_25.txt', 'sc1_affective_19.txt', 'sc1_nBackPic_22.txt', 'sc1_rest_12.txt', 'sc1_checkerBoard_13.txt','sc1_actionObservation_13.txt','sc1_GoNoGo_22.txt', 'sc1_motorSequence_22.txt', 'sc1_motorImagery_14.txt', 'sc1_ToM_21.txt','sc1_intervalTiming_21.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run8.txt');
        dsave(filename, D)
        
    case 'run9'                 % 4.9
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_20.txt','sc1_nBack_23.txt', 'sc1_arithmetic_22.txt', 'sc1_verbGeneration_15.txt', 'sc1_visualSearch_23.txt', 'sc1_spatialNavigation_15.txt', 'sc1_stroop_26.txt', 'sc1_affective_20.txt', 'sc1_nBackPic_23.txt', 'sc1_rest_13.txt', 'sc1_checkerBoard_14.txt','sc1_actionObservation_14.txt','sc1_GoNoGo_23.txt', 'sc1_motorSequence_23.txt', 'sc1_motorImagery_15.txt', 'sc1_ToM_22.txt','sc1_intervalTiming_22.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run9.txt');
        dsave(filename, D)
        
    case 'run10'                % 4.10
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_21.txt','sc1_nBack_24.txt', 'sc1_arithmetic_23.txt', 'sc1_verbGeneration_16.txt', 'sc1_visualSearch_24.txt', 'sc1_spatialNavigation_16.txt', 'sc1_stroop_27.txt', 'sc1_affective_21.txt', 'sc1_nBackPic_24.txt', 'sc1_rest_14.txt', 'sc1_checkerBoard_15.txt','sc1_actionObservation_15.txt','sc1_GoNoGo_24.txt', 'sc1_motorSequence_24.txt', 'sc1_motorImagery_16.txt', 'sc1_ToM_23.txt','sc1_intervalTiming_23.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run10.txt');
        dsave(filename, D)
        
    case 'run11'                % 4.11
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_22.txt','sc1_nBack_25.txt', 'sc1_arithmetic_24.txt', 'sc1_verbGeneration_17.txt', 'sc1_visualSearch_25.txt', 'sc1_spatialNavigation_17.txt', 'sc1_stroop_28.txt', 'sc1_affective_22.txt', 'sc1_nBackPic_25.txt', 'sc1_rest_15.txt', 'sc1_checkerBoard_16.txt','sc1_actionObservation_16.txt','sc1_GoNoGo_25.txt', 'sc1_motorSequence_25.txt', 'sc1_motorImagery_17.txt', 'sc1_ToM_24.txt','sc1_intervalTiming_24.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run11.txt');
        dsave(filename, D)
        
    case 'run12'                % 4.12
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_23.txt','sc1_nBack_26.txt', 'sc1_arithmetic_25.txt', 'sc1_verbGeneration_18.txt', 'sc1_visualSearch_26.txt', 'sc1_spatialNavigation_18.txt', 'sc1_stroop_29.txt', 'sc1_affective_23.txt', 'sc1_nBackPic_26.txt', 'sc1_rest_16.txt', 'sc1_checkerBoard_17.txt','sc1_actionObservation_17.txt','sc1_GoNoGo_26.txt', 'sc1_motorSequence_26.txt', 'sc1_motorImagery_18.txt', 'sc1_ToM_25.txt','sc1_intervalTiming_25.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run12.txt');
        dsave(filename, D)
        
    case 'run13'                % 4.13
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_24.txt','sc1_nBack_27.txt', 'sc1_arithmetic_26.txt', 'sc1_verbGeneration_19.txt', 'sc1_visualSearch_27.txt', 'sc1_spatialNavigation_19.txt', 'sc1_stroop_30.txt', 'sc1_affective_24.txt', 'sc1_nBackPic_27.txt', 'sc1_rest_17.txt', 'sc1_checkerBoard_18.txt','sc1_actionObservation_18.txt','sc1_GoNoGo_27.txt', 'sc1_motorSequence_27.txt', 'sc1_motorImagery_19.txt', 'sc1_ToM_26.txt','sc1_intervalTiming_26.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run13.txt');
        dsave(filename, D)
        
    case 'run14'                % 4.14
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_25.txt','sc1_nBack_28.txt', 'sc1_arithmetic_27.txt', 'sc1_verbGeneration_20.txt', 'sc1_visualSearch_28.txt', 'sc1_spatialNavigation_20.txt', 'sc1_stroop_31.txt', 'sc1_affective_25.txt', 'sc1_nBackPic_28.txt', 'sc1_rest_18.txt', 'sc1_checkerBoard_19.txt','sc1_actionObservation_19.txt','sc1_GoNoGo_28.txt', 'sc1_motorSequence_28.txt', 'sc1_motorImagery_20.txt', 'sc1_ToM_27.txt','sc1_intervalTiming_27.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run14.txt');
        dsave(filename, D)
        
    case 'run15'                % 4.15
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_26.txt','sc1_nBack_29.txt', 'sc1_arithmetic_28.txt', 'sc1_verbGeneration_21.txt', 'sc1_visualSearch_29.txt', 'sc1_spatialNavigation_21.txt', 'sc1_stroop_32.txt', 'sc1_affective_26.txt', 'sc1_nBackPic_29.txt', 'sc1_rest_19.txt', 'sc1_checkerBoard_20.txt','sc1_actionObservation_20.txt','sc1_GoNoGo_29.txt', 'sc1_motorSequence_29.txt', 'sc1_motorImagery_21.txt', 'sc1_ToM_28.txt','sc1_intervalTiming_28.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run15.txt');
        dsave(filename, D)
        
    case 'run16'                % 4.16
        a = randperm(17);
        taskName = {'emotional', 'nBack', 'arithmetic', 'verbGeneration', 'visualSearch', 'spatialNavigation','stroop', 'affective', 'nBackPic', 'rest', 'checkerBoard', 'actionObservation', 'GoNoGo', 'motorSequence', 'motorImagery', 'ToM', 'intervalTiming'}';
        taskFile = {'sc1_emotional_27.txt','sc1_nBack_30.txt', 'sc1_arithmetic_29.txt', 'sc1_verbGeneration_22.txt', 'sc1_visualSearch_30.txt', 'sc1_spatialNavigation_22.txt', 'sc1_stroop_33.txt', 'sc1_affective_27.txt', 'sc1_nBackPic_30.txt', 'sc1_rest_20.txt', 'sc1_checkerBoard_21.txt','sc1_actionObservation_21.txt','sc1_GoNoGo_30.txt', 'sc1_motorSequence_30.txt', 'sc1_motorImagery_22.txt', 'sc1_ToM_29.txt','sc1_intervalTiming_29.txt' }';
        taskFunction = {'sc1_run_emotional','sc1_run_nBack', 'sc1_run_arithmetic', 'sc1_run_verbGeneration', 'sc1_run_visualSearch', 'sc1_run_spatialNavigation', 'sc1_run_stroop', 'sc1_run_affective', 'sc1_run_nBackPic', 'sc1_run_rest', 'sc1_run_checkerBoard', 'sc1_run_actionObservation', 'sc1_run_GoNoGo', 'sc1_run_motorSequence', 'sc1_run_motorImagery', 'sc1_run_ToM', 'sc1_run_intervalTiming'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc1_run16.txt');
        dsave(filename, D)
        
    case 'runPreScan'           % 5.1
        D.taskName = {'intervalTiming','actionObservation','arithmetic','visualSearch'}';
        D.taskFile = { 'sc1_intervalTiming_4.txt', 'sc1_actionObservation_2.txt', 'sc1_arithmetic_5.txt','sc1_visualSearch_2.txt'}';
        D.taskFunction = {'sc1_run_intervalTiming', 'sc1_run_actionObservation','sc1_run_arithmetic','sc1_run_visualSearch'}';
        D.startTime = [0;35;70;105];
        D.endTime = [35;70;105;140];
        D.instructTime = repmat(instructTime,4,1);
        D.taskNum = [1;2;3;4];
        
        filename = fullfile(rootDir, '/sc1_runPreScan.txt');
        dsave(filename, D)
        
    case 'runPostScan1'         % 5.2
        D.taskName = {'verbGeneration','actionObservation'}';
        D.taskFile = { 'sc1_verbGeneration_23.txt', 'sc1_actionObservation_22.txt'}';
        D.taskFunction = {'sc1_run_verbGeneration_postScan', 'sc1_run_actionObservation_postScan'}';
        D.startTime = [0;40];
        D.endTime = [40;75];
        D.instructTime = repmat(instructTime,2,1);
        D.taskNum = [1;2];
        
        filename = fullfile(rootDir, '/sc1_runPostScan1.txt');
        dsave(filename, D)
        
    case 'runPostScan2'         % 5.3
        D.taskName = {'verbGeneration','actionObservation'}';
        D.taskFile = { 'sc1_verbGeneration_24.txt', 'sc1_actionObservation_23.txt'}';
        D.taskFunction = {'sc1_run_verbGeneration_postScan', 'sc1_run_actionObservation_postScan'}';
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.instructTime = repmat(instructTime,2,1);
        D.taskNum = [1;2];
        
        filename = fullfile(rootDir, '/sc1_runPostScan2.txt');
        dsave(filename, D)
        
    case 'test'
        D.taskName = {'actionObservation','intervalTiming'}';
        D.taskFile = { 'sc1_actionObservation_2.txt','sc1_intervalTiming_4.txt'}';
        D.taskFunction = {'sc1_run_actionObservation','sc1_run_intervalTiming'}';
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.instructTime = repmat(instructTime,2,1);
        D.taskNum = [1;2];
        
        filename = fullfile(rootDir, '/sc1_run_test.txt');
        dsave(filename, D)
        
    case 'test_action'
        D.taskName = repmat({'actionObservation'}',16,1);
        D.taskFile = {'sc1_actionObservation_6.txt','sc1_actionObservation_7.txt','sc1_actionObservation_8.txt','sc1_actionObservation_9.txt','sc1_actionObservation_10.txt','sc1_actionObservation_11.txt','sc1_actionObservation_12.txt','sc1_actionObservation_13.txt','sc1_actionObservation_14.txt','sc1_actionObservation_15.txt','sc1_actionObservation_16.txt','sc1_actionObservation_17.txt','sc1_actionObservation_18.txt','sc1_actionObservation_19.txt','sc1_actionObservation_20.txt','sc1_actionObservation_21.txt'}';
        D.taskFunction = repmat({'sc1_run_actionObservation'}',16,1);
        D.startTime = [6;41;76;111;146;181;216;251;286;321;356;391;426;461;496;531];
        D.endTime = [41;76;111;146;181;216;251;286;321;356;391;426;461;496;531;566];
        D.instructTime = repmat(instructTime,16,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16];
        
        filename = fullfile(rootDir, '/sc1_run_test_action.txt');
        dsave(filename, D)
        
    case 'make_all_files'
        sc1_make_runFile('run_stroop')
        sc1_make_runFile('run_nBack')
        sc1_make_runFile('run_verbGeneration')
        sc1_make_runFile('run_spatialNavigation')
        sc1_make_runFile('run_visualSearch')
        sc1_make_runFile('run_GoNoGo')
        sc1_make_runFile('run_nBackPic')
        sc1_make_runFile('run_checkerBoard')
        sc1_make_runFile('run_affective')
        sc1_make_runFile('run_emotional')
        sc1_make_runFile('run_ToM')
        sc1_make_runFile('run_arithmetic')
        sc1_make_runFile('run_actionObservation')
        sc1_make_runFile('run_motorImagery')
        sc1_make_runFile('run_intervalTiming')
        sc1_make_runFile('run_motorSequence')
        sc1_make_runFile('runResp1')
        sc1_make_runFile('runResp2')
        sc1_make_runFile('runResp3')
        sc1_make_runFile('runResp4')
        sc1_make_runFile('runResp5')
        sc1_make_runFile('runResp6')
        sc1_make_runFile('runPrac1')
        sc1_make_runFile('runPrac2')
        sc1_make_runFile('runPrac3')
        sc1_make_runFile('runPrac4')
        sc1_make_runFile('run1')
        sc1_make_runFile('run2')
        sc1_make_runFile('run3')
        sc1_make_runFile('run4')
        sc1_make_runFile('run5')
        sc1_make_runFile('run6')
        sc1_make_runFile('run7')
        sc1_make_runFile('run8')
        sc1_make_runFile('run9')
        sc1_make_runFile('run10')
        sc1_make_runFile('run11')
        sc1_make_runFile('run12')
        sc1_make_runFile('run13')
        sc1_make_runFile('run14')
        sc1_make_runFile('run15')
        sc1_make_runFile('run16')
        sc1_make_runFile('runPreScan')
        sc1_make_runFile('runPostScan')
        
    otherwise
        disp('there is no such case.')
        
end