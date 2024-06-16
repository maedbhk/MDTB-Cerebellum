function makeRectangle(screen,position,colour,flip)

% Input(screen) : output arg from 'sc2_psychtoolbox_config'
% Input(position): horiztonal or vertical
% Input(colour): red or blue

% Set the rectangle colour (red or blue)
if colour==1,
    rectColour = screen.red;
else
    rectColour = screen.blue;
end

% Set the rectangle position (horizontal or vertical)
if position==1,
    rectPos=[10 10 300 100]; % horizontal
else
    rectPos=[10 10 100 300]; % vertical
end

% Center the rectangle on the screen
centeredRect = CenterRectOnPointd(rectPos, screen.xCenter, screen.yCenter);

% Draw the rectangle to the screen
Screen('FillRect', screen.window, rectColour, centeredRect);

if flip==1,
    % Flip to the screen
    Screen('Flip', screen.window)
end