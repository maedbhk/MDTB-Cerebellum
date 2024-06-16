function [screen,keyNames] = sc1_psychtoolbox_config
%% super_cerebellum project 

% Maedbh King (2015/2016)

% Set up the Psychtoolbox screen

% Output variables: 
% screen - contains all information need to open PTB screen
% keyNames - letters or numbers will appear for instructions. 

% ****User input required****
% Change userType to 'other_user' in Section 1.1
% Change screen.isScan to 0 in Section 1.1
% (Optional): change response keys in Section 7.1
% (Optional): if you are debugging, uncomment section 4.1

%% 1.1 User Input Required 

sca % clear all screens

% Set-up output structure
screen = struct();

% Behavioural or scanner script
screen.isScan = 0;  % 0 if behavioural; 1 if scanner

% Determine user 
userType = 'me'; % 'other_user' - assign response keys as 'd','f','g','h' instead of '1','2','3','4'

%% 2.1 Enable Protections

% Initiates Psychtoolbox boilerplate operations
PsychDefaultSetup(2); % includes AssertOpenGL and KbName('UnifyKeyNames')

rand('seed') % initialise random number generator
%% 3.1 Test the Screen

% skip tests
Screen('Preference','SkipSyncTests',2); %0 not to skip tests (not recommended - synchronisation always fails..)

%% 4.1 Activate for Debugging

% Activate for Debugging
% PsychDebugWindowConfiguration;

%% 5.1 Open the Screen

% Start listening for keyboard input
ListenChar(2); % 2 will suppress output of keypresses to matlab window

% Set the screen number to the external secondary monitor if there is one connected
screen.Number = max(Screen('Screens'));

% HideCursor(screen.Number);

% Defines colours
colour.white = 255;
colour.grey = 150;
colour.black = 0;
colour.green = [0 255 0];
colour.red = [255 0 0];

screen = addstruct(screen, colour);

%Open the screen 
if screen.isScan == 0, % behavioural
[screen.window, screen.windowRect] = Screen('Openwindow',screen.Number,screen.grey,[],32,2); 
screen.windowRect = [0 0 1024 768]; % scanner dimensions

else % scanning
    [screen.window, ~] = Screen('Openwindow',screen.Number,screen.grey,[],[],2);
    screen.windowRect = [0 0 1024 768]; % scanner dimensions
end

% Screen priority
screen.priority=MaxPriority(screen.window); 

%% 6.1 Set-Up Screen

fontsize = 40; 

% Setup the text type for the window
Screen('Preference', 'TextRenderer', 0)
Screen('TextFont', screen.window, 'Trebuchet MS');
Screen('TextSize', screen.window,fontsize);

% Get the coordinates of the window
[screen.xCenter, screen.yCenter] = RectCenter(screen.windowRect); % screen center

screen.width = screen.windowRect(RectRight); % screen width
screen.height = screen.windowRect(RectBottom); % screen height

%% 7.1 Set-Up Keyboard
 
screen.keyBoard = -3; % queries all keyboard and keypad devices

% display letters or numbers depending on user
if strfind(userType,'other_user'),
    keyNames = {'D','F','G','H'};
else 
    keyNames = {'1','2','3','4'};
end

% screen.keyNames={'1','2',....'9'}; 

% Define response keys: 

% Behavioural (Keyboard)
if screen.isScan == 0, 
    screen.KbCheckList = [KbName('SPACE'),KbName('ESCAPE'),KbName('d'),KbName('f'),KbName('g'), KbName('h'), KbName('t'), KbName('5')];
    RestrictKeysForKbCheck(screen.KbCheckList);
    screen.pulseKey =  KbName('t');
    screen.escapeKey = KbName('ESCAPE');
    screen.spaceKey = KbName('SPACE');
    screen.one = KbName('d');
    screen.two = KbName('f');
    screen.three = KbName('g');
    screen.four = KbName('h');
    screen.pulseFive = KbName('5');
    
    % Scanner (Button Box)
elseif screen.isScan == 1,
    screen.KbCheckList = [KbName('ESCAPE'), KbName('SPACE'),KbName('b'), KbName('y'), KbName('g'), KbName('r'), KbName('t'), KbName('5')];
    RestrictKeysForKbCheck(screen.KbCheckList);
    screen.escapeKey = KbName('ESCAPE');
    screen.spaceKey = KbName('SPACE'); 
    screen.pulseKey =  KbName('t');
    screen.one = KbName('b'); % b
    screen.two = KbName('y'); % y
    screen.three = KbName('g'); % g
    screen.four = KbName('r'); % r
    screen.pulseFive = KbName('5'); 
end

