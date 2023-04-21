function [cos_theta, theta, a3, b3, a4, b4] = right_top_corner_angle_calculator(ROI_msk, perc, ifshow)
    % this function returns the angle of the right-top corner. perc% points
    % will be used to fit the tangent lines at the right-top corner.


    % get the fitted tangent lines at the right-top corner
    [a3, b3, training_set] = fit_straight_line_at_right_corner_over_top_outline(ROI_msk, perc, 0);
    [a4, b4, training_set] = fit_straight_line_at_right_top_corner_along_right_outline(ROI_msk, perc, 0);

    % get the coordinate of the right-top point
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);


    % get one point on the horizontal tangent line
    pt_on_hori = [(1 / a3) * (rtp(2) - 10) - b3 / a3, rtp(2) - 10];

    % get one point on the vertical tangent line
    pt_on_vert = [rtp(1) + 10, a4 * (rtp(1) + 10) + b4];

    % get the vector formed by right-top point and the point on the horizontal tangent line
    hori_vector = pt_on_hori - rtp;

    % get the vertical one
    vert_vector = pt_on_vert - rtp;

    % calculate cos_theta
    cos_theta = (hori_vector * vert_vector') / (norm(hori_vector) * norm(vert_vector));

    theta = (acos(cos_theta) / pi) * 180;

    if ifshow

        point_set1 = draw_line(ROI_msk, a3, b3);

        point_set2 = draw_line(ROI_msk, a4, b4);

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