function [edfFile] = sc1_start_eyeTracking(screen,el,edfFile,T)

% Maedbh King

dummymode = 0;

if ~EyelinkInit(dummymode, 1)
    fprintf('Eyelink Init aborted.\n');
    cleanup;  % cleanup function
    return;
end

Eyelink('command', 'link_event_data = GAZE,GAZERES,HREF,AREA,VELOCITY');
Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,BLINK,SACCADE,BUTTON');

status=Eyelink('openfile',edfFile);
if status~=0
    error('openfile error, status: ',status);
else
    fprintf('%s file has been opened \n',edfFile)
end

% Define variables
textOut = 1; %write reports from tracker to stdout

%%
% adapt display based on END-SACCADE events

% Start the task
t0 = GetSecs;

% start recording eye position
Eyelink('startrecording');
fprintf('eyetracker recording has started \n')

% mark zero-plot time in data file
status=Eyelink('message', 'SYNCTIME');
if status~=0,
    error('message error, status: ',status)
end

% message for RT recording in analysis
Eyelink('message','DISPLAY ON');

while GetSecs-t0 <= T.startTime(1);
    %time = Eyelink('TrackerTime');
    %time = Eyelink('RequestTime');
end;

Eyelink('message','taskname',T.taskName(1)); 

% Get start-time
time = (GetSecs-t0)';
Eyelink('message','startTimeReal',time);

Priority(screen.priority);

mistake=Eyelink('checkrecording');        % Check recording status, stop display if error
if(mistake~=0)
    error('checkrecording problem, status: ',mistake)
    return;
end

% check for endsaccade events
evtype=Eyelink('getnextdatatype');

if Eyelink('isconnected') == el.connected % if we're really measuring eye-movements
    evt = Eyelink('getfloatdata', evtype); % get data
    fprintf('measuring eye movements \n')
else
    evt=0;
    fprintf('eye movements are not being measured \n')
end

if textOut
    evt;
end

% WaitSecs(0.1);	% wait a while to record a few more samples
