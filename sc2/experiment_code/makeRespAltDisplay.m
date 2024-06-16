function makeRespAltDisplay(screen,A,varargin)

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

% Determine border position
respPos=[A.respPos1,A.respPos2,A.respPos3,A.respPos4,A.respPos5,A.respPos6]; 

% Determine square positions
I=screen.xCenter/(A.sizeDisplay); 

% Determine x-positions and y-positions
xPos=[screen.xCenter-(I*2);screen.xCenter-(I/1.5);screen.xCenter+(I/1.5);screen.xCenter+(I*2)]'; 
yPos=repmat([screen.yCenter-round(I/3)],4,1)'; 

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
    case 'drawBorders'
        % draw green borders around respAlts
        for s=1:sum(respPos~=0),
              Screen('FrameRect',screen.window,screen.green,centeredRect(respPos(s),:),6);  
        end
    case 'drawSignal'
%         Screen('FillRect', screen.window, screen.green, centeredRect(A.targPos,:))
        DrawFormattedText(screen.window, '+', xPos(A.targPos)-8, yPos(A.targPos)-25, screen.white)
        Screen('FrameRect',screen.window,screen.green,centeredRect(A.targPos,:),6)
end
