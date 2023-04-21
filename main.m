score_dataset = zeros(0, 2);
score_dataset_len = 0;

for i = 51: 52
    
    ROI_mask_file = strcat("F:\滑铁卢大学\proj\lqy\vertebra2\", num2str(i),'-1.png');
    img_file = strcat("F:\滑铁卢大学\proj\lqy\vertebra2\", num2str(i),'-2.png');

    %{
    ROI_msk = rgb2gray(imread(ROI_mask_file));
    img = rgb2gray(imread(img_file));

    %}

    ROI_msk = imread(ROI_mask_file);
    img = imread(img_file);


    % calculate the bridge distance-ratio and area-ratio
    [bridge_to_body_ratio_top, dist_ratio_top] = top_bridge_to_body_ratio_calculator(ROI_msk, 0.5, 1);
    export_fig(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " Ratio is ", num2str(dist_ratio_top)));


    % calculate the left-top angle
    [cos_theta, theta] = left_top_angle_fit_line_function(ROI_msk, 1);
    export_fig(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " Angle is ", num2str(theta)));

    clf('reset');

    tiledlayout(1,2)
    nexttile
    imshow(imread(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " Ratio is ", num2str(dist_ratio_top), ".png")));
    nexttile
    imshow(imread(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " Angle is ", num2str(theta), ".png")));
    

    % rank the score using the metrics
    score = -1;  % indicating errors
    if dist_ratio_top > 0.1603
        score = 3;

    elseif bridge_to_body_ratio_top > 0.0514
        score = 2;

    elseif theta > 82.47
        score = 1;

    else
        score = 0;



    end

    % update the dataset
    score_dataset(score_dataset_len + 1, 1) = i;
    score_dataset(score_dataset_len + 1, 2) = score;
    score_dataset_len = score_dataset_len + 1;




    export_fig(strcat("F:\滑铁卢大学\proj\lqy\score results\", num2str(i), " Score is ", num2str(score)));
    
    
    clf('reset');




end





