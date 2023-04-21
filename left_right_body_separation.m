function [k, p] = left_right_body_separation(ROI_msk)
    % this function separates the body into a left part and a right part
    % equally. It returns two coefficients of a line. The line y = kx + p
    % separates the body evenly, where (0, 0) is the left-top point of the
    % whole image. The x-axis is row and the y-axis is column.

    % get the corner coordinates
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    % get the slope of the body's left side
    k = (ltp(2) - lbp(2)) / (ltp(1) - lbp(1));


    % get the coordinator of the body's center point
    ctp = center_coordinate_calculator(ROI_msk);


    % Based on the fact that the separation line passes the center point,
    % we get b
    p = ctp(2) - k * ctp(1);

    % handle an exception: When a is too big, it's regarded as a horizontal
    % line. Should change p, k to common sense
    if p > 1000
        p = 0;
        k = ctp(2);
    end



end