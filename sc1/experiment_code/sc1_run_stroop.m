function [T,score] = sc1_run_stroop(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Stroop Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin<3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Stroop Task! \n\n Use BOTH hands to name the COLOUR of each word \n\n "%s" = Blue \n\n "%s" = Yellow \n\n "%s" = Green \n\n "%s" = Red',keyNames{1},keyNames{2},keyNames{3},keyNames{4}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin<3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Stroop Task! \n\n Use BOTH hands to name the COLOUR of each word \n\n "%s" = Blue \n\n "%s" = Yellow \n\n "%s" = Green \n\n "%s" = Red \n\n %s',keyNames{1},keyNames{2},keyNames{3},keyNames{4},keyNames{5}), ...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;

%% Begin experimental Loop
for trial = 1:numTrials,
    
    theColour = horzcat(T.R,T.G,T.B); 
    words = {'red','green','blue','yellow'};
    colour = words(T.colour); 
   
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen)
    end;
    
    % Before trial starts
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    
    % Set up counter
    respMade = false;
    rt = 0;
    response = 0;
    numCorr = 0;
    numErr = 0; 
    
    % Set up output variables
    T.numTrial(trial,1) = trial;
    T.rt(trial,1) = rt;
    T.numCorr(trial,1) = numCorr;
    T.numErr(trial,1) = numErr; 
    T.respMade(trial,1) = respMade;
    T.respMade(trial,1) = respMade; 

    % Start timer
    t2 = GetSecs;
    
    % Draw word
    DrawFormattedText(screen.window, char(T.word(trial)), 'center', 'center', theColour(trial,:));
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
        % Determine which keys were pressed
        if (~respMade && isPressed && (keyCode(screen.one) || keyCode(screen.two) || keyCode(screen.three) || keyCode(screen.four)))
            if keyCode(screen.one)
                response = 'blue';
                t1 = GetSecs;
                respMade=true;
                rt = t1-t2;
            elseif keyCode(screen.two)
                response = 'yellow';
                t1 = GetSecs;
                respMade=true;
                rt = t1-t2;
            elseif keyCode(screen.three)
                response = 'green';
                t1 = GetSecs;
                respMade=true;
                rt = t1-t2;
            elseif keyCode(screen.four)
                response = 'red';
                t1 = GetSecs;
                respMade=true;
                rt = t1-t2;
            end;
            
            %% Record data
            % Calculate rt
            T.rt(trial,1) = rt;
            if (respMade)
                DrawFormattedText(screen.window, char(T.word(trial)), 'center', 'center', theColour(trial,:));
                Screen('Flip', screen.window)
                
                % Give feedback
                if strcmp(response, colour(trial))
                    T.numCorr(trial,1) = numCorr+1;
                    numCorr = numCorr+1;
                    % Display correct
                    DrawFormattedText(screen.window, char(T.word(trial)), 'center', 'center', theColour(trial,:));
                    makeSquare(screen, numCorr)
                else
                    % Display incorrect
                    DrawFormattedText(screen.window, char(T.word(trial)), 'center', 'center', theColour(trial,:));
                    makeSquare(screen, numCorr)
                    T.numErr(trial,1) = numErr+1;
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

