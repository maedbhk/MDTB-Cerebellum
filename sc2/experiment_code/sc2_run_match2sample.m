function [T, score] = sc2_run_match2sample(screen,keyNames,T)

global TRreal timeOfTR;

% sc2
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Match-to-Sample Task

% Input variables:
% screen - output arg from 'sc2_psychtoolbox_config'
% keyNames - output arg from 'sc2_psychtoolbox_config'
% T - target file containing task-relevant information

% Output variables:
% T - task information to be saved (added to input structure, T)
% score - feedback (numerical or qualitative - depending on the task)

%% Display Instructions

if (nargin< 3 || isempty(T)) && isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Match-to-Sample Task! \n\n Use your RIGHT hand \n\n "%s" = Left-Sided Image \n\n "%s" = Right-Sided Image',keyNames{3},keyNames{4}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
elseif (nargin< 3 || isempty(T)) && ~isempty(keyNames{5}),
    DrawFormattedText(screen.window, sprintf('Match-to-Sample Task! \n\n Use your RIGHT hand \n\n "%s" = Left-Sided Image \n\n "%s" = Right-Sided Image \n\n %s',keyNames{3},keyNames{4},keyNames{5}),...
        'center', 'center', screen.black);
    Screen('Flip', screen.window);
    return;
end;

% Number of trials
numTrials = length(T.startTime);

tic

% Start the trial
t0 = GetSecs;

%% Begin Experimental Loop
for trial = 1:numTrials,
    
    % Read images (original and sample)
    origImg = imread(char(T.orig(trial)));
    sampleImg= imread(char(T.sample(trial)));
    origImgDisplay  = Screen('MakeTexture', screen.window, origImg);
    sampleImgDisplay = Screen('MakeTexture', screen.window, sampleImg);
    
    % Calculate image position (original)
    origImageSize = size(origImg);
    posOrig = [(screen.width-origImageSize(2))/2 (screen.height-origImageSize(1))/2 (screen.width+origImageSize(2))/2 (screen.height+origImageSize(1))/2];
    
    % Determine x-positions and y-positions for left and right
    origRect=[0 0 origImageSize(2) origImageSize(1)];
    I=screen.xCenter/2;
    xPos=[screen.xCenter-(I);screen.xCenter+(I)];
    yPos=[screen.yCenter;screen.yCenter];
    
    leftPos= CenterRectOnPointd(origRect, xPos(1), yPos(1));
    rightPos=CenterRectOnPointd(origRect, xPos(2), yPos(2));
    
    if T.position(trial)==1,
        posMatch = leftPos; % orig image is placed to the lEFT of fixation
        posSample = rightPos; % sample image is placed to the RIGHT of fixation
    elseif T.position(trial)==2,
        posMatch = rightPos; % orig image is placed to the RIGHT of fixation
        posSample = leftPos; % sample image is placed to the LEFT of fixation
    end
    
    % Before trial starts
    while GetSecs-t0 <= T.startTime(trial);
        checkTR(screen);
    end;
    
    % Show original image
    Screen('DrawTexture', screen.window, origImgDisplay, [], posOrig);
    Screen('Flip', screen.window);
    
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
    
    % length of time that original image will be on screen
    while GetSecs-t0 <= T.startTime(trial)+T.trialDurOrig(trial);
        checkTR(screen);
    end;
    
    % Draw fixation cross
    DrawFormattedText(screen.window, '+',screen.xCenter,screen.yCenter,screen.black); 
    Screen('Flip', screen.window);
    
    % length of delay
    while GetSecs-t0 <= T.startTime(trial)+T.delayDur(trial);
        checkTR(screen);
    end;
    
    % Load original and sample images (placed side by side)
    Screen('DrawTexture', screen.window, origImgDisplay, [], posMatch);
    Screen('DrawTexture', screen.window, sampleImgDisplay, [], posSample);
    DrawFormattedText(screen.window, '+',screen.xCenter,screen.yCenter,screen.black); 
    Screen('Flip', screen.window);
    
    % Start timer before display
    t2 = GetSecs;
    
    while GetSecs-t0 <= T.startTime(trial)+T.trialDurSample(trial);
        checkTR(screen)
        % Check the keyboard.
        [isPressed, ~, keyCode] = KbCheck(screen.keyBoard); % query specific keyboard
        if keyCode(screen.escapeKey)
            ShowCursor;
            sca;
            return
        end;
        if (~respMade && isPressed && (keyCode(screen.three) || keyCode(screen.four)))
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
            if T.position(trial)==2,
                if (response==1),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    Screen('DrawTexture', screen.window, origImgDisplay, [], posMatch);
                    DrawFormattedText(screen.window, '+',screen.xCenter,screen.yCenter,screen.black); %fixation cross in center
                    Screen('DrawTexture', screen.window, sampleImgDisplay, [], posSample);
                    makeSquare(screen, numCorr)
                elseif (response==2),
                    % Give feedback
                    % Display incorrect
                    Screen('DrawTexture', screen.window, origImgDisplay, [], posMatch);
                    DrawFormattedText(screen.window, '+',screen.xCenter,screen.yCenter,screen.black); %fixation cross in center
                    Screen('DrawTexture', screen.window, sampleImgDisplay, [], posSample);
                    makeSquare(screen, numCorr)
                end
            end
            if T.position(trial)==1,
                if (response==1),
                    % Give feedback
                    % Display incorrect
                    Screen('DrawTexture', screen.window, origImgDisplay, [], posMatch);
                    Screen('DrawTexture', screen.window, sampleImgDisplay, [], posSample);
                    makeSquare(screen, numCorr)
                elseif (response==2),
                    numCorr = 1;
                    T.numCorr(trial,1) = numCorr;
                    % Give feedback
                    % Display correct
                    Screen('DrawTexture', screen.window, origImgDisplay, [], posMatch);
                    Screen('DrawTexture', screen.window, sampleImgDisplay, [], posSample);
                    makeSquare(screen, numCorr)
                end
            end
        end
    end
    % Draw fixation cross
    DrawFormattedText(screen.window, '+',screen.xCenter,screen.yCenter,screen.black); %fixation cross in center
    Screen('Flip', screen.window);
    
    checkTR(screen) % TEST
    
    T.respMade(trial,1) = respMade;
end

toc

score = round(sum((T.numCorr))*100/length(T.numCorr));
