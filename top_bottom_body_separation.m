function [a, b] = top_bottom_body_separation(ROI_msk)
    % this function separates the body into a top part and a bottom part
    % equally. It returns two coefficients of a line. The line y = ax + b
    % separates the body evenly, where (0, 0) is the left-top point of the
    % whole image. The x-axis is row and the y-axis is column.

    % get the corner coordinates
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    % get the slope of the body's left side
    k = (ltp(2) - lbp(2)) / (ltp(1) - lbp(1));

    % the separation line is perpendicular to the slope, so we get a
    a = -1 / k;

    % get the coordinator of the body's center point
    ctp = center_coordinate_calculator(ROI_msk);


    % Based on the fact that the separation line passes the center point,
    % we get b
    b = ctp(2) - a * ctp(1);

    % handle an exception: When a is too big, it's regarded as a horizontal
    % line. Should change a, b to common sense
    if a > 1000
        a = 0;
        b = ctp(2);
    end



end