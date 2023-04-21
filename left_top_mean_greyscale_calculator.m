function [mean_greyscale, mean_greyscale_whole, ratio, std_diff] = left_top_mean_greyscale_calculator(img, ROI_msk, perc, ifshow)
    % this function calculates the mean greyscale-value around the left-top
    % corner. Radius is defined by perc. Note that img must be greyscaled


    bina_mask = bina(ROI_msk, 50);

    % get the coordinate of the left-top point
    [ltp, rtp, lbp, rbp] = corner_coordinate_calculator(ROI_msk);

    % get the radius of the searching area
    radius = perc * abs(ltp(1) - lbp(1));

    % get the set of points in the searching area
    point_set = zeros(0, 2);
    pslen = 0;  % size of the point set

    msksz = size(bina_mask);
    row = msksz(1);
    col = msksz(2);

    % stores the mean greyscale for the whole body
    sigma_gs_whole = 0;
    body_pixel_count = 0;

    for i = 1: row
        for j = 1: col

            if bina_mask(i, j) ~= 0 

                
                sigma_gs_whole = sigma_gs_whole + double(img(i, j));
                
                body_pixel_count = body_pixel_count + 1;

                % see if it's in the searching area

                if (i - ltp(1))^2 + (j - ltp(2))^2 < radius^2
                    point_set(pslen + 1, 1) = i;
                    point_set(pslen + 1, 2) = j;

                

                    pslen = pslen + 1;

                end

            end

        end
    end

    % calculate the mean greyscale value
    sigma_gs = 0;

    for k = 1: pslen

        i = point_set(k, 1);
        j = point_set(k, 2);

        sigma_gs = sigma_gs + double(img(i, j));


    end

    mean_greyscale = sigma_gs / pslen;
    mean_greyscale_whole = sigma_gs_whole / body_pixel_count;

    ratio = mean_greyscale / mean_greyscale_whole;



    % calculate the sample standard deviation of the greyscale-value of the
    % whole body
    term = 0;
    for i = 1: row
        for j = 1: col

            if bina_mask(i, j) ~= 0 
                
                term = term + (double(img(i, j)) - mean_greyscale_whole)^2;

            end

        end
    end

    sd_whole = sqrt(term / body_pixel_count);

    % take the standardized difference between the left-top corner and the
    % body
    std_diff = (mean_greyscale - mean_greyscale_whole) / sd_whole;
    

    % demonstrate the searching area

    if ifshow
        imshow(img);

        hold on;

        for k = 1: pslen
            plot(point_set(k, 2), point_set(k, 1), 'r+', 'MarkerSize', 5, 'LineWidth', 3);

            hold on;

        end

   

    end




end