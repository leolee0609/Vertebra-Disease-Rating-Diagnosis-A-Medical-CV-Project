function ratio = top_ratio(ROI_msk)
    % this function calculates the ratio of left-side length / mid-line length
    % of the upper part of the body

    bina_mask = ROI_msk;


    sz = size(ROI_msk);

    row = sz(1);
    col = sz(2);

    % make ROI_msk binary, where the threshold is 50
    for p = 1: row
        for k = 1: col
            if ROI_msk(p, k) < 50
                bina_mask(p, k) = 0;


            else
                bina_mask(p, k) = 255;

            end


        end

    end
    
    % get the left-top corner point
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    % get the coefficients of the line y = ax + b separating the body
    % evenly
    [a, b] = top_bottom_body_separation(ROI_msk);


    % calculate the point-to-line distance between the left-top point to
    % the line y = ax + b, and this is the left-side length

    if a > 1000
        % in this case, a is too big, so it is regarded as a horizontal.
        lsl = abs(ltp(2) - b);
    else
        lsl = abs(a * ltp(1) - ltp(2) + b) / sqrt(a^2 + 1);
    end



    % get the formula of the mid-line
    [k, p] = left_right_body_separation(ROI_msk);

    % get the coordinate of the center point
    ctp = center_coordinate_calculator(ROI_msk);

    % get all the points on the line in the whole image
    point_set = draw_line(ROI_msk, k, p);

    % get all the points on the line within the body
    intersect_set = zeros(0, 2);
    int_set_len = 0;

    sz = size(point_set);
    all_set_len = sz(1);

    for k = 1: all_set_len
        i = point_set(k, 1);
        j = point_set(k, 2);

        if bina_mask(i, j) ~= 0
            intersect_set(int_set_len + 1, 1) = i;
            intersect_set(intersect_set + 1, 2) = j;

            int_set_len = int_set_len + 1;


        end



    end

    % calculate the mid-line length and the mid-top point
    mll = 999999999;
    mtp = [9999, 9999];

    for k = 1: int_set_len
        i = intersect_set(k, 1);
        j = intersect_set(k, 2);

        dist_cent_mtp = sqrt((i - ctp(1))^2 + (j - ctp(2))^2);

        if dist_cent_mtp < mll
            mll = dist_cent_mtp;
            mtp = [i, j];

        end


    end


    

    % calculate the ratio
    ratio = lsl / mll;

    imshow(ROI_msk);

    plot(mtp(2), mtp(1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);





end