function [T, score] = sc1_run_verbGeneration_postScan(screen,keyNames,T)
global TRreal timeOfTR;

% Verb Generation Task
if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, 'Verb Generation test! \n\n GENERATE verbs aloud', ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin<3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Verb Generation test! \n\n GENERATE verbs aloud \n\n %s',keyNames{5}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of Trials
numTrials = length(T.startTime);

% Before trial starts
t0 = GetSecs;

%% Begin experimental loop

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

    % Draw word
    DrawFormattedText(screen.window, char(T.word(trial)), 'center', 'center', screen.black);
    Screen('Flip', screen.window);

    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(1);
        checkTR(screen);
        % Check the keyboard.
        [~, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboards
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

% Give feedback
score = 'Good Job!';