function [T, score] = sc2_run_prediction(screen,keyNames,T)

global TRreal timeOfTR;

% sc2 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Prediction Task

% Input variables:
% screen - output arg from 'sc2_psychtoolbox_config'
% keyNames - output arg from 'sc2_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Prediction Task! \n\n Use your LEFT hand \n\n       "%s" = Not Meaningful \n\n "%s" = Meaningful',keyNames{1},keyNames{2}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Prediction Task! \n\n Use your LEFT hand \n\n       "%s" = Not Meaningful \n\n "%s" = Meaningful \n\n %s',keyNames{1},keyNames{2},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of trials
numTrials = length(T.startTime);

% Assign new structure
S=T; 

% Start the trial
t0 = GetSecs;

%% Begin Experimental Loop
for trial = 1:numTrials,

    A=getrow(S,trial); 
    
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
    
    % draw word1 to screen
    DrawFormattedText(screen.window,char(A.word1),'center','center',screen.black);
    Screen('Flip', screen.window);
    
    % length of word1 on screen
    while GetSecs-t0 <= T.startTime(trial)+A.word1Dur;
        checkTR(screen);
    end;

    % draw word2 to screen
    DrawFormattedText(screen.window,char(A.word2),'center','center',screen.black);
    Screen('Flip', screen.window);
    
    % length of word2 on screen
    while GetSecs-t0 <= T.startTime(trial)+A.word2Dur;
        checkTR(screen);
    end;
    
    % draw word3 to screen
    DrawFormattedText(screen.window,char(A.word3),'center','center',screen.black);
    Screen('Flip', screen.window);
    
       % length of word3 on screen
    while GetSecs-t0 <= T.startTime(trial)+A.word3Dur;
        checkTR(screen);
    end;
    
    % draw word4 to screen
    DrawFormattedText(screen.window,char(A.word4),'center','center',screen.black);
    Screen('Flip', screen.window);
    
    % length of word4 on screen
    while GetSecs-t0 <= T.startTime(trial)+A.word4Dur;
        checkTR(screen);
    end;
    
    % draw target word to screen 
    DrawFormattedText(screen.window,char(A.word5),'center','center',screen.black);
    Screen('Flip', screen.window);
    
    % length of target word on screen
    while GetSecs-t0 <= T.startTime(trial)+A.word5Dur;
        checkTR(screen);
    end;
    
    % draw question to screen
    DrawFormattedText(screen.window,char(A.question),'center','center',screen.black);
    Screen('Flip', screen.window);
   
    % Start timer before display
    t2 = GetSecs;
    
    while GetSecs-t0 <= T.startTime(trial)+A.questionDur;
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && (keyCode(screen.one) || keyCode(screen.two)))
            if keyCode(screen.two)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 2;
            elseif keyCode(screen.one)
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 1;
            end
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            DrawFormattedText(screen.window,char(A.question),'center','center',screen.black);
            if response~=A.trialType,
                numCorr=1;
                T.numCorr(trial,1)=numCorr;
                makeSquare(screen,numCorr)
            else
                T.numCorr(trial,1)=numCorr;
                makeSquare(screen,numCorr)
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center','center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    T.respMade(trial,1) = respMade;
end

% Determine feedback 
score = round(sum((T.numCorr))*100/length(T.numCorr));