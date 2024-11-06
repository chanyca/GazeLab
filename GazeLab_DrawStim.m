function GazeLab_DrawStim(target, win, env, param, varargin)
% Draw stimulus to on-screen window
% 
% Parameters:
%   target (string) - what to draw to screen, e.g., 'fixation'
%   env (struct) - information about environment, defined in `SetUpWindow`
%   param (struct) - stimulus parameters, defined in `SetUpParam`
%
% Returns:
%   None

while ~isempty(varargin)
    switch varargin{1}
        case 'nowCoords'
            nowCoords = varargin{2};
    end
    varargin(1:2) = [];
end


if string(target) == "fixation"
    Screen('DrawLines', win.ptr, param.fix_coords, param.fix_lw, param.white, param.fix_center, 2);

elseif string(target) == "target"
    % Right now, it's a circle by default. Change this as you wish.
    Screen('FillOval', win.ptr, 1, CenterRectOnPointd(param.rect, ...
                                                     nowCoords(1)+param.target.dist_x_from_gaze_pix, ...
                                                     nowCoords(2)+param.target.dist_y_from_gaze_pix));
elseif string(target) == "warning"
    Screen('TextSize', win.ptr, param.text_size_warning);

    % warning text
    [~, ~, textBounds] = DrawFormattedText(win.ptr, 'Warning: Target Out Of Bound', 'center', 'center', param.red);

    % text bounding box
    borderPadding = 20; % padding between text and border
    border_lw = 3; % border line width
    boxRect = [textBounds(1) - borderPadding, textBounds(2) - borderPadding, ...
        textBounds(3) + borderPadding, textBounds(4) + borderPadding];
    Screen('FrameRect', win.ptr, param.red, boxRect, border_lw);

else % text prompt
    Screen('TextSize', win.ptr, param.text_size_regular);
    DrawFormattedText(win.ptr, target, 'center', 'center', param.white);
end