function make_checkerBoard(screen)

% Here we calculate the radial distance from the center of the screen to
% the X and Y edges
xRadius = screen.windowRect(3) / 2;
yRadius = screen.windowRect(4) / 2;

% Screen resolution in Y
screenYpix = screen.windowRect(4);

% Number of white/black circle pairs
rcycles = 8;

% Number of white/black angular segment pairs (integer)
tcycles = 24;

% Now we make our checkerboard pattern
xylim = 2 * pi * rcycles;
[x, y] = meshgrid(-xylim: 2 * xylim / (screenYpix - 1): xylim,...
    -xylim: 2 * xylim / (screenYpix - 1): xylim);
at = atan2(y, x);
checks = ((1 + sign(sin(at * tcycles) + eps)...
    .* sign(sin(sqrt(x.^2 + y.^2)))) / 2) * (screen.white - screen.black) + screen.black;
circle = x.^2 + y.^2 <= xylim^2;
checks = circle .* checks + screen.grey * ~circle;

% Now we make this into a PTB texture
radialCheckerboardTexture  = Screen('MakeTexture', screen.window, checks);
Screen('DrawTexture', screen.window, radialCheckerboardTexture);
Screen('Flip', screen.window)