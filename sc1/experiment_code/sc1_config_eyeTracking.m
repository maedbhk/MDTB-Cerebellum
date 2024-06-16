function [el] = sc1_config_eyeTracking

% Maedbh King

% commandwindow;
dummymode=0;       % set to 1 to run in dummymode (using mouse as pseudo-eyetracker)
Screen('Preference','SkipSyncTests',2); %0 not to skip tests (not recommended - synchronisation always fails..)

try
    % STEP 1
    % Open a graphics window on the main screen
    % using the PsychToolbox's Screen function.
    screenNumber=max(Screen('Screens'));
    window=Screen('OpenWindow', screenNumber,150);
    
    % STEP 2
    % Provide Eyelink with details about the graphics environment
    % and perform some initializations. The information is returned
    % in a structure that also contains useful defaults
    % and control codes (e.g. tracker state bit and Eyelink key values).
    el=EyelinkInitDefaults(window);
    
    % STEP 3
    % Initialization of the connection with the Eyelink Gazetracker.
    % exit program if this fails.
    if ~EyelinkInit(dummymode, 1)
        fprintf('Eyelink Init aborted.\n');
        cleanup;  % cleanup function
        return;
    end
    
    [~, ~]=Eyelink('GetTrackerVersion');
%     fprintf('Running experiment on a ''%s'' tracker.\n', vs );
    
    % make sure that we get event data from the Eyelink
%         Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA');
    Eyelink('command', 'link_event_data = GAZE,GAZERES,HREF,AREA,VELOCITY');
    Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,BLINK,SACCADE,BUTTON');
  
    % STEP 4
    % Calibrate the eye tracker
    EyelinkDoTrackerSetup(el);

    WaitSecs(0.1);	% wait a while to record a few more samples 
    cleanup;
    
catch myerr
    %this "catch" section executes in case of an error in the "try" section
    %above.  Importantly, it closes the onscreen window if its open.
    cleanup;
    commandwindow;
    myerr;
    myerr.message
    myerr.stack.line
end %try..catch.

% Cleanup routine:
function cleanup

% finish up: stop recording eye-movements,
% close graphics window, close data file and shut down tracker
 Eyelink('Stoprecording');
% Eyelink('CloseFile');
Eyelink('Shutdown');

% Close window:
% sca;

% Restore keyboard output to Matlab:
ListenChar(0);


