function sc1_endExperiment(screen)
%% super_cerebellum project 
% Maedbh King (2015/16)

% Input(screen) : output arg from 'sc1_psychtoolbox_config'

% End of experiment screen. 

DrawFormattedText(screen.window, 'Okay all done!',...
    'center', 'center', screen.black);

Screen('Flip', screen.window);

WaitSecs(1)

sca;

Screen('ClearAll')

