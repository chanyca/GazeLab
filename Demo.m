%% Demo

%% Set up on-screen window and update variables if needed
[env, win] = SetUpWindow;

% Measure your OWN monitor and viewing distance
env.screenWidthCm = 60; % cm, change as needed
env.viewingDistanceCm = 57; %cm, change as needed

%% Set up Param and update variables if needed
param = SetUpParam(env, win);

%% Set up EyeLink
param.dummymode = true;
param.show_trace = true;

% Initialization of the connection with the Eyelink Gazetracker.
% exit program if this fails.
if ~EyelinkInit(param.dummymode)
    fprintf('Eyelink Init aborted.\n');
    sca
    return;
end

% Calibration
el = EyelinkInitDefaults(win.ptr);

% open file on host computer to receive data
Eyelink('openfile',['test','.edf']);

% Calibrate the eye tracker using the standard calibration routines
EyelinkDoTrackerSetup(el);

% Eyelink drift correct
EyelinkDoDriftCorrection(el);

Eyelink('Command', 'set_idle_mode');
WaitSecs(0.05);

%start writing data to file:  needed to begin, and to restart after every
%drift correction
Eyelink('StartRecording');

%% Fixation
% Currently set at center of screen, change as you wish
param.fix_center = [env.xCenter env.yCenter];

%% Show stimulus
HideCursor
endLoop = false;
while ~endLoop    
    % If user presses `Esc`, exit loop and close everything
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyCode(KbName('ESCAPE'))
        endLoop = true;
    end

    GazeLab_DrawStim('fixation', win, env, param);
    [isWithin, nowCoords] = GazeLab_MonitorGaze(env, win, param);
    GazeLab_DrawStim('target', win, env, param, 'nowCoords', nowCoords);
    Screen('flip', win.ptr)

    while ~isWithin
        GazeLab_DrawStim('warning', win, env, param)
        Screen('flip', win.ptr)
        WaitSecs(1)
        % Fixation helper
        isWithin = GazeLab_FixationHelper(win, env, param);
    end
end

ShowCursor
sca