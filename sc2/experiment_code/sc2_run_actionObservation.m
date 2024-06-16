function [T, score] = sc2_run_actionObservation(screen,keyNames,T)

global TRreal timeOfTR;

% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Action Observation Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

% Display Instructions

if (nargin < 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, 'Action Observation Task! \n\n Watch the following movies', ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin < 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Action Observation Task! \n\n Watch the following movies \n\n %s',keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Read in Movies

movieList = importdata(char(T.movFile(1))); % read in stimuli

% Number of Trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;
%% Begin experimental loop

for trial = 1:numTrials,
    
    moviename = char(movieList(trial)); % full path
    
    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end
    
    % Start the trial
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    T.numTrial(trial,1) = trial;
    
    % Open movie file:
    [movie, movieDur,fps, ~, ~] = Screen('OpenMovie', screen.window, moviename);
    framecount=movieDur*fps; % estimate framecount instead of querying it (faster)
    
    % Play Movie
    Screen('PlayMovie', movie, 1, 0, 1.0);
    
    % Set up some variables
    rejectplayback=0; 
    
    % Playback loop: Runs until end of movie or keypress:
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(trial);   
        
        checkTR(screen);
        
        % Wait for next movie frame, retrieve texture handle to it
        [tex] = Screen('GetMovieImage', screen.window, movie);
        
        % only draw to screen if tex is valid
        if tex~=-1,
            
            % Draw the new texture immediately to screen:
            Screen('DrawTexture', screen.window, tex);
            
            % Update display:
            Screen('Flip', screen.window);
            
            % Release texture:
            Screen('Close', tex);
        else
            DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
            Screen('Flip', screen.window);
        end
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
    checkTR(screen);
    WaitSecs(1.0)
    
    % Stop movie playback 
    droppedcount = Screen('PlayMovie', movie, 0, 0, 0);
    
    if (droppedcount > 0.2*framecount)
        %Over 20% of all frames skipped? Playback problems! We reject this playback...
        rejectplayback=1;
    end;
    
    % Close movie:
    Screen('CloseMovie', movie);
    
    %Print out playback result:
    if (rejectplayback==0)
        fprintf('Playback valid \n');
    end;
    
    if (rejectplayback==1)
        fprintf('Playback should be rejected. Too many skips in movie playback \n');
    end; 
end

% Give feedback
score = 'Good Job!';
