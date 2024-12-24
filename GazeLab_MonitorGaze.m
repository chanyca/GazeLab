function [isWithin, nowCoords] = GazeLab_MonitorGaze(env, win, param)
% Monitor real time gaze coordinates
% 
% Parameters:
%   env (struct) - information about environment, defined in `SetUpWindow`
%   win (struct) - information about on-screen window, defined in
%   `SetUpWindow`
%   param (struct) - stimulus parameters, defined in `SetUpParam`
%
% Returns:
%   isWithin (logical) - true if target is within bound, else false
%   nowCoords (float) = [x, y] gaze coordinates


% Get current gaze coordinates either from Eyelink, or from mouse position
% if we're running on dummy mode
if param.dummymode
    [x,y,buttons] = GetMouse(env.screenNumber);
    nowCoords = [x, y];
else % we are actually tracking eyes
    if Eyelink('NewFloatSampleAvailable') > 0   %check if new data available
        evt = Eyelink('NewestFloatSample'); %transmit newest data sample to client, store in evt struct.
        % eye codes
        % el.LEFT_EYE=0;
        % el.RIGHT_EYE=1;
        % el.BINOCULAR=2;
        eye_used = Eyelink('EyeAvailable');
        x = evt.gx(eye_used+1); % +1 as we're accessing MATLAB array
        y = evt.gy(eye_used+1);
        nowCoords = [x, y];
    end
end

% Draw a green hollow square to indicate where gaze is at
if param.show_trace
    trace_size = 5;
    % rect = [left, top, right, bottom]
    Screen('FrameRect', win.ptr, param.green, [nowCoords(1)-trace_size, nowCoords(2)-trace_size, nowCoords(1)+trace_size, nowCoords(2)+trace_size]);
end

% Draw indicator at top left corner to indicate gaze performance
if strcmp(param.tracking_mode, 'Dynamic')
    isWithin = isTargetWithinScreen(nowCoords, env, param);
elseif strcmp(param.tracking_mode, 'Static')
    isWithin = isGazeWithinFixation(nowCoords, env, param);
end

if isWithin
    Screen('DrawDots', win.ptr, [0 0], 30, param.green); % green
else
    Screen('DrawDots', win.ptr, [0 0], 30, param.red); % red
end

    %% Customized function to check if target is within screen
    function isWithin = isTargetWithinScreen(nowCoords, env, param)
        % Get current gaze coordinates and calculate if target is still within
        % screen, return False if outside bound
        %
        % Parameters:
        %   nowCoords (float) - [x, y] of current gaze coordinates
        %   env (struct) - information about environment, defined in `SetUpWindow`
        %   param (struct) - stimulus parameters, defined in `SetUpParam`
        %
        % Returns:
        %   isWithin (logical)
        
        % Calculate the top-left corner of the target based on the current gaze position
        targetX = nowCoords(1) + param.target.dist_x_from_gaze_pix;
        targetY = nowCoords(2) + param.target.dist_y_from_gaze_pix;

        % Define the target rectangle based on the top-left corner and the size (width & height)
        left = targetX - param.rect(3) / 2;
        top = targetY - param.rect(4) / 2;
        right = targetX + param.rect(3) / 2;
        bottom = targetY + param.rect(4) / 2;

        % Check if any part of the target rectangle falls outside the screen boundaries
        if left < 0 || top < 0 || right > env.screenXpixels || bottom > env.screenYpixels
            isWithin = false;
        else
            isWithin = true;
        end
    end

    %% Customized function to check if gaze is within fixation allowance
    function isWithin = isGazeWithinFixation(nowCoords, env, param)
        % Get current gaze coordinates and calculate if gaze is within
        % fixation allowance, return False if not
        %
        % Parameters:
        %   nowCoords (float) - [x, y] of current gaze coordinates
        %   env (struct) - information about environment, defined in `SetUpWindow`
        %   param (struct) - stimulus parameters, defined in `SetUpParam`
        %
        % Returns:
        %   isWithin (logical)

        isWithin = sqrt((nowCoords(1) - param.fix_center(1))^2 + (nowCoords(2) - param.fix_center(2))^2) <= param.fix_deg_allowed;
    end

end
