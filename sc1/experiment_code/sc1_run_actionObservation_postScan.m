function [T, score] = sc1_run_actionObservation_postScan(screen,keyNames,T)
global TRreal timeOfTR;

% Action Observation Task
if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, 'Action Observation Test! \n\n Identify the familiar knots', ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin<3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Action Observation Test! \n\n Identify the familiar knots \n\n %s', keyNames{5}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

%% Read in Movies

movieList = importdata(char(T.movFile(1))); % read in movie
questionList = importdata(char(T.question(1))); % read in question

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
    
    % Set up counter
    respMade = false;
    rt = 0;
    numCorr = 0;
    response = 0;
    
    % Set up variables
    T.rt(trial,1) = 0;
    T.numCorr(trial,1) = 0;
    T.numTrial(trial,1) = trial;
    T.numErr(trial,1) = 0;
    T.respMade(trial,1) = 0;
    
    % Open movie file:
    [movie, ~, ~, ~, ~] = Screen('OpenMovie', screen.window, moviename);
    
    % Play Movie
    Screen('PlayMovie', movie, 1, 0, 1.0);
    
    % Start playback engine:
    Screen('PlayMovie', movie, 1);
    
    % Start timer before display
    t2 = GetSecs;
    
    % Playback loop: Runs until end of movie or keypress:
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(1);
        
        checkTR(screen);
        
        % Wait for next movie frame, retrieve texture handle to it
        tex = Screen('GetMovieImage', screen.window, movie);
        
        % Draw the new texture immediately to screen:
        Screen('DrawTexture', screen.window, tex);
        
        % Draw question to screen
        DrawFormattedText(screen.window, char(questionList(trial)), screen.width/2.8, screen.height/1.43, screen.black);
        
        % Update display:
        Screen('Flip', screen.window);
        
        % Release texture:
        Screen('Close', tex);
        
        % Check the keyboard.
        [isPressed,~,keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end
        if (~respMade && isPressed && (keyCode(screen.three) || keyCode(screen.four)))
            if keyCode(screen.three)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 1;
            elseif keyCode(screen.four)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 2;
            end
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if T.trialType(trial)==1,
                if (response==1),
                    numCorr=1;
                    T.numCorr(trial,1) = 1;
                     makeSquare(screen, numCorr)
                elseif (response==2),
                    T.numErr(trial,1) = 1;
                     makeSquare(screen, numCorr)
                end
            end
            if T.trialType(trial)==0,
                if (response==1),
                    T.numErr(trial,1) = 1;
                     makeSquare(screen, numCorr)
                elseif (response==2),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                     makeSquare(screen, numCorr)
                end
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    WaitSecs(1.0)
    
    T.respMade(trial,1) = respMade;
end;

%Close down movie
% Stop playback:
Screen('PlayMovie', movie, 0);

% Close movie:
Screen('CloseMovie', movie);

% Give feedback
score = 'good job';