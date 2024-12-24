%% Demo
% Observer fixate successfully for 3 seconds
% If succeed, move on to next trial
% Elseif failed for any continuous period (user defined %) within the 3-s 
% fixation, enlist fixation helper

%% Prep
clear
clc
commandwindow

addpath(genpath('helper'))
addpath(genpath('dependencies'))
Answer = getInfo;
param.tracking_mode = Answer.tracking_mode;
param.fail_allowed = Answer.fail_allowed;
param.show_trace = logical(Answer.show_trace-1);

%% Set up on-screen window and update variables if needed
[env, win] = SetUpWindow;

% Measure your OWN monitor and viewing distance
env.screenWidthCm = 60; % cm, change as needed
env.viewingDistanceCm = 57; %cm, change as needed

%% Set up Param and update variables if needed
param = SetUpParam(env, win, param);

%% Set Up Eyelink
SetUpEyelink;

%% Fixation parameters - change as you wish
param.fix_center = [env.xCenter env.yCenter]; % Currently set at center of screen
param.fix_dur_s = 3; % sec, fixation duration
param.fix_nframes = param.fix_dur_s / env.ifi;

%% Show stimulus
HideCursor
endTask = false;
trialno = 1;
while ~endTask
    
    while KbCheck; end % Wait until all keys are released
    % If user presses `Esc`, exit loop and close everything
    [~, ~, keyCode] = KbCheck;
    if keyCode(KbName('ESCAPE'))
        endTask = true;
        break
    end

    % Trial start
    param = UpdateTargetPosition(env, param);

    % Send message to Eyelink, for analysis post-hoc
    if ~param.dummymode, Eyelink('Message', sprintf('TRIAL_START_%d', trialno)); end
    
    % Create array for number of frames during fixation period
    fixated = false(1, param.fix_nframes);

    % Start showing fixation AND visual target
    % Also monitor gaze performance
    for iframe = 1:param.fix_nframes
        GazeLab_DrawStim('fixation', win, env, param);
        [isWithin, nowCoords] = GazeLab_MonitorGaze(env, win, param);
        GazeLab_DrawStim('target', win, env, param, 'nowCoords', nowCoords);
        Screen('flip', win.ptr)
        fixated(iframe) = isWithin;

        while KbCheck; end % Wait until all keys are released
        % If user presses `Esc`, exit loop and close everything
        [~, ~, keyCode] = KbCheck;
        if keyCode(KbName('ESCAPE'))
            endTask = true;
            break
        end

    end
    
    % Check if observer successfully fixated for required period (< 1 sec
    % continuous off-fixation)
    failed = GazeLab_FixationCheck(fixated, param);
    if failed
        GazeLab_DrawStim('warning', win, env, param)
        Screen('flip', win.ptr)
        WaitSecs(1)
        % Fixation helper
        isWithin = GazeLab_FixationHelper(win, env, param);
    else
        % trial success
        if ~param.dummymode, Eyelink('Message', 'FIX_END'); end
        if ~param.dummymode, Eyelink('Message', sprintf('TRIAL_END_%d', trialno)); end
        GazeLab_DrawStim('Trial Success!\n\nNext Trial', win, env, param)
        Screen('flip', win.ptr)
        WaitSecs(1)
        KbWait;
    end
    
    trialno = trialno + 1;

end

ShowCursor
sca