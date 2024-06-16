function [T, score] = sc2_run_CPRO(screen,keyNames,T)

global TRreal timeOfTR;

%% sc2
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Concrete Permuted Rule Operations Task

% Input variables:
% screen - output arg from 'sc2_psychtoolbox_config'
% keyNames - output arg from 'sc2_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Rules Task! \n\n Use BOTH hands \n\n "%s" = 1 \n\n "%s" = 2 \n\n "%s" = 3 \n\n "%s" = 4 \n\n',keyNames{1},keyNames{2},keyNames{3},keyNames{4}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Rules Task! \n\n Use BOTH hands \n\n "%s" = 1 \n\n "%s" = 2 \n\n "%s" = 3 \n\n "%s" = 4 \n\n %s',keyNames{1},keyNames{2},keyNames{3},keyNames{4},keyNames{5}),...
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
    
    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end;
    
    % Start the trial
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    
    % Set up counter
    respMade=false;
    rt=0;
    numCorr=0;
    numErr=0;
    response=0;
    
    % Set up variables
    T.rt(trial,1)=0;
    T.numCorr(trial,1)=0;
    T.numErr(trial,1)=0;
    T.numTrial(trial,1)=trial;
    T.respMade(trial,1)=respMade;
    
    % Draw instructions to screen
    DrawFormattedText(screen.window, char(T.Logic(trial)),'center',screen.yCenter/1.20, screen.black);
    DrawFormattedText(screen.window, char(T.Sensory(trial)),'center',screen.yCenter, screen.black);
    DrawFormattedText(screen.window, char(T.motorMap(trial)),'center',screen.yCenter/.85, screen.black);
    Screen('Flip', screen.window);
    
    % Length of instructions on screen
    while GetSecs-t0 <= T.startTime(trial)+T.instructDur(trial),
        checkTR(screen);
    end;
    
     % Draw delay one to screen (fixation cross)
    DrawFormattedText(screen.window, '+','center','center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    % Length of time that delay one is on screen
     while GetSecs-t0 <= T.startTime(trial)+T.delay1Dur(trial),
        checkTR(screen);
    end;
    
    % Draw trial one to screen
    makeRectangle(screen,T.pos1(trial),T.col1(trial),1);
    
    % Length of time that trial one is on screen
    while GetSecs-t0 <= T.startTime(trial)+T.trial1Dur(trial),
        checkTR(screen);
    end;
    
    % Draw delay one to screen (fixation cross)
    DrawFormattedText(screen.window, '+','center','center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    % Length of time that delay one is on screen
     while GetSecs-t0 <= T.startTime(trial)+T.delay2Dur(trial),
        checkTR(screen);
    end;

    % Start timer before display
    t2 = GetSecs;
    
    % Draw trial 2 to screen 
    makeRectangle(screen,T.pos2(trial),T.col2(trial),1);
    
    % Length of trial two on screen (and gather response)
    while GetSecs-t0 <= T.startTime(trial)+T.trial2Dur(trial),
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey),
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && (keyCode(screen.one) || keyCode(screen.two) || keyCode(screen.three) || keyCode(screen.four))),
            if keyCode(screen.one),
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 1;
            elseif keyCode(screen.two),
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 2;
            elseif keyCode(screen.three),
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 3;
            elseif keyCode(screen.four),
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 4;
            end
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if T.motorResp(trial)==response,
                numCorr=1; 
                T.numCorr(trial,1)=numCorr;
                 % Give feedback
                 % Display correct
                makeRectangle(screen,T.pos2(trial),T.col2(trial),0);
                makeSquare(screen,numCorr)
            elseif T.motorResp(trial)~=response,
                T.numErr(trial,1)=numErr+1;
                % Give feedback
                % Display incorrect
                makeRectangle(screen,T.pos2(trial),T.col2(trial),0);
                makeSquare(screen,numCorr)
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center','center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    T.respMade(trial,1) = respMade;
end

score = round(sum((T.numCorr))*100/length(T.numCorr));
