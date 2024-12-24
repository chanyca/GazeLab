function pixels = visualDegree2pix(visualDegree, screenWidthPx, screenWidthCm, viewingDistanceCm)
    % Convert a visual degree value to pixels.
    %
    % Parameters:
    %   visualDegree (float) - The visual angle in degrees to convert.
    %   screenWidthPx (int) - The width of the screen in pixels.
    %   screenWidthCm (float) - The width of the screen in centimeters.
    %   viewingDistanceCm (float) - The distance from the observer to the screen in centimeters.
    %
    % Returns:
    %   pixels (float) - The equivalent pixel value for the specified visual angle.

    % Calculate the size of one pixel in centimeters
    pixelSizeCm = screenWidthCm / screenWidthPx;

    % Convert visual degrees to radians
    visualAngleRad = deg2rad(visualDegree);

    % Calculate the distance in centimeters corresponding to the visual angle
    distanceCm = 2 * viewingDistanceCm * tan(visualAngleRad / 2);

    % Convert the distance in centimeters to pixels
    pixels = distanceCm / pixelSizeCm;
end
