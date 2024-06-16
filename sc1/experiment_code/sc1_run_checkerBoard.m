function [T, score] = sc1_run_checkerBoard(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Checkerboard Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, 'Checkerboard task! \n\n Pay attention to each image \n\n Focus on the fixation cross',...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Checkerboard task! \n\n Pay attention to each image \n\n Focus on the fixation cross \n\n %s',keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

%% Read in stimuli

% Number of trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;

%% Begin Experimental Loop
for trial = 1:numTrials,
    
    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end;
    
    % Start the trial
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    T.numTrial(trial,1) = trial; 
    %fprintf('newTRtime: %f\n',TRtimereal-t0);
    
    if ~mod(trial,2)
    % Load image
    file = T.imgDir(trial);
    img = imread(char(file));
    imageDisplay = Screen('MakeTexture', screen.window, img);
    
    % Calculate image position (center of the screen)
    imageSize = size(img);
    pos = [(screen.width-imageSize(2))/2 (screen.height-imageSize(1))/2 (screen.width+imageSize(2))/2 (screen.height+imageSize(1))/2];
   
    % Show the image
    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
    Screen('Flip', screen.window);
    
    else
        make_checkerBoard(screen)
    end
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(trial);
        checkTR(screen)
        % Check the keyboard.
        [~, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
end
% Close texture
Screen('Close', imageDisplay)

score = 'Good Job!';