function [T, score] = sc1_run_nBackPic(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% N-Back (Picture) Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('N-back (picture) task! \n\n Use your RIGHT hand \n\n Press "%s" when the picture displayed \n\n matches the one displayed two pictures ago',keyNames{3}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('N-back (picture) task! \n\n Use your RIGHT hand \n\n Press "%s" when the picture displayed \n\n matches the one displayed two pictures ago \n\n %s',keyNames{3},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of Trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;

%% Begin Experimental Loop
for trial = 1:numTrials,
    
    % Load image
    imgDir = T.imgFile;
    file = T.imgFile(trial);
    img = imread(char(file));
    imageDisplay = Screen('MakeTexture', screen.window, img);
    
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
    
    % Set up variables
    T.possCorr(trial,1) = 0;
    T.rt(trial,1) = 0;
    T.falseID(trial,1) = 0;
    T.numCorr(trial,1) = 0;
    T.numTrial(trial,1) = trial;
    T.respMade(trial,1) = respMade;
    T.possFalse(trial,1) = 0;
    
    % Determine feedback
    if (trial == 1 || trial == 2),
        T.possFalse(trial,1) = 1;
    end
    if trial >= 3,
        if strcmpi(file, imgDir(trial-2)) == 1
            T.possCorr(trial, 1) = 1;
        end
    end
    if trial >= 3,
        if strcmpi(file, imgDir(trial-2)) == 0,
            T.possFalse(trial,1) = 1;
        end
    end

    % Start timer before display
    t2 = GetSecs;
    
    % Show the image
    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
    Screen('Flip', screen.window);
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(1);
        checkTR(screen);
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && keyCode(screen.three))
            if keyCode(screen.three)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade=true;
            end
            checkTR(screen);
            
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if (trial == 1 || trial == 2),
                if respMade,
                    T.falseID(trial,1) = 1;
                    % Display incorrect
                    Screen('DrawTexture', screen.window, imageDisplay, [], pos);
                    makeSquare(screen, numCorr)
                end
            end
            % Match
            if trial >= 3,
                if strcmpi(file, imgDir(trial-2)) == 1
                    if respMade,
                        % Give feedback
                        % Display correct
                        numCorr = 1;
                        Screen('DrawTexture', screen.window, imageDisplay, [], pos);
                        makeSquare(screen, numCorr)
                        T.numCorr(trial, 1) = numCorr;
                    end
                end
            end
            % No match
            if trial >= 3,
                if strcmpi(file, imgDir(trial-2)) == 0,
                    if respMade,
                        T.falseID(trial,1) = 1;
                        Screen('DrawTexture', screen.window, imageDisplay, [], pos);
                        makeSquare(screen, numCorr)
                    end
                end
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    T.respMade(trial,1) = respMade;
end

% Calculate feedback score
score = round((sum(T.numCorr)*100)/sum(T.possCorr) - sum(T.falseID)*50/sum(T.possFalse));