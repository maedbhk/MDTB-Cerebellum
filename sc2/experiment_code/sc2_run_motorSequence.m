function [T,score] = sc2_run_motorSequence(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Motor Sequence Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin<3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Motor Sequence Task! \n\n Respond to number sequences with these keys \n\n "%s" = 1 \n\n "%s" = 2 \n\n "%s" = 3 \n\n "%s" = 4',keyNames{1},keyNames{2},keyNames{3},keyNames{4}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin<3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Motor Sequence Task! \n\n Respond to number sequences with these keys \n\n "%s" = 1 \n\n "%s" = 2 \n\n "%s" = 3 \n\n "%s" = 4 \n\n %s',keyNames{1},keyNames{2},keyNames{3},keyNames{4},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of trials
numTrials = length(T.startTime);

% Start the trial
t0 = GetSecs;

numResp = 6;
charXpos = [230 140 50 -40 -130 -210];

%% Begin Experimental Loop

for trial = 1:numTrials,
    
    % Determine pattern
    mov(trial,:) = [T.digit1(trial) T.digit2(trial) T.digit3(trial) T.digit4(trial) T.digit5(trial) T.digit6(trial)]; 

    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end;

    % Start the trial
    T.startTimeReal(trial,1) = GetSecs-t0;
    T.startTRreal(trial,1) = TRreal;
    T.timeOfTR(trial,1) = timeOfTR-t0;
    
    for i=flip(1:numResp)
        DrawFormattedText(screen.window, num2str(mov(trial,i)), screen.xCenter-charXpos(i), 'center', screen.black);
    end;
    Screen('Flip', screen.window);
    
    % Set up variables
    respMade = 0; % Number of responses made
    keyDown = 0;  % Is a key currently down?
    resp = [NaN;NaN;NaN;NaN;NaN;NaN]; 
    T.seqCorr(trial,1) = 0;
    T.rt(trial,1) = 0;
    T.numCorr(trial,1) = 0;
    T.numErr(trial,1) = 0;
    T.numTrial(trial,1) = trial;
    
    % Start timer
    t2 = GetSecs;
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(trial);
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~keyDown && isPressed && respMade<numResp && (keyCode(screen.one) || keyCode(screen.two) || keyCode(screen.three) || keyCode(screen.four)))
            respMade = respMade+1;
            if keyCode(screen.one)
                resp(respMade) = 1;
                t1 = GetSecs;
                rt = t1-t2;
                T.rt(trial,1) = rt;
            elseif keyCode(screen.two)
                resp(respMade) = 2;
                t1 = GetSecs;
                rt = t1-t2;
                T.rt(trial,1) = rt;
            elseif keyCode(screen.three)
                resp(respMade) = 3;
                t1 = GetSecs;
                rt = t1-t2;
                T.rt(trial,1) = rt;
            elseif keyCode(screen.four)
                resp(respMade) = 4;
                t1 = GetSecs;
                rt = t1-t2;
                T.rt(trial,1) = rt;
            else
                resp(respMade) = 0;
            end
            
            keyDown = 1;
            if (resp(respMade) == mov(trial,respMade))
                T.numCorr(trial,1) = T.numCorr(trial)+1;
            else
                T.numErr(trial,1)  = T.numErr(trial)+1;
            end;
            
            % Refresh the screen
            for i= flip(1:numResp)
                if i>respMade
                    colour = screen.black;
                elseif (resp(i) == mov(trial,i))
                    colour = screen.green;
                elseif (resp(i) ~= mov(trial,i))
                    colour = screen.red;
                end;
                
                DrawFormattedText(screen.window, num2str(mov(trial,i)), ...
                    screen.xCenter-charXpos(i), 'center', ...
                    colour);
            end;
            Screen('Flip', screen.window);
        end;
        
        % Checks for released keys
        if (keyDown && ~isPressed)
            keyDown =0;
        end;
    end
    
    % Draw fixation cross
    DrawFormattedText(screen.window, '+','center', 'center',screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    % Record data
    T.resp1(trial,1) = resp(1); 
    T.resp2(trial,1) = resp(2); 
    T.resp3(trial,1) = resp(3); 
    T.resp4(trial,1) = resp(4); 
    T.resp5(trial,1) = resp(5); 
    T.resp6(trial,1) = resp(6);

    T.seqCorr(trial,1) = numResp==respMade && T.numErr(trial)==0;
    T.respMade(trial,1) = respMade;
end

score = round(sum(T.seqCorr)*100/length(T.seqCorr));
