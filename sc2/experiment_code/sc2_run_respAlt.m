function [T, score] = sc2_run_respAlt(screen,keyNames,T)

global TRreal timeOfTR;

% sc2 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Response Alternatives Memory Task

% Input variables:
% screen - output arg from 'sc2_psychtoolbox_config'
% keyNames - output arg from 'sc2_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Response Alternatives Task! \n\n Use BOTH hands \n\n "%s" = 1 \n\n "%s" = 2 \n\n "%s" = 3 \n\n "%s" = 4',keyNames{1},keyNames{2},keyNames{3},keyNames{4}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Response Alternatives Task! \n\n Use BOTH hands \n\n "%s" = 1 \n\n "%s" = 2 \n\n "%s" = 3 \n\n "%s" = 4 \n\n %s',keyNames{1},keyNames{2},keyNames{3},keyNames{4},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of trials
numTrials = length(T.startTime);

% Number of actions
action={'makeSquares','drawBorders','drawSignal'}; 

% create new target file structure
S=T; 

% Start the trial
t0 = GetSecs;

%% Begin Experimental Loop
for trial = 1:numTrials,
    
    A=[]; 
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
    T.penalty(trial,1)=0;
    
    % Draw original display (squares) to screen
    makeRespAltDisplay(screen,A,'action',action{1})
    
    % Draw green border around respAlts
    makeRespAltDisplay(screen,A,'action',action{2})
    
    % Flip all to screen
    Screen('Flip',screen.window);
    
    % length of resp alt options on screen
    while GetSecs-t0 <=T.startTime(trial)+A.trial1Dur;
        checkTR(screen);
    end;
    
    % Draw original display (squares) to screen
    makeRespAltDisplay(screen,A,'action',action{1})
    
    % Draw green border around respAlts
    makeRespAltDisplay(screen,A,'action',action{2})
    
    % Draw imperative signal
    makeRespAltDisplay(screen,A,'action',action{3})
    
    % Flip to screen
    Screen('Flip',screen.window);
    
    % length of imperative signal on screen
    while GetSecs-t0 <=T.startTime(trial)+A.imperSigDur;
        checkTR(screen);
    end
    
     % Draw original display (squares) to screen
    makeRespAltDisplay(screen,A,'action',action{1})
    
    % Draw green border around respAlts
    makeRespAltDisplay(screen,A,'action',action{2})
    
     % Flip to screen
    Screen('Flip',screen.window);

    % Start timer before display
    t2 = GetSecs;
    
    while GetSecs-t0 <= T.startTime(trial)+A.trial2Dur;
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && (keyCode(screen.one) || keyCode(screen.two))) || keyCode(screen.three) || keyCode(screen.four)
            if keyCode(screen.four)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 4;
            elseif keyCode(screen.three)
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 3;
            elseif keyCode(screen.two)
                t1  = GetSecs;
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
            % Draw original display (squares) to screen
            makeRespAltDisplay(screen,A,'action',action{1})
            % Draw green border around respAlts
            makeRespAltDisplay(screen,A,'action',action{2})
            if A.targPos==response, % correct
                numCorr=1; 
                T.numCorr(trial,1)=numCorr;
                % determine rt feedback 
                if rt>A.rtFeedback,
                  DrawFormattedText(screen.window, 'Too Slow!','center', screen.yCenter*1.2,screen.black);
                  makeSquare(screen,numCorr)
                  T.penalty(trial,1)=1;
                else
                    makeSquare(screen,numCorr)
                end
            else % incorrect            
                T.numErr(trial,1)=1; 
                if rt>A.rtFeedback,
                    DrawFormattedText(screen.window,'Too Slow!','center', screen.yCenter*1.2,screen.black);
                    makeSquare(screen,numCorr)
                    T.penalty(trial,1)=1;
                else
                    makeSquare(screen,numCorr)
                end
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window); 
    checkTR(screen)
    
    T.respMade(trial,1) = respMade;
end

score = round(sum((T.numCorr))*100/length(T.numCorr))-sum(T.penalty==1)*5;
