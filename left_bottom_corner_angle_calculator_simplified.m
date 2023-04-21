function [cos_theta, theta, a1, b1, a2, b2] = left_bottom_corner_angle_calculator_simplified(ROI_msk, perc, ifshow)
    % this function returns the angle of the left-bottom corner. The point
    % at the perc%-th place above the left-bottom point on the left outline
    % is used to define the secant line we use to get the angle.
    % Same thing for the bottom outline.

    
    % find the point on the left outline
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);
    [top_outline, bottom_outline, left_outline, right_outline] = outline_calculator(ROI_msk, 0);

    losz = size(left_outline);
    losz = losz(1);

    bosz = size(bottom_outline);
    bosz = bosz(1);

    % find the q'th closest points we want from the left-bottom point
    q_lo = perc * losz;
    remaining_set = left_outline;

    lopt = [99999, 999999999];  % the point we want on the left outline

    for k = 1: q_lo
        closest_dist = 9999999999999;
        closest_rspt = [999999999, 999999999];

        rssz = size(remaining_set);
        rssz = rssz(1);
        
        for t = 1: rssz

            % find the closest point to the left-bottom point in the
            % remaining set

            t_rspt = [remaining_set(t, 1), remaining_set(t, 2)];

            dist = norm(t_rspt - lbp);

            if dist < closest_dist
                closest_dist = dist;
                closest_rspt = t_rspt;


            end

        end

        % pop out the closest point from the remaining set
        new_remaining_set = zeros(0, 2);
        new_remaining_set_sz = 0;

        for t = 1: rssz

            if remaining_set(t, 1) ~= closest_rspt(1) || remaining_set(t, 2) ~= closest_rspt(2)

                new_remaining_set(new_remaining_set_sz + 1, 1) = remaining_set(t, 1);
                new_remaining_set(new_remaining_set_sz + 1, 2) = remaining_set(t, 2);
                new_remaining_set_sz = new_remaining_set_sz + 1;

            end

        end

        remaining_set = new_remaining_set;
        lopt = closest_rspt;

    end





    q_bo = perc * bosz;
    remaining_set = bottom_outline;

    bopt = [99999, 999999999];  % the point we want on the bottom outline

    for k = 1: q_bo
        closest_dist = 9999999999999;
        closest_rspt = [999999999, 999999999];

        rssz = size(remaining_set);
        rssz = rssz(1);
        
        for t = 1: rssz

            % find the closest point to the left-bottom point in the
            % remaining set

            t_rspt = [remaining_set(t, 1), remaining_set(t, 2)];

            dist = norm(t_rspt - lbp);

            if dist < closest_dist
                closest_dist = dist;
                closest_rspt = t_rspt;


            end

        end

        % pop out the closest point from the remaining set
        new_remaining_set = zeros(0, 2);
        new_remaining_set_sz = 0;

        for t = 1: rssz

            if remaining_set(t, 1) ~= closest_rspt(1) || remaining_set(t, 2) ~= closest_rspt(2)

                new_remaining_set(new_remaining_set_sz + 1, 1) = remaining_set(t, 1);
                new_remaining_set(new_remaining_set_sz + 1, 2) = remaining_set(t, 2);
                new_remaining_set_sz = new_remaining_set_sz + 1;

            end

        end

        remaining_set = new_remaining_set;
        bopt = closest_rspt;

    end

    

    % calculate the vectors
    hori_vector = bopt - lbp;
    vert_vector = lopt - lbp;

    % calculate cos_theta
    cos_theta = (hori_vector * vert_vector') / (norm(hori_vector) * norm(vert_vector));

    theta = (acos(cos_theta) / pi) * 180;


    if ifshow

        [a1, b1] = line_function(lbp, bopt);
        [a2, b2] = line_function(lbp, lopt);

        point_set1 = draw_line(ROI_msk, a1, b1);

        point_set2 = draw_line(ROI_msk, a2, b2);

        szps1 = size(point_set1);
        szps1 = szps1(1);

        szps2 = size(point_set2);
        szps2 = szps2(1);

        imshow(ROI_msk);

        hold on;

        for k = 1: szps1
    
            plot(point_set1(k, 2), point_set1(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);

            hold on;

        end

        for k = 1: szps2
    
            plot(point_set2(k, 2), point_set2(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);

            hold on;

        end

        

    end


end