function [T, score] = sc1_run_arithmetic(screen,keyNames,T)

global TRreal timeOfTR;

%% super_cerebellum project 
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Arithmetic Task

% Input variables:
% screen - output arg from 'sc1_psychtoolbox_config'
% keyNames - output arg from 'sc1_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables: 
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Arithmetic Task! \n\n Identify the correct equations \n\n Use your RIGHT hand \n\n "%s" = true \n\n "%s" = false',keyNames{3},keyNames{4}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Arithmetic Task! \n\n Identify the correct equations \n\n Use your RIGHT hand \n\n "%s" = true \n\n "%s" = false \n\n %s',keyNames{3},keyNames{4},keyNames{5}),...
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
    
    % Get question
    if T.trialType(trial)==1,
        % Verification task
%         question = {'false or true?'};
        equationList = [T.tmp1(trial),T.tmp2(trial),T.tmp3(trial),T.tmp4(trial),T.tmp5(trial)];
        equation = [num2str(equationList{1}),equationList{2},num2str(equationList{3}),equationList{4},num2str(equationList{5})];
    elseif T.trialType(trial)==2,
        % Control task
%         question = {'is there a one?'};
        equationList = [T.tmp1(trial),T.tmp2(trial),T.tmp3(trial),T.tmp4(trial)];
        equation = [num2str(equationList{1}),equationList{2},num2str(equationList{3}),equationList{4}];
    end
    
    % Determine equation correctness
    if T.condition(trial),
        valence = 'correct';
    elseif ~T.condition(trial),
        valence = 'incorrect';
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
    T.numTrial(trial,1) = trial;
    T.respMade(trial,1) = respMade;
    
    % Start timer before display
    t2 = GetSecs;
    
    % Draw text
    DrawFormattedText(screen.window, equation, 'center', 'center',screen.black);
%     DrawFormattedText(screen.window, char(question), screen.width/2.5, screen.height/1.75, screen.black);
    Screen('Flip', screen.window);
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDur(1);
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && (keyCode(screen.three) || keyCode(screen.four)))
            if keyCode(screen.three)
                t1 = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 1;
            elseif keyCode(screen.four)
                t1  = GetSecs;
                rt = t1 - t2;
                respMade = true;
                response = 2;
            end
            
            %% Record the data
            % Record rt
            T.rt(trial,1) = rt;
            if strcmp(valence, 'correct'),
                if (response==1),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    DrawFormattedText(screen.window, equation, 'center', 'center',screen.black);
%                     DrawFormattedText(screen.window, char(question), screen.width/2.5, screen.height/1.75, screen.black);
                    makeSquare(screen, numCorr)
                elseif (response==2),
                    T.numErr(trial,1) = 1;
                    % Give feedback
                    % Display incorrect
                    DrawFormattedText(screen.window, equation, 'center', 'center',screen.black);
%                     DrawFormattedText(screen.window, char(question), screen.width/2.5, screen.height/1.75,screen.black);
                    makeSquare(screen, numCorr)
                end
            end
            if strcmp(valence, 'incorrect'),
                if (response==1),
                    T.numErr(trial,1) = 1;
                    % Give feedback
                    % Display incorrect
                    DrawFormattedText(screen.window, equation, 'center', 'center',screen.black);
%                     DrawFormattedText(screen.window, char(question), screen.width/2.5, screen.height/1.75,screen.black);
                    makeSquare(screen, numCorr)
                elseif (response==2),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    DrawFormattedText(screen.window, equation, 'center', 'center',screen.black);
%                     DrawFormattedText(screen.window, char(question), screen.width/2.5, screen.height/1.75,screen.black);
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
