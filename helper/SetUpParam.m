function param = SetUpParam(env, win, param)
% Set up parameters for colors, text, fixation, gaze, target
% 
% Parameters:
%   env (struct) - information about environment, defined in `SetUpWindow`
%   win (struct) - information about on-screen window, degined in `SetUpWindow`
% 
% Returns:
%   param (struct) - stimulus parameters

%% Colors
param.white = [1 1 1];
param.black = [0 0 0];
param.green = [0 1 0];
param.red   = [1 0 0];

%% Text
param.text_color = env.white; %mod(backgr + 0.5,1);
param.text_size_regular = 30;
param.text_size_warning = 60;
Screen('TextStyle', win.ptr, 1);

%% Fixation cross
% This may be updated if user define param.fix_center after this function
% call
param.fix_center = [env.xCenter env.yCenter];

param.fix_size = 25; % length of one arm of fixation cross
param.fix_color = param.white; % color of fixation cross
param.fix_lw = 10; % line width of fixation cross
param.fix_X = [-param.fix_size  param.fix_size  0               0];
param.fix_Y = [0               0              -param.fix_size  param.fix_size];
param.fix_coords = [param.fix_X; param.fix_Y];


%% Fixation helper (Circle to facilitate fixation)
% Set at 2 degree radius now, change as you wish
param.fix_deg_allowed = visualDegree2pix(2, env.screenXpixels, env.screenWidthCm, env.viewingDistanceCm);
param.fix_circle = [param.fix_center(1) - param.fix_deg_allowed; ...
                    param.fix_center(2) - param.fix_deg_allowed; ...
                    param.fix_center(1) + param.fix_deg_allowed; ...
                    param.fix_center(2) + param.fix_deg_allowed];
param.fix_circle_lw = 10;
param.fix_help_s = 1;
param.fix_help_nframes = param.fix_help_s / env.ifi;

%% Gaze indicator
param.gaze_color = param.green;

%% Target
% Origin (0,0) upper-left corner
% negative x: left of gaze
% positive x: right of gaze
% negative y: above gaze
% positive y: below gaze

param.target.d = 2; % visual degree
d_deg = visualDegree2pix(param.target.d, env.screenXpixels, env.screenWidthCm, env.viewingDistanceCm);

% rect = [left top right bottom]
param.rect = [0 0 d_deg d_deg];

return