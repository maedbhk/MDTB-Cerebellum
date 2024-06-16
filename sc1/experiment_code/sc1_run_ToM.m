function [T, score] = sc1_run_ToM(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Theory of Mind Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Theory of Mind Task! \n\n Use your LEFT hand \n\n "%s" = false belief \n\n "%s" = true belief',keyNames{1},keyNames{2}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Theory of Mind Task! \n\n Use your LEFT hand \n\n "%s" = false belief \n\n "%s" = true belief \n\n %s',keyNames{1},keyNames{2},keyNames{5}),...
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
    
    if mod(trial,2),
        story = T.story{trial};
        question = T.question{trial};
    else
        story = T.story{trial};
        question = T.question{trial};
    end
    
    % Determine belief correctness
    if T.condition(trial)==1,
        valence = 'true';
    elseif T.condition(trial)==0,
        valence = 'false';
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
    response = 0;
    
    % Set up variables
    T.rt(trial,1) = 0;
    T.numCorr(trial,1) = 0;
    T.numErr(trial,1) = 0;
    T.respMade(trial,1) = respMade;
    T.numTrial(trial,1) = trial;
    
    % Load story
    textfid = fopen(story);
    lCounter = 1; % line counter
    while 1,
        tline = fgetl(textfid); % read line from text file.
        if ~ischar(tline), break, end
        Screen(screen.window, 'DrawText',tline,screen.width/7,screen.yCenter/1.5+lCounter*45,screen.black);
        lCounter = lCounter + 1;
    end
    fclose(textfid);
    Screen('Flip', screen.window);
    
    % Story Duration
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(1);
        checkTR(screen);
    end;
    
    % Load question
    textfid	= fopen(question);
    lCounter = 1;
    while 1
        tline = fgetl(textfid); % read line from text file.
        if ~ischar(tline), break, end
        Screen(screen.window, 'DrawText',tline,screen.width/4,screen.yCenter/1.5+lCounter*45,screen.black);
        lCounter = lCounter + 1;
    end
    fclose(textfid);
    Screen('Flip', screen.window);
    
    % Start timer before display
    t2 = GetSecs;
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(2);
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
            % Draw question to screen
            textfid	= fopen(question);
            lCounter = 1;
            while 1
                tline = fgetl(textfid); % read line from text file.
                if ~ischar(tline), break, end
                Screen(screen.window, 'DrawText',tline,screen.width/4,screen.yCenter/1.5+lCounter*45,screen.black);
                lCounter = lCounter + 1;
            end
            fclose(textfid);
            if strcmp(valence, 'true'),
                if (response==1),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    makeSquare(screen, numCorr)
                elseif (response==2),
                    % Give feedback
                    % Display incorrect
                    makeSquare(screen, numCorr)
                end
            end
            if strcmp(valence, 'false'),
                if (response==1),
                    % Give feedback
                    % Display incorrect
                    makeSquare(screen, numCorr)
                elseif (response==2),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
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
