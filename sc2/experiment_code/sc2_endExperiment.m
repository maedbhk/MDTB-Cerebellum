function sc2_endExperiment(screen)

% sc2
% Maedbh King (2017)

% Input(screen) : output arg from 'sc2_psychtoolbox_config'

% End of experiment screen. 

DrawFormattedText(screen.window, 'Okay all done!',...
    'center', 'center', screen.black);

Screen('Flip', screen.window);

WaitSecs(1)

sca;

Screen('ClearAll')