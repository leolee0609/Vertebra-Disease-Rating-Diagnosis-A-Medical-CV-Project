function [bridge_to_body_ratio, dist_ratio] = top_bridge_to_body_ratio_calculator(ROI_msk, q, ifshow)
    % this function returns the bridge-like area / body area at the
    % left-top corner. We only consider the q% regions around the left-top
    % corner

    % obtain the corner point coordinates
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    % get the fitted tangent line at the right-top corner over the top part
    % of the body outline
    [a1, b1, training_set] = fit_straight_line_at_right_corner_over_top_outline(ROI_msk, 0.7, 0);

    % get the 100p% left-top pixels that we care
    top_col_count = abs(rtp(2) - ltp(2));
    radius = q * top_col_count;  % radius of the circle within which are pixels we care about

    % get the binary mask of ROI_msk
    bina_mask = bina(ROI_msk, 50);

    % get # pixels of the body
    msk_sz = size(bina_mask);
    mskrow = msk_sz(1);
    mskcol = msk_sz(2);

    body_pixel_count = 0;  % # body pixels
    bridge_pixel_count = 0;  % # bridge pixels
    bridge_pixels = zeros(0, 2);  % stores all bridge pixels

    for i = 1: mskrow
        for j = 1: mskcol

            if bina_mask(i, j) ~=0

                body_pixel_count = body_pixel_count + 1;

                if ((i - ltp(1))^2 + (j - ltp(2))^2 <= radius^2) && (i < (1 / a1) * j - b1 / a1)

                    bridge_pixel_count = bridge_pixel_count + 1;
                    bridge_pixels(bridge_pixel_count, 1) = i;
                    bridge_pixels(bridge_pixel_count, 2) = j;

                end

            end
        end

    end

    bridge_to_body_ratio = bridge_pixel_count / body_pixel_count;

    

    % calculate the distance between the furthest bridge pixel to the
    % fitted tangent line at the right-top corner over the top outline
    fur = [bridge_pixels(1, 1), bridge_pixels(1, 2)];
    fur_dist = 0;

    for k = 1: bridge_pixel_count
            x = bridge_pixels(k, 1);
            y = bridge_pixels(k, 2);
            cur_dist = abs(a1 * x - y + b1) / sqrt((a1^2 + 1));

            if cur_dist > fur_dist

                fur_dist = cur_dist;
                fur = [x, y];

            end

    end



    % get the fitted tangent line along the bottom
    [a2, b2, training_set] = fit_straight_line_at_right_corner_along_bottom_outline(ROI_msk, 0.7, 0);

    dist_fur_bottom = abs(a2 * fur(1) - fur(2) + b2) / sqrt((a2^2 + 1));


    dist_ratio = fur_dist / dist_fur_bottom;

    if ifshow

        imshow(ROI_msk);

        hold on;

        for k = 1: bridge_pixel_count
            plot(bridge_pixels(k, 2), bridge_pixels(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);
            hold on;

        end

        plot(fur(2), fur(1), 'g+', 'MarkerSize', 2, 'LineWidth', 2);

    end
    


end