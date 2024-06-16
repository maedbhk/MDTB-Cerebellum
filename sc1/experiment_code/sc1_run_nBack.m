function [T, score] = sc1_run_nBack(screen,keyNames,T)

global TRreal timeOfTR;

% N-Back (Letter) Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

% Maedbh King (November 2015)

%% Display Instructions

if (nargin<3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('N-back (letter) task! \n\n Use your LEFT hand \n\n Press "%s" when the letter displayed \n\n matches the one displayed two letters ago',keyNames{2}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return
elseif (nargin<3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('N-back (letter) task! \n\n Use your LEFT hand \n\n Press "%s" when the letter displayed \n\n matches the one displayed two letters ago \n\n %s',keyNames{2},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return
end;

% Define variables
letterList = T.letter;

% Number of Trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;
%TRtimereal = GetSecs;

%% Begin experimental loop
for trial = 1:numTrials,
    
    letter = letterList(trial);
    
    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end;
    
    % Before trial starts
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    %fprintf('newTRtime: %f\n',TRtimereal-t0);
    
    % Set up counter
    respMade = false;
    rt = 0;
    numCorr = 0;
    falseID = 0;
    
    % Set up variables
    T.possCorr(trial,1) = 0;
    T.possFalse(trial,1) = 0;
    T.falseID(trial,1) = 0;
    T.numCorr(trial,1) = numCorr;
    T.numTrial(trial,1) = trial;
    T.respMade(trial,1) = respMade;
    T.rt(trial,1) = 0;
    
    % Determine feedback
    if (trial == 1 || trial == 2),
        T.possFalse(trial,1) = 1;
    end
    if trial >= 3,
        if strcmpi(letterList(trial), letterList(trial-2)) == 1,
            T.possCorr(trial, 1) = 1;
        end
    end
    if trial >= 3,
        if strcmpi(letterList(trial), letterList(trial-2)) == 0,
            T.possFalse(trial,1) = 1;
        end
    end
    
    % Start timer before display
    t2 = GetSecs;
    
    % Display letter
    DrawFormattedText(screen.window, char(letter), 'center', 'center', screen.black);
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
            if (trial == 1 || trial == 2),
                if respMade,
                    numCorr=0;
                    DrawFormattedText(screen.window, char(letter), 'center', 'center', screen.black);
                    makeSquare(screen, numCorr)
                    T.falseID(trial, 1) = falseID+1;
                end
            end
            % Match
            if trial >= 3,
                if strcmpi(letterList(trial), letterList(trial-2)) == 1
                    if respMade,
                        % Give feedback
                        % Display correct
                        numCorr = numCorr+1;
                        DrawFormattedText(screen.window, char(letter), 'center', 'center', screen.black);
                        makeSquare(screen, numCorr)
                        T.numCorr(trial, 1) = numCorr;
                    end
                end
            end
            % No match
            if trial >= 3,
                % Feedback variables
                if strcmpi(letterList(trial), letterList(trial-2)) == 0,
                    if respMade,
                        numCorr=0;
                        T.falseID(trial,1) = 1;
                        DrawFormattedText(screen.window, char(letter), 'center', 'center', screen.black);
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