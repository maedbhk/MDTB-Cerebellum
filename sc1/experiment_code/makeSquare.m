function makeSquare(screen, numCorr)
% sc1
% Maedbh King, Rich Ivry & Joern Diedrichsen (2015/16)

% Input(screen) : output arg from 'sc1_psychtoolbox_config' or
% 'sc2_psychtoolbox_config'
% Input(numCorr): scalar defined in individual task functions 

% Make feedback square

% Make base rect
baseRect = [0 0 80 80];

% Center the rectangle on the screen
centeredRect = CenterRectOnPointd(baseRect, screen.xCenter, screen.yCenter*1.5);

% Set the colour to red if incorrect and green if correct
if numCorr == 0,
rectColour = screen.red; 
elseif numCorr;
    rectColour = screen.green; 
end

% Draw the square to the screen
Screen('FillRect', screen.window, rectColour, centeredRect); 

% Flip to the screen
Screen('Flip', screen.window)