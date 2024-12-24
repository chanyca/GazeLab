function isWithin = GazeLab_FixationHelper(win, env, param)
% On-screen fixation helper if target is out of bound
% Draws circle around fixation to facilitate fixation
% Green if gaze is within allowance, red otherwise
% Function exits when viewer successfully fixate for 1 second and return
% 
% Parameters:
%   env (struct) - information about environment, defined in `SetUpWindow`
%   win (struct) - information about on-screen window, defined in
%   `SetUpWindow`
%   param (struct) - stimulus parameters, defined in `SetUpParam`
%
% Returns:
%   isWithin (logical) - true if target is within bound, else false

if ~param.dummymode, Eyelink('Message', 'FIX_FAILED'); end
param.show_trace = true;

fixated = false(1, param.fix_help_nframes);
while ~all(fixated)
    for iframe = 1:param.fix_help_nframes
        
        % Get current gaze coordinates
        [~, nowCoords] = GazeLab_MonitorGaze(env, win, param);

        % Draw fixation
        GazeLab_DrawStim('fixation', win, env, param);
        
        % Draw circle to facilitate fixation
        fix_success = sqrt((nowCoords(1) - param.fix_center(1))^2 + (nowCoords(2) - param.fix_center(2))^2) <= param.fix_deg_allowed;
        if ~fix_success
            Screen('FrameOval', win.ptr, param.red, param.fix_circle, param.fix_circle_lw);
        else
            Screen('FrameOval', win.ptr, param.green, param.fix_circle, param.fix_circle_lw);
        end
        Screen('Flip', win.ptr);
        fixated(iframe) = fix_success;
    end

end

if ~param.dummymode, Eyelink('Message', 'FIX_SUCCEED'); end
param.show_trace = false;

isWithin = true;
