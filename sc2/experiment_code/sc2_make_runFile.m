function sc2_make_runFile(what, varargin)

% sc1 project
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)
% Makes run files (saved as structures)
% All the variables necessary to execute each run are saved in these files
% For example: list of taskfiles, start times, tasknames are always
% included in each run file
% Refer to the excel spreadsheet 'task design' for an overview
% 1.1-1.16: single-task runs
% 2.1-2.6: response-only runs (10/17 tasks require a response)
% 3.1-3.4: all-task practice runs
% 4.1-4.16: scanner runs
% 5.1-5.3: pre/post scanner runs

%% Set-Up

rand('seed') % initialise random number generator

% Set-Up Directories
rootDir = '/Users/mking/Dropbox (Diedrichsenlab)/Cerebellum_Cognition/data/sc2/run_files';

% Set up variables
instructTime = [5.0]; % length of instruction period
startTime_all = [6;41;76;111;146;181;216;251;286;321;356;391;426;461;496;531;566];
endTime_all = [41;76;111;146;181;216;251;286;321;356;391;426;461;496; 531;566;601];

%% Make run files

switch (what)
    
    case 'run_verbGeneration'   % 1.1
        D.startTime = [0];
        D.endTime = [35];
        D.taskNum = [1];
        for i=1:length(D.startTime),
            D.taskFile = {sprintf('sc2_verbGeneration_%d.txt',i)}';
        end
        D.taskName = repmat({'verbGeneration2'},i,1);
        D.taskFunction = repmat({'sc2_run_verbGeneration'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_verbGeneration.txt');
        dsave(filename, D)
        
    case 'run_spatialNavigation'% 1.2
        D.startTime = [0];
        D.endTime = [35];
        D.taskNum = [1];
        for i=1:length(D.startTime),
            D.taskFile = {sprintf('sc2_spatialNavigation_%d.txt',i)}';
        end
        D.taskFunction = repmat({'sc2_run_spatialNavigation'},i,1);
        D.taskName = repmat({'spatialNavigation2'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_spatialNavigation.txt');
        dsave(filename, D)
        
    case 'run_visualSearch'     % 1.3
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.taskNum = [1;2];
        for i=1:length(D.startTime),
            taskFile(i)= {sprintf('sc2_visualSearch_%d.txt',i)};
        end
        D.taskFile=taskFile';
        D.taskName = repmat({'visualSearch2'},i,1);
        D.taskFunction = repmat({'sc2_run_visualSearch'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_visualSearch.txt');
        dsave(filename, D)
        
    case 'run_nBackPic'         % 1.4
        D.startTime = [0;35;70];
        D.endTime = [35;70;105];
        D.taskNum = [1;2;3];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_nBackPic_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_nBackPic'},i,1);
        D.taskName = repmat({'nBackPic2'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_nBackPic.txt');
        dsave(filename, D)
        
    case 'run_ToM'              % 1.5
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.taskNum = [1;2];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_ToM_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_ToM'},i,1);
        D.taskName = repmat({'ToM2'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_ToM.txt');
        dsave(filename, D)
        
    case 'run_actionObservation'% 1.6
        D.startTime = [0];
        D.endTime = [35];
        D.taskNum = [1];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_actionObservation_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_actionObservation'},i,1);
        D.taskName = repmat({'actionObservation2'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_actionObservation.txt');
        dsave(filename, D)
        
    case 'run_motorSequence'    % 1.7
        D.startTime = [0;35;70;105;140];
        D.endTime = [35;70;105;140;175];
        D.taskNum = [1;2;3;4;5];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_motorSequence_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_motorSequence'},i,1);
        D.taskName = repmat({'motorSequence2'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_motorSequence.txt');
        dsave(filename, D)
        
    case 'run_prediction'       % 1.8
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.taskName = repmat({'prediction'},2,1);
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_prediction_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_prediction'},2,1);
        D.taskNum = [1;2];
        D.instructTime = repmat(instructTime,2,1);
        
        filename = fullfile(rootDir, '/sc2_run_prediction.txt');
        dsave(filename, D)
        
    case 'run_mentalRotation'   % 1.9
        D.startTime = [0;35;70;105];
        D.endTime = [35;70;105;140];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_mentalRotation_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_mentalRotation'},i,1);
        D.taskName = repmat({'mentalRotation'},i,1);
        D.taskNum = [1;2;3;4];
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_mentalRotation.txt');
        dsave(filename, D)
        
    case 'run_CPRO'             % 1.10
        D.startTime = [0;35;70;105;140;175;210];
        D.endTime = [35;70;105;140;175;210;145];
        D.taskNum = [1;2;3;4;5;6;7];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_CPRO_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_CPRO'},i,1);
        D.taskName = repmat({'CPRO'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_CPRO.txt');
        dsave(filename, D)
        
    case 'run_emotionProcess'   % 1.15
        D.startTime = [0;35];
        D.endTime = [35;70];
        D.taskNum = [1;2];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_emotionProcess_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_emotionProcess'},i,1);
        D.taskName = repmat({'emotionProcess'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_emotionProcess.txt');
        dsave(filename, D)
        
    case 'run_respAlt'          % 1.16
        D.startTime = [0;35;70;105];
        D.endTime = [35;70;105;140];
        D.taskNum = [1;2;3;4];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_respAlt_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_respAlt'},i,1);
        D.taskName = repmat({'respAlt'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_respAlt.txt');
        dsave(filename, D)
        
    case 'run_spatialMap'       % 1.17
        D.startTime = [0;35;70;105;140];
        D.endTime = [35;70;105;140;175];
        D.taskNum = [1;2;3;4;5];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_spatialMap_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_spatialMap'},i,1);
        D.taskName = repmat({'spatialMap'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_spatialMap.txt');
        dsave(filename, D)
        
    case 'run_landscapeMovie'   % 1.18
        D.startTime = [0;35;70;105;140;175;210;245];
        D.endTime = [35;70;105;140;175;210;245;280];
        D.taskNum = [1;2;3;4;5;6;7;8];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_landscapeMovie_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_landscapeMovie'},i,1);
        D.taskName = repmat({'landscapeMovie'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_landscapeMovie.txt');
        dsave(filename, D)
        
    case 'run_natureMovie'      % 1.19
        D.startTime = [0;35;70;105;140;175;210;245];
        D.endTime = [35;70;105;140;175;210;245;280];
        D.taskNum = [1;2;3;4;5;6;7;8];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_natureMovie_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_natureMovie'},i,1);
        D.taskName = repmat({'natureMovie'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_natureMovie.txt');
        dsave(filename, D)    
        
    case 'run_romanceMovie'     % 1.20
        D.startTime = [0;35;70;105;140;175;210;245];
        D.endTime = [35;70;105;140;175;210;245;280];
        D.taskNum = [1;2;3;4;5;6;7;8];
        for i=1:length(D.startTime),
            taskFile(i) = {sprintf('sc2_romanceMovie_%d.txt',i)}';
        end
        D.taskFile=taskFile';
        D.taskFunction = repmat({'sc2_run_romanceMovie'},i,1);
        D.taskName = repmat({'romanceMovie'},i,1);
        D.instructTime = repmat(instructTime,i,1);
        
        filename = fullfile(rootDir, '/sc2_run_romanceMovie.txt');
        dsave(filename, D)    
        
    case 'runResp1'             % 2.1
        taskName = {'CPRO', 'prediction', 'respAlt', 'motorSequence2', 'spatialMap', 'visualSearch2', 'nBackPic2', 'emotionProcess','mentalRotation'}';
        taskFile = {'sc2_CPRO_8.txt','sc2_prediction_3.txt','sc2_respAlt_5.txt', 'sc2_motorSequence_6.txt', 'sc2_spatialMap_6.txt','sc2_visualSearch_3.txt', 'sc2_nBackPic_4.txt', 'sc2_emotionProcess_3.txt','sc2_mentalRotation_5.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction', 'sc2_run_respAlt',  'sc2_run_motorSequence', 'sc2_run_spatialMap', 'sc2_run_visualSearch', 'sc2_run_nBackPic', 'sc2_run_emotionProcess','sc2_run_mentalRotation'}';
        D.startTime = [0;35;70;105;140;175;210;245;280];
        D.endTime = [35;70;105;140;175;210;245;280;315];
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,length(taskName),1);
        D.taskNum = [1;2;3;4;5;6;7;8;9];
        
        filename = fullfile(rootDir, '/sc2_runResp1.txt');
        dsave(filename, D)
        
    case 'runResp2'             % 2.2
        taskName = {'CPRO', 'prediction', 'respAlt', 'motorSequence2', 'spatialMap', 'visualSearch2', 'nBackPic2', 'emotionProcess','mentalRotation'}';
        taskFile = {'sc2_CPRO_9.txt','sc2_prediction_4.txt','sc2_respAlt_6.txt', 'sc2_motorSequence_7.txt', 'sc2_spatialMap_7.txt','sc2_visualSearch_4.txt', 'sc2_nBackPic_5.txt', 'sc2_emotionProcess_4.txt','sc2_mentalRotation_6.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction', 'sc2_run_respAlt',  'sc2_run_motorSequence', 'sc2_run_spatialMap', 'sc2_run_visualSearch', 'sc2_run_nBackPic', 'sc2_run_emotionProcess','sc2_run_mentalRotation'}';
        D.startTime = [0;35;70;105;140;175;210;245;280];
        D.endTime = [35;70;105;140;175;210;245;280;315];
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,length(taskName),1);
        D.taskNum = [1;2;3;4;5;6;7;8;9];
        
        filename = fullfile(rootDir, '/sc2_runResp2.txt');
        dsave(filename, D)
        
    case 'runResp3'             % 2.3
        taskName = {'CPRO', 'prediction', 'respAlt', 'motorSequence2', 'spatialMap', 'visualSearch2', 'nBackPic2', 'emotionProcess','mentalRotation'}';
        taskFile = {'sc2_CPRO_10.txt','sc2_prediction_5.txt','sc2_respAlt_7.txt', 'sc2_motorSequence_8.txt', 'sc2_spatialMap_8.txt','sc2_visualSearch_5.txt', 'sc2_nBackPic_6.txt', 'sc2_emotionProcess_5.txt','sc2_mentalRotation_7.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction', 'sc2_run_respAlt',  'sc2_run_motorSequence', 'sc2_run_spatialMap', 'sc2_run_visualSearch', 'sc2_run_nBackPic', 'sc2_run_emotionProcess','sc2_run_mentalRotation'}';
        D.startTime = [0;35;70;105;140;175;210;245;280];
        D.endTime = [35;70;105;140;175;210;245;280;315];
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,length(taskName),1);
        D.taskNum = [1;2;3;4;5;6;7;8;9];
        
        filename = fullfile(rootDir, '/sc2_runResp3.txt');
        dsave(filename, D)
        
    case 'runResp4'             % 2.4
        taskName = {'CPRO', 'prediction', 'respAlt', 'motorSequence2', 'spatialMap', 'visualSearch2', 'nBackPic2', 'emotionProcess','mentalRotation'}';
        taskFile = {'sc2_CPRO_11.txt','sc2_prediction_6.txt','sc2_respAlt_8.txt', 'sc2_motorSequence_9.txt', 'sc2_spatialMap_9.txt','sc2_visualSearch_6.txt', 'sc2_nBackPic_7.txt', 'sc2_emotionProcess_6.txt','sc2_mentalRotation_8.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction', 'sc2_run_respAlt',  'sc2_run_motorSequence', 'sc2_run_spatialMap', 'sc2_run_visualSearch', 'sc2_run_nBackPic', 'sc2_run_emotionProcess','sc2_run_mentalRotation'}';
        D.startTime = [0;35;70;105;140;175;210;245;280];
        D.endTime = [35;70;105;140;175;210;245;280;315];
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,length(taskName),1);
        D.taskNum = [1;2;3;4;5;6;7;8;9];
        
        filename = fullfile(rootDir, '/sc2_runResp4.txt');
        dsave(filename, D)
        
    case 'runPrac1'             % 3.1
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_12.txt','sc2_prediction_7.txt','sc2_verbGeneration_2.txt', 'sc2_romanceMovie_9.txt', 'sc2_visualSearch_7.txt', 'sc2_respAlt_9.txt', 'sc2_spatialNavigation_2.txt', 'sc2_landscapeMovie_9.txt', 'sc2_spatialMap_10.txt', 'sc2_nBackPic_8.txt', 'sc2_rest_1.txt', 'sc2_actionObservation_2.txt','sc2_mentalRotation_9.txt','sc2_emotionProcess_7.txt', 'sc2_motorSequence_10.txt', 'sc2_ToM_3.txt', 'sc2_natureMovie_9.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_runPrac1.txt');
        dsave(filename, D)
        
    case 'runPrac2'             % 3.2
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_13.txt','sc2_prediction_8.txt','sc2_verbGeneration_3.txt', 'sc2_romanceMovie_10.txt', 'sc2_visualSearch_8.txt', 'sc2_respAlt_10.txt', 'sc2_spatialNavigation_3.txt', 'sc2_landscapeMovie_10.txt', 'sc2_spatialMap_11.txt', 'sc2_nBackPic_9.txt', 'sc2_rest_2.txt', 'sc2_actionObservation_3.txt','sc2_mentalRotation_10.txt','sc2_emotionProcess_8.txt', 'sc2_motorSequence_11.txt', 'sc2_ToM_4.txt', 'sc2_natureMovie_10.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_runPrac2.txt');
        dsave(filename, D)
        
    case 'run1'                 % 4.1
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_14.txt','sc2_prediction_9.txt','sc2_verbGeneration_4.txt', 'sc2_romanceMovie_1.txt', 'sc2_visualSearch_9.txt', 'sc2_respAlt_11.txt', 'sc2_spatialNavigation_4.txt', 'sc2_landscapeMovie_1.txt', 'sc2_spatialMap_12.txt', 'sc2_nBackPic_10.txt', 'sc2_rest_3.txt', 'sc2_actionObservation_4.txt','sc2_mentalRotation_11.txt','sc2_emotionProcess_9.txt', 'sc2_motorSequence_12.txt', 'sc2_ToM_5.txt', 'sc2_natureMovie_1.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run1.txt');
        dsave(filename, D)
        
    case 'run2'                 % 4.2
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_15.txt','sc2_prediction_10.txt','sc2_verbGeneration_5.txt', 'sc2_romanceMovie_2.txt', 'sc2_visualSearch_10.txt', 'sc2_respAlt_12.txt', 'sc2_spatialNavigation_5.txt', 'sc2_landscapeMovie_2.txt', 'sc2_spatialMap_13.txt', 'sc2_nBackPic_11.txt', 'sc2_rest_4.txt', 'sc2_actionObservation_5.txt','sc2_mentalRotation_12.txt','sc2_emotionProcess_10.txt', 'sc2_motorSequence_13.txt', 'sc2_ToM_6.txt', 'sc2_natureMovie_2.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run2.txt');
        dsave(filename, D)
        
    case 'run3'                 % 4.3
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_16.txt','sc2_prediction_11.txt','sc2_verbGeneration_6.txt', 'sc2_romanceMovie_3.txt', 'sc2_visualSearch_11.txt', 'sc2_respAlt_13.txt', 'sc2_spatialNavigation_6.txt', 'sc2_landscapeMovie_3.txt', 'sc2_spatialMap_14.txt', 'sc2_nBackPic_12.txt', 'sc2_rest_5.txt', 'sc2_actionObservation_6.txt','sc2_mentalRotation_13.txt','sc2_emotionProcess_11.txt', 'sc2_motorSequence_14.txt', 'sc2_ToM_7.txt', 'sc2_natureMovie_3.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run3.txt');
        dsave(filename, D)
        
    case 'run4'                 % 4.4
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_17.txt','sc2_prediction_12.txt','sc2_verbGeneration_7.txt', 'sc2_romanceMovie_4.txt', 'sc2_visualSearch_12.txt', 'sc2_respAlt_14.txt', 'sc2_spatialNavigation_7.txt', 'sc2_landscapeMovie_4.txt', 'sc2_spatialMap_15.txt', 'sc2_nBackPic_13.txt', 'sc2_rest_6.txt', 'sc2_actionObservation_7.txt','sc2_mentalRotation_14.txt','sc2_emotionProcess_12.txt', 'sc2_motorSequence_15.txt', 'sc2_ToM_8.txt', 'sc2_natureMovie_4.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run4.txt');
        dsave(filename, D)
        
    case 'run5'                 % 4.5
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_18.txt','sc2_prediction_13.txt','sc2_verbGeneration_8.txt', 'sc2_romanceMovie_5.txt', 'sc2_visualSearch_13.txt', 'sc2_respAlt_15.txt', 'sc2_spatialNavigation_8.txt', 'sc2_landscapeMovie_5.txt', 'sc2_spatialMap_16.txt', 'sc2_nBackPic_14.txt', 'sc2_rest_7.txt', 'sc2_actionObservation_8.txt','sc2_mentalRotation_15.txt','sc2_emotionProcess_13.txt', 'sc2_motorSequence_16.txt', 'sc2_ToM_9.txt', 'sc2_natureMovie_5.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run5.txt');
        dsave(filename, D)
        
    case 'run6'                 % 4.6
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_19.txt','sc2_prediction_14.txt','sc2_verbGeneration_9.txt', 'sc2_romanceMovie_6.txt', 'sc2_visualSearch_14.txt', 'sc2_respAlt_16.txt', 'sc2_spatialNavigation_9.txt', 'sc2_landscapeMovie_6.txt', 'sc2_spatialMap_17.txt', 'sc2_nBackPic_15.txt', 'sc2_rest_8.txt', 'sc2_actionObservation_9.txt','sc2_mentalRotation_16.txt','sc2_emotionProcess_14.txt', 'sc2_motorSequence_17.txt', 'sc2_ToM_10.txt', 'sc2_natureMovie_6.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run6.txt');
        dsave(filename, D)
        
    case 'run7'                 % 4.7
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_20.txt','sc2_prediction_15.txt','sc2_verbGeneration_10.txt', 'sc2_romanceMovie_7.txt', 'sc2_visualSearch_15.txt', 'sc2_respAlt_17.txt', 'sc2_spatialNavigation_10.txt', 'sc2_landscapeMovie_7.txt', 'sc2_spatialMap_18.txt', 'sc2_nBackPic_16.txt', 'sc2_rest_9.txt', 'sc2_actionObservation_10.txt','sc2_mentalRotation_17.txt','sc2_emotionProcess_15.txt', 'sc2_motorSequence_18.txt', 'sc2_ToM_11.txt', 'sc2_natureMovie_7.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run7.txt');
        dsave(filename, D)
        
    case 'run8'                 % 4.8
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_21.txt','sc2_prediction_16.txt','sc2_verbGeneration_11.txt', 'sc2_romanceMovie_8.txt', 'sc2_visualSearch_16.txt', 'sc2_respAlt_18.txt', 'sc2_spatialNavigation_11.txt', 'sc2_landscapeMovie_8.txt', 'sc2_spatialMap_19.txt', 'sc2_nBackPic_17.txt', 'sc2_rest_10.txt', 'sc2_actionObservation_11.txt','sc2_mentalRotation_18.txt','sc2_emotionProcess_16.txt', 'sc2_motorSequence_19.txt', 'sc2_ToM_12.txt', 'sc2_natureMovie_8.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run8.txt');
        dsave(filename, D)
        
    case 'run9'                 % 4.9
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_22.txt','sc2_prediction_17.txt','sc2_verbGeneration_12.txt', 'sc2_romanceMovie_1.txt', 'sc2_visualSearch_17.txt', 'sc2_respAlt_19.txt', 'sc2_spatialNavigation_12.txt', 'sc2_landscapeMovie_1.txt', 'sc2_spatialMap_20.txt', 'sc2_nBackPic_18.txt', 'sc2_rest_11.txt', 'sc2_actionObservation_12.txt','sc2_mentalRotation_19.txt','sc2_emotionProcess_17.txt', 'sc2_motorSequence_20.txt', 'sc2_ToM_13.txt', 'sc2_natureMovie_1.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run9.txt');
        dsave(filename, D)
        
    case 'run10'                % 4.10
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_23.txt','sc2_prediction_18.txt','sc2_verbGeneration_13.txt', 'sc2_romanceMovie_2.txt', 'sc2_visualSearch_18.txt', 'sc2_respAlt_20.txt', 'sc2_spatialNavigation_13.txt', 'sc2_landscapeMovie_2.txt', 'sc2_spatialMap_21.txt', 'sc2_nBackPic_19.txt', 'sc2_rest_12.txt', 'sc2_actionObservation_13.txt','sc2_mentalRotation_20.txt','sc2_emotionProcess_18.txt', 'sc2_motorSequence_21.txt', 'sc2_ToM_14.txt', 'sc2_natureMovie_2.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run10.txt');
        dsave(filename, D)
        
    case 'run11'                % 4.11
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_24.txt','sc2_prediction_19.txt','sc2_verbGeneration_14.txt', 'sc2_romanceMovie_3.txt', 'sc2_visualSearch_19.txt', 'sc2_respAlt_21.txt', 'sc2_spatialNavigation_14.txt', 'sc2_landscapeMovie_3.txt', 'sc2_spatialMap_22.txt', 'sc2_nBackPic_20.txt', 'sc2_rest_13.txt', 'sc2_actionObservation_14.txt','sc2_mentalRotation_21.txt','sc2_emotionProcess_19.txt', 'sc2_motorSequence_22.txt', 'sc2_ToM_15.txt', 'sc2_natureMovie_3.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run11.txt');
        dsave(filename, D)
        
    case 'run12'                % 4.12
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_25.txt','sc2_prediction_20.txt','sc2_verbGeneration_15.txt', 'sc2_romanceMovie_4.txt', 'sc2_visualSearch_20.txt', 'sc2_respAlt_22.txt', 'sc2_spatialNavigation_15.txt', 'sc2_landscapeMovie_4.txt', 'sc2_spatialMap_23.txt', 'sc2_nBackPic_21.txt', 'sc2_rest_14.txt', 'sc2_actionObservation_15.txt','sc2_mentalRotation_22.txt','sc2_emotionProcess_20.txt', 'sc2_motorSequence_23.txt', 'sc2_ToM_16.txt', 'sc2_natureMovie_4.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run12.txt');
        dsave(filename, D)
        
    case 'run13'                % 4.13
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_26.txt','sc2_prediction_21.txt','sc2_verbGeneration_16.txt', 'sc2_romanceMovie_5.txt', 'sc2_visualSearch_21.txt', 'sc2_respAlt_23.txt', 'sc2_spatialNavigation_16.txt', 'sc2_landscapeMovie_5.txt', 'sc2_spatialMap_24.txt', 'sc2_nBackPic_22.txt', 'sc2_rest_15.txt', 'sc2_actionObservation_16.txt','sc2_mentalRotation_23.txt','sc2_emotionProcess_21.txt', 'sc2_motorSequence_24.txt', 'sc2_ToM_17.txt', 'sc2_natureMovie_5.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run13.txt');
        dsave(filename, D)
        
    case 'run14'                % 4.14
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_27.txt','sc2_prediction_22.txt','sc2_verbGeneration_17.txt', 'sc2_romanceMovie_6.txt', 'sc2_visualSearch_22.txt', 'sc2_respAlt_24.txt', 'sc2_spatialNavigation_17.txt', 'sc2_landscapeMovie_6.txt', 'sc2_spatialMap_25.txt', 'sc2_nBackPic_23.txt', 'sc2_rest_16.txt', 'sc2_actionObservation_17.txt','sc2_mentalRotation_24.txt','sc2_emotionProcess_22.txt', 'sc2_motorSequence_25.txt', 'sc2_ToM_18.txt', 'sc2_natureMovie_6.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run14.txt');
        dsave(filename, D)
        
    case 'run15'                % 4.15
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_28.txt','sc2_prediction_23.txt','sc2_verbGeneration_18.txt', 'sc2_romanceMovie_7.txt', 'sc2_visualSearch_23.txt', 'sc2_respAlt_25.txt', 'sc2_spatialNavigation_18.txt', 'sc2_landscapeMovie_7.txt', 'sc2_spatialMap_26.txt', 'sc2_nBackPic_24.txt', 'sc2_rest_17.txt', 'sc2_actionObservation_18.txt','sc2_mentalRotation_25.txt','sc2_emotionProcess_23.txt', 'sc2_motorSequence_26.txt', 'sc2_ToM_19.txt', 'sc2_natureMovie_7.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run15.txt');
        dsave(filename, D)
        
    case 'run16'                % 4.16
        taskName = {'CPRO','prediction','verbGeneration2','romanceMovie','visualSearch2','respAlt','spatialNavigation2','landscapeMovie','spatialMap','nBackPic2','rest2','actionObservation2','mentalRotation','emotionProcess','motorSequence2','ToM2','natureMovie'}';
        taskFile = {'sc2_CPRO_29.txt','sc2_prediction_24.txt','sc2_verbGeneration_19.txt', 'sc2_romanceMovie_8.txt', 'sc2_visualSearch_24.txt', 'sc2_respAlt_26.txt', 'sc2_spatialNavigation_19.txt', 'sc2_landscapeMovie_8.txt', 'sc2_spatialMap_27.txt', 'sc2_nBackPic_25.txt', 'sc2_rest_18.txt', 'sc2_actionObservation_19.txt','sc2_mentalRotation_26.txt','sc2_emotionProcess_24.txt', 'sc2_motorSequence_27.txt', 'sc2_ToM_20.txt', 'sc2_natureMovie_8.txt'}';
        taskFunction = {'sc2_run_CPRO','sc2_run_prediction','sc2_run_verbGeneration','sc2_run_romanceMovie','sc2_run_visualSearch','sc2_run_respAlt','sc2_run_spatialNavigation','sc2_run_landscapeMovie','sc2_run_spatialMap','sc2_run_nBackPic','sc2_run_rest','sc2_run_actionObservation','sc2_run_mentalRotation','sc2_run_emotionProcess','sc2_run_motorSequence','sc2_run_ToM','sc2_run_natureMovie'}';
        D.startTime = startTime_all;
        D.endTime = endTime_all;
        a = randperm(length(taskName));
        D.taskName = taskName(a);
        D.taskFile = taskFile(a);
        D.taskFunction = taskFunction(a);
        D.instructTime = repmat(instructTime,17,1);
        D.taskNum = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17];
        
        filename = fullfile(rootDir, '/sc2_run16.txt');
        dsave(filename, D)
        
    case 'runPreScan'           % 5.1
        D.taskName = {'visualSearch','CPRO','actionObservation','respAlt'}';
        D.taskFile = { 'sc2_visualSearch_4.txt','sc2_CPRO_2.txt','sc2_actionObservation_5.txt','sc2_respAlt_2.txt'}';
        D.taskFunction = {'sc2_run_visualSearch', 'sc2_run_CPRO','sc2_run_actionObservation','sc2_run_respAlt'}';
        D.startTime = [0;35;70;105];
        D.endTime = [35;70;105;140];
        D.instructTime = repmat(instructTime,4,1);
        D.taskNum = [1;2;3;4];
        
        filename = fullfile(rootDir, '/sc2_runPreScan.txt');
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
        
    case 'run_test'
        taskName = {'natureMovie'}';
        taskFile={'sc2_natureMovie_9.txt'}';
        taskFunction = {'sc2_run_natureMovie'}';
        D.startTime = [0];
        D.endTime = [35];
        D.taskName = taskName;
        D.taskFile = taskFile;
        D.taskFunction = taskFunction;
        D.instructTime = repmat(instructTime,1,1);
        D.taskNum = [1];
        
        filename = fullfile(rootDir, '/sc2_run_test.txt');
        dsave(filename, D)
        
    case 'run_restingState'
        taskName = {'restingState'}';
        taskFile={'sc2_restingState_1.txt'}';
        taskFunction = {'sc2_run_rest'}';
        D.startTime = [6];
        D.endTime = [601];
        D.taskName = taskName;
        D.taskFile = taskFile;
        D.taskFunction = taskFunction;
        D.instructTime = repmat(instructTime,1,1);
        D.taskNum = [1];
        
        filename = fullfile(rootDir, '/sc2_run_restingState.txt');
        dsave(filename, D)
        
    case 'make_all_files'
        sc2_make_runFile('run_verbGeneration')
        sc2_make_runFile('run_spatialNavigation')
        sc2_make_runFile('run_visualSearch')
        sc2_make_runFile('run_nBackPic')
        sc2_make_runFile('run_ToM')
        sc2_make_runFile('run_actionObservation')
        sc2_make_runFile('run_motorSequence')
        sc2_make_runFile('run_prediction')
        sc2_make_runFile('run_mentalRotation')
        sc2_make_runFile('run_CPRO')
        sc2_make_runFile('run_respAlt')
        sc2_make_runFile('run_spatialMap')
        sc2_make_runFile('run_emotionProcess')
        sc2_make_runFile('runResp1')
        sc2_make_runFile('runResp2')
        sc2_make_runFile('runResp3')
        sc2_make_runFile('runResp4')
        sc2_make_runFile('runPrac1')
        sc2_make_runFile('runPrac2')
        sc2_make_runFile('run1')
        sc2_make_runFile('run2')
        sc2_make_runFile('run3')
        sc2_make_runFile('run4')
        sc2_make_runFile('run5')
        sc2_make_runFile('run6')
        sc2_make_runFile('run7')
        sc2_make_runFile('run8')
        sc2_make_runFile('run9')
        sc2_make_runFile('run10')
        sc2_make_runFile('run11')
        sc2_make_runFile('run12')
        sc2_make_runFile('run13')
        sc2_make_runFile('run14')
        sc2_make_runFile('run15')
        sc2_make_runFile('run16')
        sc2_make_runFile('runPreScan')
        sc2_make_runFile('runPostScan')
        sc2_make_runFile('run_test')
        
    otherwise
        disp('there is no such case.')
        
end