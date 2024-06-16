function makeSMDisplay(screen,A,varargin)

% sc2
% Maedbh King, Rich Ivry & Joern Diedrichsen (2017)

% Input(screen) : output arg from 'sc1_psychtoolbox_config' or
% 'sc2_psychtoolbox_config'
% Input(numCorr): scalar defined in individual task functions  

action='makeSquares'; 

vararginoptions(varargin,{'action'});

% Make base rect
baseRect = [0 0 100 100];

% Set the colour of the square.
rectColour = screen.blue;

% Divide the screen
% I=screen.windowRect(3)/A.sizeDisplay; 

% Determine motor response feedback 
motorResps = [A.motorResp1,A.motorResp2,A.motorResp3,A.motorResp4,A.motorResp5,A.motorResp6,A.motorResp7,A.motorResp8];

% Determine border position
respPos=[A.respPos1,A.respPos2,A.respPos3,A.respPos4,A.respPos5,A.respPos6,A.respPos7]; 

% Determine square positions
I=screen.xCenter/(A.sizeDisplay/2); 

% Determine x-positions and y-positions
xPos=repmat([screen.xCenter-(I*2);screen.xCenter-(I/1.5);screen.xCenter+(I/1.5);screen.xCenter+(I*2)],2,1)'; 
yPos=kron([screen.yCenter-round(I/2);screen.yCenter+round(I/2)],ones(A.sizeDisplay/2,1)); 

% Set-up display
for s=1:A.sizeDisplay,
    % Center the rectangle on the screen
    centeredRect(s,:) = CenterRectOnPointd(baseRect, xPos(s), yPos(s));
end

switch action
    case 'makeSquares'
        for s=1:A.sizeDisplay,
            % Draw the square to the screen
            Screen('FillRect', screen.window, rectColour, centeredRect(s,:));
        end
    case 'drawNumbers'
        % print motor responses to squares
        for s=1:A.sizeDisplay,
            DrawFormattedText(screen.window, char(num2str(motorResps(s))), xPos(s)-8, yPos(s)-25, screen.white);
        end
    case 'drawBorders'
        % draw green borders around respAlts
        for s=1:sum(~isnan(respPos)),
              Screen('FrameRect',screen.window,screen.green,centeredRect(respPos(s),:),6);  
        end
    case 'removeTargNum' 
        Screen('FillRect', screen.window, rectColour, centeredRect(A.targPos,:));
    case 'drawTargBorder'
        Screen('FrameRect',screen.window,screen.green,centeredRect(A.targPos,:),6);  
end
