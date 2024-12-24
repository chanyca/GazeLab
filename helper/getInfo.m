%% getInfo
function [Answer,Cancelled] = getInfo(varargin)

dummy = true; tracking_mode = true; fail_allowed = true; show_trace = true;
while ~isempty(varargin)
    switch lower(varargin{1})
       
        case 'dummy'
            dummy = varargin{2};
        case 'tracking_mode'
            tracking_mode = varargin{2};
    end
    varargin(1:2) = [];
end

Title = '';

Options.Resize = 'on';
Options.Interpreter = 'tex';
Options.CancelButton = 'on';
Options.ApplyButton = 'off';
Options.ButtonNames = {'Continue','Cancel'}; %<- default names, included here just for illustration
Options.AlignControls = 'on';

Prompt = {};
Formats = {};
DefAns = struct([]);

% Subject ID
Prompt(1,:) = {'Subject ID', 'sid', []};
Formats(1,1).type = 'edit';
Formats(1,1).format = 'text';
Formats(1,1).size = 100; % automatically assign the height
DefAns(1).sid = '0000';

% Dummy
if dummy
Prompt(end+1,:) = {'Dummy Mode','dummy',[]};
Formats(end+1,1).type = 'list';
Formats(end,1).format = 'integer';
Formats(end,1).style = 'radiobutton';
Formats(end,1).items = [0 1];
DefAns.dummy = 2; % index, default dummy
end

% Show trace
if show_trace
Prompt(end+1,:) = {'Show Trace?','show_trace',[]};
Formats(end+1,1).type = 'list';
Formats(end,1).format = 'integer';
Formats(end,1).style = 'radiobutton';
Formats(end,1).items = [0 1];
DefAns.show_trace = 2; % index, default show trace
end

% Tracking Mode
if tracking_mode
Prompt(end+1,:) = {'Tracking Mode','tracking_mode',[]};
Formats(end+1,1).type = 'list'; 
Formats(end,1).format = 'text';
Formats(end,1).style = 'radiobutton';
Formats(end,1).items = {'Dynamic' 'Static'};
DefAns.tracking_mode = 'Dynamic';
end

% Fail allowed
if fail_allowed
Prompt(end+1,:) = {'Fail Allowed (%)', 'fail_allowed', []};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'integer';
Formats(end,1).size = 50; % automatically assign the height
DefAns.fail_allowed = 30;
end

%% FINAL STEP
[Answer,Cancelled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);

end
