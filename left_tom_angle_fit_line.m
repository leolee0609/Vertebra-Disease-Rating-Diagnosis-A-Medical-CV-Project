dataset = zeros(0, 3);
dataset_len = 0;

for i = 51: 52
    ROI_mask_file = strcat("F:\滑铁卢大学\proj\lqy\vertebra1\", num2str(i),'.png');
    % ROI_msk = rgb2gray(imread(ROI_mask_file));
    ROI_msk = imread(ROI_mask_file);

    % mirror-reverse the image
    ROI_msk = mirror_reverse(ROI_msk);



    [cos_theta, theta, a1, b1, a2, b2] = right_top_corner_angle_calculator(ROI_msk, 0.3, 1);

    % update the dataset
    dataset(dataset_len + 1, 1) = i;
    dataset(dataset_len + 1, 2) = cos_theta;
    dataset(dataset_len + 1, 3) = theta;

    dataset_len = dataset_len + 1;

    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    output_img = ROI_msk;

    

    

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

    export_fig(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " angle is ", num2str(theta)));
    output_img = imread(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " angle is ", num2str(theta), ".png"));

    output_img = mirror_reverse(output_img);

   

    ROI_msk = mirror_reverse(ROI_msk);
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    text_position_rev = lbp + [50, -50];
    text_position(1) = text_position_rev(2);
    text_position(2) = text_position_rev(1);



    clf('reset');
    imshow(output_img);



    output_img = insertText(output_img, text_position, strcat("cos_theta is ", num2str(cos_theta), newline, " theta is ", num2str(theta)));
    imshow(output_img);

    % export_fig(strcat("F:\滑铁卢大学\proj\lqy\left top angle results fit line method\", num2str(i), " angle is ", num2str(theta)));


end