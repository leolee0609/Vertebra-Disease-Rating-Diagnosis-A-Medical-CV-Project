function [a1, b1, training_set] = fit_straight_line_at_right_corner_over_top_outline(ROI_msk, perc, ifshow)
    % this function returns the coefficients of the tangent line at the
    % right-top point over the top outline, which is obtained using
    % linear regression. We first get
    % the closest perc% points to the right-top point on the top
    % body-outline. Then, we use the points as the traning set of a linear
    % regression model.


    % get the body outline
    [top_outline, bottom_outline, left_outline, right_outline] = outline_calculator(ROI_msk, 0);

    % get the corner points' coordinates
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);



    % find the top col_count closest points on the top outline
    top_outline_size = size(top_outline);
    top_outline_size = top_outline_size(1);


    % how many points are we considering for training the linear regr?
    col_count = floor(perc * top_outline_size);
    remaining_set = top_outline;

    % starting searching for the training set for the linear regr
    training_set = zeros(col_count, 2);

    for k = 1: col_count
        remaining_count = size(remaining_set);
        remaining_count = remaining_count(1);
        cur_closest = [999999, 999999];
        cur_closest_dist = 99999999999;

        % search for the closest point to the right-top point in the
        % remaining set of top outline points

        for t = 1: remaining_count
            dis = sqrt((remaining_set(t, 1) - rtp(1))^2 + (remaining_set(t, 2) - rtp(2))^2);
            if dis < cur_closest_dist
                cur_closest_dist = dis;
                cur_closest = [remaining_set(t, 1), remaining_set(t, 2)];


            end



        end

        % successfully obtained the closest one. Add it to our training set

        training_set(k, 1) = cur_closest(1);
        training_set(k, 2) = cur_closest(2);

        % update the remaining set by popping out the current point we got

        new_remaining_set = zeros(0, 2);
        new_set_len = 0;

        for t = 1: remaining_count

            if (remaining_set(t, 1) ~= cur_closest(1)) || (remaining_set(t, 2) ~= cur_closest(2))
                new_remaining_set(new_set_len + 1, 1) = remaining_set(t, 1);
                new_remaining_set(new_set_len + 1, 2) = remaining_set(t, 2);

                new_set_len = new_set_len + 1;

            end



        end

        remaining_set = new_remaining_set;
        


    end

    N = size(training_set);
    N = N(1);

    if ifshow

        for k = 1: N
            plot(training_set(k, 2), training_set(k, 1), 'g+', 'MarkerSize', 5, 'LineWidth', 3);

        end

    end


    %{
    % calculate the quantities forming coeffieint a and b

    % we hope to predict x using y, so the linear regression expression
    % is x = b*y + a

    N = size(training_set);
    N = N(1);


    sigma_xy = 0;

    for i = 1: N
        sigma_xy = sigma_xy + training_set(i, 1) * training_set(i, 2);


    end

    sigma_x = 0;

    for i = 1: N
        sigma_x = sigma_x + training_set(i, 2);


    end

    sigma_y = 0;

    for i = 1: N
        sigma_y = sigma_y + training_set(i, 1);


    end

    sigma_y_sq = 0;

    for i = 1: N
        sigma_y_sq = sigma_y_sq + training_set(i, 2)^2;


    end

    % calculate the coefficient a
    a = (sigma_x * sigma_y_sq - sigma_y * sigma_xy) / (N * sigma_y_sq - sigma_y^2);

    % calculate the coefficient b
    b = (N * sigma_xy - sigma_x * sigma_y) / (N * sigma_y_sq - sigma_y^2);

    a1 = 1/b;
    b1 = -a/b;

    %}

    % use support-vector way of defining the regression loss function

    % train the linear model using the training set
    feature = training_set(:, 1);
    label = training_set(:, 2);
    [a1, b1] = novel_linear_regression_trainer(feature, label);



    if ifshow
        imshow(ROI_msk);

        hold on;

        for k = 1: N
        plot(training_set(k, 2), training_set(k, 1), 'g+', 'MarkerSize', 5, 'LineWidth', 3);

        end

        hold on;
        draw_line(ROI_msk, a1, b1);

   

    end



end