dataset = zeros(0, 3);
dataset_len = 0;

for i = 27: 52
    ROI_mask_file = strcat("F:\滑铁卢大学\proj\lqy\vertebra1\", num2str(i),'.png');
    ROI_msk = imread(ROI_mask_file);


    [cos_theta, theta, a1, b1, a2, b2] = left_bottom_corner_angle_calculator_simplified(ROI_msk, 0.1, 1);

    % update the dataset
    dataset(dataset_len + 1, 1) = i;
    dataset(dataset_len + 1, 2) = cos_theta;
    dataset(dataset_len + 1, 3) = theta;

    dataset_len = dataset_len + 1;

    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    output_img = ROI_msk;

    text_position_rev = lbp + [50, -50];
    text_position(1) = text_position_rev(2);
    text_position(2) = text_position_rev(1);

    output_img = insertText(output_img, text_position, strcat("cos_theta is ", num2str(cos_theta), newline, "theta is ", num2str(theta)));

    clf('reset');

    imshow(output_img);

    hold on;

    % draw the lines
    point_set1 = draw_line(ROI_msk, a1, b1);

    hold on;

    point_set2 = draw_line(ROI_msk, a2, b2);

    %{

    pssz1 = size(point_set1);
    pssz1 = pssz1(1);

    pssz2 = size(point_set2);
    pssz2 = pssz2(1);

    for k = 1: pssz1
        plot(point_set1(k, 2), point_set1(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);
        hold on;

    end

    for k = 1: pssz1
        plot(point_set1(k, 2), point_set1(k, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 2);
        hold on;

    end

    %}


    export_fig(strcat("F:\滑铁卢大学\proj\lqy\left bottom angle results\", num2str(i), " angle is ", num2str(theta)));


end