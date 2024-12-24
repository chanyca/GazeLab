function [env, win] = SetUpWindow
    % Calls Psychtoolbox and get native screen details and set up an
    % on-screen window
    % 
    % Returns:
    %   env (struct) - information about native environment
    %   win (struct) - information about on-screen window, contains window
    %   pointer `win.ptr` and window size `win.rect`

    %% Start
    % Perform standard setup for Psychtoolbox
    % featureLevel options:
    %   (0) do nothing but execute the AssertOpenGL command, to make sure
    %   that the Screen() mex file is properly installed and functional.
    %   (1) Additionally execute KbNa,e('UnifyKeyNames') to provide a
    %   consistent mapping of keyCodes to key names on all operating
    %   systems
    %   (2) Additionally imply the execution of Screen('ColorRange',
    %   window, 1, [], 1), which normalizes 0-255 to 0.0-1.0
    %   For more information, execute `help PsychDefaultSetup` in Command
    %   Window
    PsychDefaultSetup(2);

    % Bypass the timing and synchronization tests when setting up a window
    Screen('Preference', 'SkipSyncTests', 1);
    % for maximum accuracy and reliability use this:
    % Screen('Preference', 'SkipSyncTests', 0)

    % Number of screens Psychtoolbox can recognize
    env.screens = Screen('Screens'); 

    % Which screen we will use, usually set to highest number to select
    % external screen if present, otherwise use native screen
    env.screenNumber = max(env.screens);

    % define white, black and grey
    env.white = WhiteIndex(env.screenNumber);
    env.black = BlackIndex(env.screenNumber); 
    env.grey = env.white / 2;
    
    PsychDebugWindowConfiguration %%%%%% DEBUG ONLY
    % Open an on-screen window
    [win.ptr, win.rect] = PsychImaging('OpenWindow', env.screenNumber, env.black);
    % Window dimension, in pixels
    [env.screenXpixels, env.screenYpixels] = Screen('WindowSize', win.ptr);
    % Center of the window, in pixels
    [env.xCenter, env.yCenter] = RectCenter(win.rect);

    % Get screen timing
    env.ifi = Screen('GetFlipInterval', win.ptr); % inter-frame interval
    env.FR = round(1/env.ifi); % frame rate
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', win.ptr, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');


return