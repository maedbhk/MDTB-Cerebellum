function [T, score] = sc1_run_spatialNavigation(screen,P,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Spatial Navigation Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if nargin<3 && isempty(P{2}),
    DrawFormattedText(screen.window,sprintf('Spatial Navigation Task! \n\n Imagine walking around your childhood home \n\n Start in the %s - end in the %s \n\n Focus on the fixation cross',P{1}.startNav{1},P{1}.endNav{1}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return
elseif nargin<3 && ~isempty(P{2}),
    DrawFormattedText(screen.window,sprintf('Spatial Navigation Task! \n\n Imagine walking around your childhood home \n\n Start in the %s - end in the %s \n\n Focus on the fixation cross \n\n %s',P{1}.startNav{1},P{1}.endNav{1},P{2}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of Trials
numTrials = length(T.startTime);

% Set up variables
% Fs = 50000;           % Samples per second
% toneFreqLow  = 1000;  % Tone frequency, in Hertz
% nSeconds = .4;        % Duration of the tone

% Load stimuli
% yLow  = sin(linspace(0, nSeconds*toneFreqLow*2*pi, round(nSeconds*Fs))); %Lower frequency sound handle

% Before trial starts
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
    
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
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
end

% sound(yLow, Fs); % Open eyes

score = 'Good Job!';