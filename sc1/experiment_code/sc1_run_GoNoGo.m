function [T, score] = sc1_run_GoNoGo(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Go-No-Go Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Go/No-Go Task! \n\n Use your LEFT hand to identify POSITIVE words \n\n "%s" = Positive Word \n\n Ignore negative words',keyNames{2}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Go/No-Go Task! \n\n Use your LEFT hand to identify POSITIVE words \n\n "%s" = Positive Word \n\n Ignore negative words \n\n %s',keyNames{2}, keyNames{5}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;

%% Begin experimental loop
for trial = 1:numTrials,
    
    drawWord = char(T.word(trial));
    
    % Feedback variables
    T.possFalseID(trial,1) = 0;
    T.possCorr(trial,1) = 0;
    
    if T.trialType(trial) == 2,
        valence = 'positive';
        T.possCorr(trial,1) = 1;
    elseif T.trialType(trial) == 1,
        valence = 'negative';
        T.possFalseID(trial,1) = 1;
    end
    
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
    
    %Set up variables
    T.rt(trial,1) = 0;
    T.numTrial(trial,1) = trial;
    T.numCorr(trial,1) = 0;
    T.falseID(trial,1) = 0;
    T.respMade(trial,1) = respMade;
    
    t2 = GetSecs;
    
    % Draw the word
    DrawFormattedText(screen.window, drawWord, 'center', 'center', screen.black);
    Screen('Flip', screen.window);
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(1);
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboards
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && keyCode(screen.two))
            if keyCode(screen.two)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade=true;
            end
            
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if strcmp(valence, 'positive'),
                if respMade,
                    numCorr = numCorr+1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    DrawFormattedText(screen.window, drawWord, 'center', 'center', screen.black);
                    makeSquare(screen, numCorr)
                end
            end
            if strcmp(valence, 'negative'),
                if respMade,
                    T.falseID(trial,1) = 1;
                    % Give feedback
                    % Display incorrect
                    DrawFormattedText(screen.window, drawWord, 'center', 'center', screen.black);
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

score = round((sum(T.numCorr)*100)/sum(T.possCorr) - sum(T.falseID)*50/sum(T.possFalseID));
