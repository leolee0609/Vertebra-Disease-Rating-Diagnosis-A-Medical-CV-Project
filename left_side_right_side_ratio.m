function ratio = left_side_right_side_ratio(ROI_msk)
    % the function calculates left-side length / right-side length

    % get the corner-point coordinates
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);
    
    % calculate the left-side length
    lsl = sqrt((ltp(1) - lbp(1))^2 + (ltp(2) - lbp(2))^2);

    % calculate the right-side length
    rsl = sqrt((rtp(1) - rbp(1))^2 + (rtp(2) - rbp(2))^2);

    % calculate the ratio
    ratio = lsl / rsl;



end