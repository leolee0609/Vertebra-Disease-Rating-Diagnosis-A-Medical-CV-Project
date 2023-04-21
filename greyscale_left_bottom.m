gs_dataset = zeros(0, 5);
gs_dataset_len = 0;

for i = 1: 1
    
    ROI_mask_file = strcat("F:\滑铁卢大学\proj\lqy\vertebra2\", num2str(i),'-1.png');
    img_file = strcat("F:\滑铁卢大学\proj\lqy\vertebra2\", num2str(i),'-2.png');

    ROI_msk = rgb2gray(imread(ROI_mask_file));
    img = rgb2gray(imread(img_file));


    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    text_position_rev = ltp + [-180, -180];
    text_position(1) = text_position_rev(2);
    text_position(2) = text_position_rev(1);



    clf('reset');

    [mean_greyscale, mean_greyscale_whole, ratio, std_diff] = left_bottom_mean_greyscale_calculator(img, ROI_msk, 0.3, 1);

    export_fig(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " mean greyscale is ", num2str(mean_greyscale)));

    output_result = imread(strcat("F:\滑铁卢大学\proj\lqy\temp\", num2str(i), " mean greyscale is ", num2str(mean_greyscale), ".png"));

    output_result = insertText(output_result, text_position, strcat("The SMD is ", num2str(std_diff), ", the ratio is ", num2str(ratio), "."));

    clf('reset');
    
    imshow(output_result);

    export_fig(strcat("F:\滑铁卢大学\proj\lqy\greyscale results left bottom\", num2str(i), " SMD is ", num2str(std_diff)));



    gs_dataset(gs_dataset_len + 1, 1) = i;
    gs_dataset(gs_dataset_len + 1, 2) = mean_greyscale;
    gs_dataset(gs_dataset_len + 1, 3) = mean_greyscale_whole;
    gs_dataset(gs_dataset_len + 1, 4) = ratio;
    gs_dataset(gs_dataset_len + 1, 5) = std_diff;
    gs_dataset_len = gs_dataset_len + 1;



end

