function visualDegree = pix2visualDegree(pixels, screenWidthPx, screenWidthCm, viewingDistanceCm)
    % Convert a pixel value to visual degrees.
    %
    % Parameters:
    %   pixels (float) - The number of pixels to convert.
    %   screenWidthPx (int) - The width of the screen in pixels.
    %   screenWidthCm (float) - The width of the screen in centimeters.
    %   viewingDistanceCm (float) - The distance from the observer to the screen in centimeters.
    %
    % Returns:
    %   visualDegree (float) - The visual angle in degrees.

    % Calculate the size of one pixel in centimeters
    pixelSizeCm = screenWidthCm / screenWidthPx;

    % Convert pixel distance to centimeters
    distanceCm = pixels * pixelSizeCm;

    % Calculate the visual angle in radians
    visualAngleRad = 2 * atan((distanceCm / 2) / viewingDistanceCm);

    % Convert the visual angle from radians to degrees
    visualDegree = rad2deg(visualAngleRad);
end
