function [T, score] = sc1_run_affective(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Affective Processing Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Affective Processing Task! \n\n Use your LEFT hand \n\n "%s" = Unpleasant Images \n\n "%s" = Pleasant Images',keyNames{1},keyNames{2}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Affective Processing Task! \n\n Use your LEFT hand \n\n "%s" = Unpleasant Images \n\n "%s" = Pleasant Images \n\n %s',keyNames{1},keyNames{2},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;

%% Begin Experimental Loop
for trial = 1:numTrials,
    
    % Read image
    file = T.imgDir(trial);
    img = imread(char(file));
    imageDisplay = Screen('MakeTexture', screen.window, img);
    
    if strfind(char(file), 'unpleasant'),
        valence = 'unpleasant';
    else
        valence = 'pleasant';
    end
    
    % Calculate image position (center of the screen)
    imageSize = size(img);
    pos = [(screen.width-imageSize(2))/2 (screen.height-imageSize(1))/2 (screen.width+imageSize(2))/2 (screen.height+imageSize(1))/2];
    
    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end;
    
    % Start the trial
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    
    % Set up counter
    respMade = false;
    rt = 0;
    numCorr = 0;
    response = 0;
    
    % Set up variables
    T.rt(trial,1) = 0;
    T.numCorr(trial,1) = 0;
    T.numErr(trial,1) = 0;
    T.numTrial(trial,1) = trial;
    T.respMade(trial,1) = respMade;
    
    % Start timer before display
    t2 = GetSecs;
    
    % Show image
    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
    Screen('Flip', screen.window);
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(1);
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && (keyCode(screen.two) || keyCode(screen.one)))
            if keyCode(screen.two)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 1;
            elseif keyCode(screen.one)
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 2;
            end

            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if strcmp(valence, 'pleasant'),
                if response==1,
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
                    makeSquare(screen, numCorr)
                elseif response==2,
                    T.numErr(trial,1) = 1;
                    % Give feedback
                    % Display incorrect
                    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
                    makeSquare(screen, numCorr)
                end
            end
            if strcmp(valence, 'unpleasant'),
                if response==1,
                    T.numErr(trial,1) = 1;
                    % Give feedback
                    % Display incorrect
                    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
                    makeSquare(screen, numCorr)
                elseif response==2,
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
                    makeSquare(screen, numCorr)
                end
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    T.respMade(trial,1) = respMade;
end

score = round(sum((T.numCorr))*100/length(T.numCorr));
