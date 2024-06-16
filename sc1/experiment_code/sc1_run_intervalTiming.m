function [T, score] = sc1_run_intervalTiming(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Interval Timing Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin < 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Interval Timing Task! \n\n Use your RIGHT hand \n\n Press "%s" when you hear long tones \n\n Otherwise press "%s"',keyNames{3},keyNames{4}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return
elseif (nargin < 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Interval Timing Task! \n\n Use your RIGHT hand \n\n Press "%s" when you hear long tones \n\n Otherwise press "%s" \n\n %s',keyNames{3},keyNames{4},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return
end;

% Set up variables
Fs = 50000;           % Samples per second
toneFreqLow  = 1000;  % Tone frequency, in Hertz

%Number of Trials
numTrials = length(T.startTime);

DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
Screen('Flip', screen.window);

% Start the trial
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
    
    % Set up counter
    respMade = false;
    rt = 0;
    
    % Set up variables
    T.rt(trial,1) = 0;
    T.respMade(trial,1) = 0;
    T.numCorr(trial,1) = 0;
    T.numTrial(trial,1) = trial;
     T.numErr(trial,1) = 0;
    
    % Start timer before display
    t2 = GetSecs;
    
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window)
    
    % Play sound
    yLow  = sin(linspace(0, T.interval(trial)*toneFreqLow*2*pi, round(T.interval(trial)*Fs))); %Lower frequency sound handle
    sound(yLow, Fs);
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(trial);
        checkTR(screen);
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && (keyCode(screen.three) || keyCode(screen.four))) 
            if keyCode(screen.three)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade=true;
                response = 1;
            elseif keyCode(screen.four)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade=true;
                response = 2;
            end
            
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if T.trialType(trial) == 1, % long
                if (response==1),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % correct
                    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
                    makeSquare(screen, numCorr)
                elseif response==2,
                    numCorr=0;
                    T.numErr(trial,1) = 1;
                    % incorrect
                    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
                    makeSquare(screen, numCorr)
                end
            end
            
            if T.trialType(trial) == 2, % short
                if response==2,
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % correct
                    % Draw fixation cross
                    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
                    makeSquare(screen, numCorr)
                elseif (response==1),
                    numCorr=0;
                    T.numErr(trial,1) = 1;
                    % incorrect
                    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
                    makeSquare(screen, numCorr)
                end
            end
        end
    end
    
    T.respMade(trial,1) = respMade;
end

% Calculate feedback score
score = round(sum((T.numCorr))*100/length(T.numCorr));