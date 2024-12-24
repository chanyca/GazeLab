function failed = GazeLab_FixationCheck(fixated, param)
% Monitor real time gaze coordinates
%
% Parameters:
%   fixated (double) - array to store fixation performance each frame
%   param (struct) - stimulus parameters, defined in `SetUpParam`
%
% Returns:
%   passed (logical) - true if user fixated successfully for required
%                      period

%% Get threshold for success
threshold = round(param.fail_allowed/100 * length(fixated));
failed_periods = regionprops(~fixated, 'Area');
failed_lengths = [failed_periods.Area];
failed = any(failed_lengths >= threshold);


end