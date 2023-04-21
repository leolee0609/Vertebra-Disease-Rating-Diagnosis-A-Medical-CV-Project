

%img = rgb2gray(imread("F:\滑铁卢大学\proj\lqy\vertebra1\21-2.png"));
ROI_msk = rgb2gray(imread("F:\滑铁卢大学\proj\lqy\vertebra1\9-1.png"));

[cos_theta, theta] = left_bottom_corner_angle_calculator_simplified(ROI_msk, 0.1, 1);



% [a1, b1, training_set] = fit_straight_line_at_right_top_corners(ROI_msk, 0.5, 1);