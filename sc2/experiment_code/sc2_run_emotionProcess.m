function [T, score] = sc2_run_emotionProcess(screen,keyNames,T)

global TRreal timeOfTR;

% sc2
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Emotion Processing Task

% Input variables:
% screen - output arg from 'sc2_psychtoolbox_config'
% keyNames - output arg from 'sc2_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

% No feedback is given on this task

%% Display Instructions

if (nargin < 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Emotion Processing Task! \n\n Use your RIGHT hand \n\n   "%s" = Sad/Slow \n\n     "%s" = Happy/Fast',keyNames{3},keyNames{4}),....
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin < 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Emotion Processing Task! \n\n  Use your RIGHT hand \n\n  "%s" = Sad/Slow \n\n     "%s" = Happy/Fast \n\n %s',keyNames{3},keyNames{4},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

%% Read in Movies

movieList = importdata(char(T.movFile(1))); % read in stimuli
movieList=strtrim(movieList); % remove leading blank spaces

% Number of Trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;
%% Begin experimental loop

for trial = 1:numTrials,
    
    movieName = char(movieList(trial+1)); % full path
    
    checkTR(screen); % TEST
    
    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end
    
    % Start the trial
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    T.numTrial(trial,1) = trial;
    
    % Set up counter
    respMade = false;
    rt = 0;
    numCorr = 0;
    response = 0;
    
    % Set up variables
    T.rt(trial,1) = 0;
    T.numCorr(trial,1) = numCorr;
    T.numErr(trial,1) = 0;
    T.numTrial(trial,1) = trial;
    T.respMade(trial,1) = respMade;
    
    % Open movie file:
    [movie,movieDur,fps, ~, ~] = Screen('OpenMovie', screen.window, movieName);
    framecount=movieDur*fps; % estimate framecount instead of querying it (faster)
    
    % Play Movie
    Screen('PlayMovie', movie, 1, 0, 1.0);
    
    % Set up some variables
    rejectplayback=0;
    
    % Start timer before display
    t2 = GetSecs;
    
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
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        
        if (~respMade && isPressed && (keyCode(screen.four) || keyCode(screen.three)))
            if keyCode(screen.four)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 1;
            elseif keyCode(screen.three)
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 2;
            end
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if T.trialType(trial,1)==1, % correct response is happy or fast
                % correct
                if response==1,
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
%                     makeSquare(screen,numCorr)
                    % incorrect
                elseif response==2,
                    T.numErr(trial,1) = 1;
%                     makeSquare(screen,numCorr)
                end
            end
            if T.trialType(trial,1)==2, % correct response is sad or slow
                % corr
                if response==1,
                    T.numErr(trial,1) = 1;
%                     makeSquare(screen,numCorr)
                elseif response==2,
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
%                     makeSquare(screen,numCorr)
                end
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);

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
    
    T.respMade(trial,1) = respMade;  
end

% Give feedback
score = round(sum((T.numCorr))*100/length(T.numCorr));