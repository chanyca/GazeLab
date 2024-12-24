%% Set up EyeLink
param.dummymode = logical(Answer.dummy-1);

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
Eyelink('openfile',[Answer.sid,'.edf']);

% Calibrate the eye tracker using the standard calibration routines
EyelinkDoTrackerSetup(el);

% Eyelink drift correct
EyelinkDoDriftCorrection(el);

Eyelink('Command', 'set_idle_mode');
WaitSecs(0.05);

%start writing data to file:  needed to begin, and to restart after every
%drift correction
Eyelink('StartRecording');